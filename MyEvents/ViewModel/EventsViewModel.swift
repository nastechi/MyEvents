//
//  EventsViewModel.swift
//  MyEvents
//
//  Created by Анастасия on 07.02.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class EventsViewModel {
    
    var appCoordinator: AppCoordinator
    var events: BehaviorSubject<[Event]>
    var imageCache = NSCache<NSString, UIImage>()
    
    init(appCoordinator: AppCoordinator, events: BehaviorSubject<[Event]>) {
        self.appCoordinator = appCoordinator
        self.events = events
    }
    
    func fetchEvents() {
        guard let url = URL(string: "https://app.ticketmaster.com/discovery/v2/events.json?apikey=\(Keys.apiKey)") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else { return }
            if let newEvents = self?.parseJSON(data: data) {
                self?.events.on(.next(newEvents))
            }
        }
        task.resume()
    }
    
    func parseJSON(data: Data) -> [Event] {
        var events = [Event]()
        do {
            let decodedData = try JSONDecoder().decode(EventData.self, from: data)
            for i in 0..<decodedData._embedded.events.count {
                let name = decodedData._embedded.events[i].name
                let type = decodedData._embedded.events[i].type
                let imageUrl = getImageUrl(images: decodedData._embedded.events[i].images)
                let date = getDate(day: decodedData._embedded.events[i].dates.start.localDate, time: decodedData._embedded.events[i].dates.start.localTime)
                let event = Event(name: name, type: type, imageUrl: imageUrl, date: date, visited: false, going: false)
                events.append(event)
                if i > 20 { break }
            }
        } catch {
            print(error)
        }
        return events
    }
    
    func getImageUrl(images: [ImageData]?) -> String? {
        if images == nil || images!.isEmpty { return nil }
        for image in images! {
            if image.ratio != "16_9" {
                return image.url
            }
        }
        return images![0].url
    }
    
    func loadImage(with urlString: String?, complition: @escaping (_: UIImage) -> Void) {
        guard urlString != nil else { return }
        if let cachedImage = imageCache.object(forKey: urlString! as NSString) {
            complition(cachedImage)
            return
        }
        guard let url = URL(string: urlString!) else { return }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async { [weak self] in
                        self?.imageCache.setObject(image, forKey: urlString! as NSString)
                        complition(image)
                    }
                }
            }
        }
    }
    
    func getDate(day: String?, time: String?) -> Date? {
        if day == nil || time == nil { return nil }
        let dateStr = day! + time!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddHH-mm-ss"
        return dateFormatter.date(from: dateStr)
    }
    
    func goToDetailPage(for indexPath: IndexPath) {
        if var eventsArray = try? events.value() {
            let event = eventsArray[indexPath.row]
            if let imageUrl = event.imageUrl {
                let image = imageCache.object(forKey: imageUrl as NSString)
                appCoordinator.goToDetailPage(event: event, image: image, index: indexPath.row)
            } else {
                appCoordinator.goToDetailPage(event: event, image: nil, index: indexPath.row)
            }
            eventsArray[indexPath.row].visited = true
            events.onNext(eventsArray)
        }
    }
}

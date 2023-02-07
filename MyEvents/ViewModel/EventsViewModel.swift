//
//  EventsViewModel.swift
//  MyEvents
//
//  Created by Анастасия on 07.02.2023.
//

import Foundation
import RxSwift
import RxCocoa

class EventsViewModel {
    var events = BehaviorSubject(value: [Event]())
    
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
                let event = Event(name: name, type: type, imageUrl: imageUrl, date: date)
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
    
    func getDate(day: String?, time: String?) -> Date? {
        if day == nil || time == nil { return nil }
        let dateStr = day! + time!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddHH-mm-ss"
        return dateFormatter.date(from: dateStr)
    }
}

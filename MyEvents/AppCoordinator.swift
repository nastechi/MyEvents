//
//  AppCoordinator.swift
//  MyEvents
//
//  Created by Анастасия on 07.02.2023.
//

import UIKit
import RxSwift
import RxCocoa

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
}

class AppCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var events = BehaviorSubject(value: [Event]())
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToEventsPage()
        navigationController.isNavigationBarHidden = true
    }
    
    func goToEventsPage() {
        let eventsViewModel = EventsViewModel(appCoordinator: self, events: events)
        let eventsVC = EventsTableViewController(viewModel: eventsViewModel)
        
        navigationController.pushViewController(eventsVC, animated: true)
    }
    
    func goToDetailPage(event: Event, image: UIImage?, index: Int) {
        let viewModel = DetailViewModel(appCoordinator: self)
        let detailVC = DetailViewController(event: event, image: image, viewModel: viewModel, index: index)
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
    
    func goToEvent(with index: Int) {
        if var newEvents = try? events.value() {
            newEvents[index].going.toggle()
            events.onNext(newEvents)
        }
    }
}

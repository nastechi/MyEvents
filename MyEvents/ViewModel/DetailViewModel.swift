//
//  DetailViewModel.swift
//  MyEvents
//
//  Created by Анастасия on 07.02.2023.
//

import Foundation

class DetailViewModel {
    
    private let appCoordinator: AppCoordinator
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    func goBack() {
        appCoordinator.goBack()
    }
    
    func goToEvent(with index: Int) {
        appCoordinator.goToEvent(with: index)
    }
}

//
//  DetailViewModel.swift
//  MyEvents
//
//  Created by Анастасия on 07.02.2023.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel {
    
    private let appCoordinator: AppCoordinator
    
    var disposeBag = DisposeBag()
    
    let isGoing = BehaviorRelay<Bool>(value: false)
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    func goBack() {
        appCoordinator.goBack()
    }
    
    func goToEvent(with index: Int) {
        appCoordinator.goToEvent(with: index)
        var value = isGoing.value
        value.toggle()
        isGoing.accept(value)
    }
}

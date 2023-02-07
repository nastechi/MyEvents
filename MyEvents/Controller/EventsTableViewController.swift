//
//  ViewController.swift
//  MyEvents
//
//  Created by Анастасия on 07.02.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class EventsTableViewController: UIViewController {
    
    private let viewModel = EventsViewModel()
    private var disposeBag = DisposeBag()
    
    private lazy var eventsTableView: UITableView = {
        let tableView = UITableView(frame: view.frame)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(EventsTableViewCell.self, forCellReuseIdentifier: K.cellIndentifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchEvents()
        layoutView()
        bindTableView()
    }
    
    private func bindTableView() {
        eventsTableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.events.bind(to: eventsTableView.rx.items(cellIdentifier: K.cellIndentifier, cellType: EventsTableViewCell.self)) { row, item, cell in
            cell.setCell(with: item)
        }
        .disposed(by: disposeBag)
    }
    
    private func layoutView() {
        view.backgroundColor = .systemBackground
        view.addSubview(eventsTableView)
    }
}

extension EventsTableViewController: UIScrollViewDelegate {
    
}

extension EventsTableViewController: UITableViewDelegate {
    
}

//
//  ViewController.swift
//  MyEvents
//
//  Created by Анастасия on 07.02.2023.
//

import UIKit

class EventsTableViewController: UIViewController {
    
    let viewModel = EventsViewModel()
    
    private lazy var eventsTableView: UITableView = {
        let tableView = UITableView(frame: view.frame)
        tableView.register(EventsTableViewCell.self, forCellReuseIdentifier: K.cellIndentifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchEvents()
        layoutView()
    }
    
    func layoutView() {
        view.backgroundColor = .systemBackground
    }
}


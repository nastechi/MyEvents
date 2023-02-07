//
//  EventsTableViewCell.swift
//  MyEvents
//
//  Created by Анастасия on 07.02.2023.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    
    private lazy var visitedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 11, weight: .light)
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: K.cellIndentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(with event: Event) {
        nameLabel.text = event.name
        visitedLabel.text = getVisitedString(for: event.visited)
        layoutView()
    }
    
    func layoutView() {
        addSubview(visitedLabel)
        addSubview(nameLabel)
        setConstrains()
    }
    
    func setConstrains() {
        visitedLabel.translatesAutoresizingMaskIntoConstraints = false
        visitedLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        visitedLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        visitedLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        nameLabel.topAnchor.constraint(equalTo: visitedLabel.bottomAnchor, constant: 6).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
    
    func getVisitedString(for visited: Int) -> String {
        if visited == 1 {
            return "visited 1 time"
        } else {
            return "visited \(visited) times"
        }
    }
}

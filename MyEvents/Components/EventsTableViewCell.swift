//
//  EventsTableViewCell.swift
//  MyEvents
//
//  Created by Анастасия on 07.02.2023.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 11, weight: .light)
        return label
    }()
    
    private lazy var goingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = .systemFont(ofSize: 11, weight: .bold)
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cloud")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: K.cellIndentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(viewModel: EventsViewModel, row: Int) {
        if let event = try? viewModel.events.value()[row] {
            nameLabel.text = event.name
            if event.visited {
                nameLabel.textColor = .purple
            } else {
                nameLabel.textColor = .blue
            }
            if let date = event.date {
                dateLabel.text = getDateString(date: date)
            }
            viewModel.loadImage(with: event.imageUrl) { [weak self] image in
                self?.eventImageView.image = image
            }
            if event.going {
                goingLabel.text = "I'm going"
            } else {
                goingLabel.text = nil
            }
        }
        layoutView()
    }
    
    func layoutView() {
        addSubview(dateLabel)
        addSubview(nameLabel)
        addSubview(eventImageView)
        addSubview(goingLabel)
        setConstrains()
    }
    
    func setConstrains() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        
        goingLabel.translatesAutoresizingMaskIntoConstraints = false
        goingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        goingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        nameLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 6).isActive = true
        
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        eventImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        eventImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6).isActive = true
        eventImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        eventImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        eventImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
    
    func getDateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM, HH:mm"
        return dateFormatter.string(from: date)
    }
}

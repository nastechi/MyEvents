//
//  DetailViewController.swift
//  MyEvents
//
//  Created by Анастасия on 07.02.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let viewModel: DetailViewModel
    private let event: Event
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = event.name
        label.font = .systemFont(ofSize: 21, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return button
    }()
    
    init(event: Event, viewModel: DetailViewModel) {
        self.event = event
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layoutView()
    }
    
    @objc private func backButtonPressed() {
        viewModel.goBack()
    }
    
    private func layoutView() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        setConstrains()
    }
    
    private func setConstrains() {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
}

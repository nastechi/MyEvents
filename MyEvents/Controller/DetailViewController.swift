//
//  DetailViewController.swift
//  MyEvents
//
//  Created by Анастасия on 07.02.2023.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    
    private let viewModel: DetailViewModel
    private let event: Event
    private let eventIndex: Int
    
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
    
    private lazy var eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var goingButton: UIButton = {
        let button = UIButton()
        button.setTitle("I'm going!", for: .normal)
        button.addTarget(self, action: #selector(goingButtonPressed), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        return button
    }()
    
    private func bind() {
        viewModel.isGoing.asObservable().subscribe { [weak self] going in
            if going {
                self?.goingButton.backgroundColor = .secondarySystemFill
                self?.goingButton.setTitleColor(.blue, for: .normal)
                self?.goingButton.setTitle("You are already going", for: .normal)
            } else {
                self?.goingButton.backgroundColor = .blue
                self?.goingButton.setTitleColor(.white, for: .normal)
                self?.goingButton.setTitle("I'm going!", for: .normal)
            }
        }
        .disposed(by: viewModel.disposeBag)
    }
    
    init(event: Event, image: UIImage?, viewModel: DetailViewModel, index: Int) {
        self.event = event
        self.viewModel = viewModel
        self.eventIndex = index
        viewModel.isGoing.accept(event.going)
        super.init(nibName: nil, bundle: nil)
        eventImageView.image = image
        bind()
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
    
    @objc private func goingButtonPressed() {
        viewModel.goToEvent(with: eventIndex)
    }
    
    private func layoutView() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(eventImageView)
        view.addSubview(goingButton)
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
        
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        eventImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        eventImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6).isActive = true
        eventImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        eventImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        goingButton.translatesAutoresizingMaskIntoConstraints = false
        goingButton.topAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: 6).isActive = true
        goingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        goingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
}

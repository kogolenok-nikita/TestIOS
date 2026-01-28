//
//  MainViewController.swift
//  TestIOS
//
//  Created by Никита Коголенок on 28.01.26.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    
}

class MainViewController: UIViewController {
    
    // MARK: - Variable
    private let presenter: MainPresenterProtocol
    
    // MARK: - GUI Variable
    private let mainLabel = UILabel()
    
    // MARK: - Init
    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        presenter.attachView(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }
    // MARK: - Methods
    private func setupView() {
        view.backgroundColor = .systemBackground
        mainLabel.text = "Main Label"
        mainLabel.textColor = .red
        mainLabel.textAlignment = .center
        mainLabel.font = .systemFont(ofSize: 20, weight: .bold)
        mainLabel.numberOfLines = 0
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainLabel)
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - MainViewController: MainViewProtocol
extension MainViewController: MainViewProtocol {
    
}

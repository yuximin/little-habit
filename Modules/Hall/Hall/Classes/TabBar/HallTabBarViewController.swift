//
//  HallTabBarViewController.swift
//  Mediator
//
//  Created by apple on 2024/4/2.
//

import UIKit
import Mediator
import Mediator_Triviality

class HallTabBarViewController: UITabBarController {
    
    private let hallTabBarItem: [HallTabBarItem] = [.habit, .triviality, .me]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupControllers()
    }
    
    // MARK: - UI
    
    private func setupUI() {
        self.view.backgroundColor = .white
    }
    
    private func setupControllers() {
        for item in self.hallTabBarItem {
            let viewController: UIViewController
            switch item {
            case .habit:
                viewController = UIViewController()
                viewController.view.backgroundColor = .white
            case .triviality:
                viewController = Mediator.shared.triviality.trivialityViewController()
            case .me:
                viewController = UIViewController()
                viewController.view.backgroundColor = .white
            }
            viewController.title = item.title
            let navigationController = UINavigationController(rootViewController: viewController)
            self.addChild(navigationController)
        }
    }
}

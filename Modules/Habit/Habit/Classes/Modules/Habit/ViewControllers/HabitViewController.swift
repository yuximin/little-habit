//
//  HabitViewController.swift
//  Habit
//
//  Created by apple on 2024/4/8.
//

import UIKit
import Theme

class HabitViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - UI
    
    private func setupUI() {
        self.view.backgroundColor = Theme.themeColor.normal
    }

}

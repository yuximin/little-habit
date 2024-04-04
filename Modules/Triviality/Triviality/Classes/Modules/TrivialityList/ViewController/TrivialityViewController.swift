//
//  TrivialityViewController.swift
//  Triviality
//
//  Created by apple on 2024/4/4.
//

import UIKit

class TrivialityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Lazy View
    
    private lazy var contentView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

}

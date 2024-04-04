//
//  TrivialityViewController.swift
//  Triviality
//
//  Created by apple on 2024/4/4.
//

import UIKit
import SnapKit

class TrivialityViewController: UIViewController {
    
    private let viewModel = TrivialityViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - UI
    
    private func setupUI() {
        self.view.backgroundColor = "#FFF8E7".color
        self.navigationController?.navigationBar.barTintColor = "#FFF8E7".color
        
        self.navigationItem.title = nil
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.titleLabel)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.addButton)
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Lazy View
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "小事"
        label.textColor = "#333333".color
        label.font = 20.font(weight: .semibold)
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let image = UIImage(systemName: "plus.circle.fill")?.withTintColor("#000000".color, renderingMode: .alwaysOriginal)
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(didTapAddButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(reusableCell: TrivialityListCell.self)
        return tableView
    }()

}

// MARK: - Action
extension TrivialityViewController {
    @objc private func didTapAddButton(_ sender: UIButton) {
        let index = self.viewModel.items.count
        let time = Date().timeIntervalSince1970
        let item = TrivialityItemModel(id: "\(index)", icon: "", title: "小事\(index)", description: "记录记录", lastRecodeTime: time)
        self.viewModel.addItem(item)
        self.tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension TrivialityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.viewModel.items[indexPath.row]
        let cell: TrivialityListCell = tableView.dequeueReusableCell(for: indexPath)
        cell.model = model
        return cell
    }
    
}

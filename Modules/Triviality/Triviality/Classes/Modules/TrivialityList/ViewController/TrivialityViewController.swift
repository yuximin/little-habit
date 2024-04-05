//
//  TrivialityViewController.swift
//  Triviality
//
//  Created by apple on 2024/4/4.
//

import UIKit
import SnapKit
import Theme
import XMKit

class TrivialityViewController: UIViewController {
    
    private let viewModel = TrivialityViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - UI
    
    private func setupUI() {
        self.view.backgroundColor = Theme.themeColor.normal
        self.navigationController?.navigationBar.barTintColor = Theme.themeColor.normal
        
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
        label.textColor = Theme.textColor.primary
        label.font = Theme.font.navTitle
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let image = UIImage(systemName: "plus.circle.fill")?.withTintColor(Theme.textColor.primary, renderingMode: .alwaysOriginal).resized(to: CGSize(width: 30, height: 30))
        let button = UIButton()
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(didTapAddButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = 80
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(reusableCell: TrivialityListCell.self)
        return tableView
    }()

}

// MARK: - Action
extension TrivialityViewController {
    @objc private func didTapAddButton(_ sender: UIButton) {
        let viewController = TrivialityEditorViewController(editorType: .create)
        viewController.saveAction = { [weak self] model in
            self?.viewModel.addItem(model)
            self?.tableView.reloadData()
        }
        self.present(viewController, animated: true)
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
        cell.delegate = self
        cell.model = model
        return cell
    }
    
}

// MARK: - TrivialityListCellDelegate
extension TrivialityViewController: TrivialityListCellDelegate {
    func trivialityListCellDidSelectRecord(_ cell: TrivialityListCell) {
        // TODO: @whaley 添加记录
        print("whaley log -- 添加记录")
    }
}

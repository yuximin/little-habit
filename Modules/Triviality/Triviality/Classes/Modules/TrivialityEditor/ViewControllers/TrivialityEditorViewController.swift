//
//  TrivialityEditorViewController.swift
//  Triviality
//
//  Created by apple on 2024/4/4.
//

import UIKit
import Theme
import XMKit
import SnapKit

class TrivialityEditorViewController: UIViewController {
    
    var saveAction: ((TrivialityItemModel) -> Void)?
    
    private let viewModel: TrivialityEditorViewModel
    
    // MARK: - Lifecycle
    
    init(editorType: TrivialityEditorType) {
        self.viewModel = TrivialityEditorViewModel(editorType: editorType)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - UI
    
    private func setupUI() {
        self.view.backgroundColor = Theme.themeColor.normal
        
        self.view.addSubview(topBar)
        topBar.addSubview(closeButton)
        topBar.addSubview(titleLabel)
        topBar.addSubview(saveButton)
        self.view.addSubview(tableView)
        
        topBar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        closeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 26, height: 26))
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(15)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.greaterThanOrEqualTo(closeButton.snp.trailing).offset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topBar.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Lazy View
    
    private lazy var topBar: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Theme.image.navBarClose, for: .normal)
        button.addTarget(self, action: #selector(didTapCloseButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "编辑小事"
        label.textColor = Theme.textColor.primary
        label.font = Theme.font.navTitle
        return label
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("保存", for: .normal)
        button.setTitleColor(Theme.textColor.primary, for: .normal)
        button.titleLabel?.font = Theme.font.navItem
        button.addTarget(self, action: #selector(didTapSaveButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(reusableCell: TrivialityEditorIconCell.self)
        tableView.register(reusableCell: TrivialityEditorTextFieldCell.self)
        return tableView
    }()

}

// MARK: - Action
extension TrivialityEditorViewController {
    @objc private func didTapCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @objc private func didTapSaveButton(_ sender: UIButton) {
        let editorItemValues = getAllEditorItemValues()
        self.viewModel.executeSave(editorItemValues: editorItemValues) { success, error, item in
            guard success, let item else {
                print("error:", error?.localizedDescription ?? "no reasonal")
                return
            }
            
            self.saveAction?(item)
            self.dismiss(animated: true)
        }
    }
}

// MARK: - Private
private extension TrivialityEditorViewController {
    
    func getAllEditorItemValues() -> [TrivialityEditorItem: Any?] {
        var values: [TrivialityEditorItem: Any?] = [:]
        for item in self.viewModel.editorItems {
            let value = self.getEditorItemValue(for: item)
            values[item] = value
        }
        return values
    }
    
    func getEditorItemValue(for item: TrivialityEditorItem) -> Any? {
        guard let index = self.viewModel.editorItems.firstIndex(of: item),
              let cell = self.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? TrivialityEditorCell else {
            return nil
        }
        
        return cell.editorItemValue
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension TrivialityEditorViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.editorItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let editorItem = self.viewModel.editorItems[indexPath.row]
        switch editorItem {
        case .icon:
            let cell: TrivialityEditorIconCell = tableView.dequeueReusableCell(for: indexPath)
            cell.icon = UIImage(named: self.viewModel.trivialityItem?.icon ?? "")
            return cell
        case .title:
            let cell: TrivialityEditorTextFieldCell = tableView.dequeueReusableCell(for: indexPath)
            cell.placeholder = "给小事取个名字吧~"
            cell.text = self.viewModel.trivialityItem?.title
            return cell
        case .description:
            let cell: TrivialityEditorTextFieldCell = tableView.dequeueReusableCell(for: indexPath)
            cell.placeholder = "给小事添加一段描述吧~"
            cell.text = self.viewModel.trivialityItem?.description
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.viewModel.editorItems[indexPath.row].cellHeight
    }
}

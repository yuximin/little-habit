//
//  TrivialityEditorViewController.swift
//  Triviality
//
//  Created by apple on 2024/4/4.
//

import UIKit

class TrivialityEditorViewController: UIViewController {
    
    enum EditorType {
        case create
        case modify(model: TrivialityItemModel)
    }
    
    var saveAction: ((TrivialityItemModel) -> Void)?
    
    private let editorType: EditorType
    
    // MARK: - Lifecycle
    
    init(editorType: EditorType) {
        self.editorType = editorType
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
        self.view.backgroundColor = "#FFF8E7".color
        
        self.view.addSubview(topBar)
        topBar.addSubview(closeButton)
        topBar.addSubview(titleLabel)
        topBar.addSubview(saveButton)
        self.view.addSubview(tableView)
        
        topBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        closeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 44, height: 44))
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
        button.backgroundColor = .red.withAlphaComponent(0.5)
        button.addTarget(self, action: #selector(didTapCloseButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "编辑小事"
        label.textColor = "#333333".color
        label.font = 20.font(weight: .bold)
        return label
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("保存", for: .normal)
        button.setTitleColor("#333333".color, for: .normal)
        button.titleLabel?.font = 16.font
        button.addTarget(self, action: #selector(didTapSaveButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()

}

// MARK: - Action
extension TrivialityEditorViewController {
    @objc private func didTapCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @objc private func didTapSaveButton(_ sender: UIButton) {
        let time = Date().timeIntervalSince1970
        let item = TrivialityItemModel(id: "\(time)", icon: "", title: "小事", description: "记录记录", lastRecodeTime: time)
        self.saveAction?(item)
        self.dismiss(animated: true)
    }
}

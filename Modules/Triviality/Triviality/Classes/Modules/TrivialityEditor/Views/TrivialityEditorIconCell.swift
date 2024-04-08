//
//  TrivialityEditorIconCell.swift
//  Triviality
//
//  Created by apple on 2024/4/5.
//

import UIKit
import XMKit
import SnapKit

class TrivialityEditorIconCell: UITableViewCell, Reusable, TrivialityEditorCell {
    
    var editorItemValue: Any? { "图标名称" }
    
    var icon: UIImage? {
        didSet {
            iconImageView.image = icon
        }
    }
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        self.contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        self.contentView.addSubview(editorButton)
        editorButton.snp.makeConstraints { make in
            make.edges.equalTo(iconImageView)
        }
    }
    
    // MARK: - Lazy View
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private lazy var editorButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(didTapEditorButton(_:)), for: .touchUpInside)
        return button
    }()
}

// MARK: - Action
extension TrivialityEditorIconCell {
    
    @objc private func didTapEditorButton(_ sender: UIButton) {
        print("点击编辑按钮")
    }
}

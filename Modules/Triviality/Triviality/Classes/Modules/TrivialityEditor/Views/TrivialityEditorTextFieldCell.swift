//
//  TrivialityEditorTextFieldCell.swift
//  Triviality
//
//  Created by apple on 2024/4/5.
//

import UIKit
import XMKit
import SnapKit
import Theme

class TrivialityEditorTextFieldCell: UITableViewCell, Reusable, TrivialityEditorCell {
    
    var editorItemValue: Any? { textField.text }
    
    var placeholder: String? {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    var text: String? {
        get { textField.text }
        set { textField.text = newValue }
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
        
        self.contentView.addSubview(plateView)
        plateView.addSubview(textField)
        
        plateView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(50)
        }
        
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    // MARK: - Lazy View
    
    private lazy var plateView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.themeColor.plate
        view.layer.cornerRadius = 25
        view.layer.shadowOffset = .zero
        view.layer.shadowColor = Theme.themeColor.plateShadow.cgColor
        view.layer.shadowOpacity = 0.2
        return view
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.returnKeyType = .done
        return textField
    }()
}

extension TrivialityEditorTextFieldCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

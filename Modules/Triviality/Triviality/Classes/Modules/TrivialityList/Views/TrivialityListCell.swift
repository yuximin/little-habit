//
//  TrivialityListCell.swift
//  Triviality
//
//  Created by apple on 2024/4/4.
//

import UIKit
import XMKit
import Theme

protocol TrivialityListCellDelegate: AnyObject {
    func trivialityListCellDidSelectRecord(_ cell: TrivialityListCell)
}

class TrivialityListCell: UITableViewCell, Reusable {
    
    weak var delegate: TrivialityListCellDelegate?
    
    var model: TrivialityItemModel? {
        didSet {
            refreshUI()
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
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        self.contentView.addSubview(plateView)
        plateView.addSubview(iconImageView)
        plateView.addSubview(titleLabel)
        plateView.addSubview(lastTimeLabel)
        plateView.addSubview(recordButton)
        
        plateView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView).offset(5)
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.trailing.lessThanOrEqualTo(recordButton.snp.leading).offset(-10)
        }
        
        lastTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.trailing.lessThanOrEqualTo(recordButton.snp.leading).offset(-10)
            make.bottom.equalTo(iconImageView).offset(-5)
        }
        
        recordButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    private func refreshUI() {
        iconImageView.image = UIImage(named: self.model?.icon ?? "")
        titleLabel.text = self.model?.title
        
        if let lastRecodeTime = model?.lastRecodeTime, lastRecodeTime > 0 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy年MM月dd日"
            let date = Date(timeIntervalSince1970: lastRecodeTime)
            lastTimeLabel.text = "上次记录：\(dateFormatter.string(from: date))"
        } else {
            lastTimeLabel.text = "点击右侧按钮新增一条记录吧~"
        }
    }
    
    // MARK: - Lazy View
    
    private lazy var plateView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = "#FFD700".color
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red.withAlphaComponent(0.5)
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "一件小事"
        label.textColor = Theme.textColor.primary
        label.font = 14.font(weight: .semibold)
        return label
    }()
    
    private lazy var lastTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "上次记录：2024年3月28日"
        label.textColor = Theme.textColor.secondary
        label.font = 12.font
        return label
    }()
    
    private lazy var recordButton: UIButton = {
        let image = UIImage(systemName: "square.and.pencil.circle.fill")?.withTintColor(Theme.textColor.primary, renderingMode: .alwaysOriginal).resized(to: CGSize(width: 30, height: 30))
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(didTapRecordButton(_:)), for: .touchUpInside)
        return button
    }()

}

// MARK: - Action
extension TrivialityListCell {
    
    @objc private func didTapRecordButton(_ sender: UIButton) {
        self.delegate?.trivialityListCellDidSelectRecord(self)
    }
}

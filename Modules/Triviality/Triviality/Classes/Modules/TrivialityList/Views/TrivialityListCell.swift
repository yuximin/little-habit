//
//  TrivialityListCell.swift
//  Triviality
//
//  Created by apple on 2024/4/4.
//

import UIKit
import XMKit
import Theme

class TrivialityListCell: UITableViewCell, Reusable {
    
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
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.top.equalTo(iconImageView)
        }
        
        lastTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.bottom.equalTo(iconImageView)
        }
    }
    
    private func refreshUI() {
        iconImageView.image = UIImage(named: self.model?.icon ?? "")
        titleLabel.text = self.model?.title
        
        if let lastRecodeTime = model?.lastRecodeTime, lastRecodeTime >= 0 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy年MM月dd日"
            let date = Date(timeIntervalSince1970: lastRecodeTime)
            lastTimeLabel.text = "上次记录：\(dateFormatter.string(from: date))"
        } else {
            lastTimeLabel.text = "暂未记录"
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

}

//
//  HomeCell.swift
//  learning1
//
//  Created by Lipeixuan on 2026/7/8.
//
import UIKit

import SnapKit

class ProfileCell: UITableViewCell {  //创建列表自定义cell子类
    
    let avatar = UIImageView()   //创建控件
    let nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {  //初始化布局
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) {  //必须写，swift强制
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {  //ui布局
        
        contentView.addSubview(avatar)  // UITableViewCell 里面专门用来放 UI 的“容器视图”,类似View
        contentView.addSubview(nameLabel)
        
        avatar.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }

        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(avatar.snp.right).offset(12)
            make.centerY.equalToSuperview()
        }
        
    }
    
    func configure(model: UserModel) {
        nameLabel.text = model.name
        avatar.image = UIImage(named: model.avatar)
    }
}

//
//  HomeCell.swift
//  learning1
//
//  Created by Lipeixuan on 2026/7/8.
//
import UIKit
import SnapKit

class ProfileCell: UITableViewCell {  //创建列表自定义cell子类
    
    private lazy var avatar: UIImageView = {
        let avatarView = UIImageView()
        return avatarView
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        return nameLabel
    }()
    
    private lazy var followImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "follow_flag")
        imageView.tintColor = .systemRed
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {  //初始化布局
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    required init?(coder: NSCoder) {  //必须写，swift强制
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {  //ui布局
        
        self.contentView.addSubview(self.avatar)  // UITableViewCell 里面专门用来放 UI 的“容器视图”,类似View
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.followImageView)
        
        self.avatar.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }

        self.nameLabel.snp.makeConstraints { make in
            make.left.equalTo(self.avatar.snp.right).offset(12)
            make.centerY.equalToSuperview()
        }
        
        self.followImageView.snp.makeConstraints{ make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
    }
    
    func configure(model: UserModel) {
        self.nameLabel.text = model.name
        self.avatar.image = UIImage(named: model.avatar)
        self.followImageView.isHidden = !model.isFollowed
    }
}

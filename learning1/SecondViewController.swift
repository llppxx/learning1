//
//  SecondViewController.swift
//  learning1
//
//  Created by Lipeixuan on 2026/7/3.
//
import UIKit
import SnapKit

class SecondViewController: UIViewController {

    // MARK: - UI控件
    let backgroundImageView = UIImageView()
    let cardView = UIView()
    let avatar = UIImageView()
<<<<<<< HEAD
    //let nameLabel = UILabel()
    let phoneLabel = UILabel()
    let followButton = UIButton()
    let introLabel = UILabel()
    let nameField = UITextField()
=======
    let nameLabel = UILabel()
    let phoneLabel = UILabel()
    let followButton = UIButton()
    let introLabel = UILabel()
>>>>>>> b66ed6e0b7c02790108d27ffbe7105017a1d15f1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupBackground()
        setupCard()
        setupAvatar()
        setupName()
        setupPhone()
        setupButton()
        setupIntro()
    }

    // MARK: - 背景图（上1/3）

    func setupBackground() {
        backgroundImageView.image = UIImage(named: "image_background")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true

        view.addSubview(backgroundImageView)

        backgroundImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.33)
        }
    }

    // MARK: - 浮层卡片

    func setupCard() {
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 20
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowRadius = 10

        view.addSubview(cardView)

        cardView.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.bottom).offset(-40)
            make.left.right.equalToSuperview().inset(16)
        }
    }

    // MARK: - 头像（左）

    func setupAvatar() {
        avatar.image = UIImage(named: "Image")
        avatar.contentMode = .scaleAspectFill
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = 50

        cardView.addSubview(avatar)

        avatar.snp.makeConstraints { make in
            make.top.equalTo(cardView).offset(20)
            make.left.equalTo(cardView).offset(16)
            make.width.height.equalTo(100)
        }
    }

    // MARK: - 姓名

    func setupName() {
<<<<<<< HEAD
        nameField.placeholder = "懒羊羊"
        nameField.font = .systemFont(ofSize: 18)
        nameField.textColor = .black
        nameField.borderStyle = .roundedRect  //键盘风格
        nameField.keyboardType = .default  //键盘类型
        nameField.returnKeyType = .done  //回车类型

        cardView.addSubview(nameField)

        nameField.snp.makeConstraints { make in
=======
        nameLabel.text = "懒羊羊"
        nameLabel.font = .boldSystemFont(ofSize: 18)

        cardView.addSubview(nameLabel)

        nameLabel.snp.makeConstraints { make in
>>>>>>> b66ed6e0b7c02790108d27ffbe7105017a1d15f1
            make.top.equalTo(avatar).offset(10)
            make.left.equalTo(avatar.snp.right).offset(20)
        }
    }

<<<<<<< HEAD
    // MARK: - ip地址
=======
    // MARK: - 电话
>>>>>>> b66ed6e0b7c02790108d27ffbe7105017a1d15f1

    func setupPhone() {
        phoneLabel.text = "ip 青青草原"
        phoneLabel.font = .systemFont(ofSize: 14)
        phoneLabel.textColor = .gray

        cardView.addSubview(phoneLabel)

        phoneLabel.snp.makeConstraints { make in
<<<<<<< HEAD
            make.top.equalTo(nameField.snp.bottom).offset(30)
            make.left.equalTo(nameField)
=======
            make.top.equalTo(nameLabel.snp.bottom).offset(30)
            make.left.equalTo(nameLabel)
>>>>>>> b66ed6e0b7c02790108d27ffbe7105017a1d15f1
        }
    }

    // MARK: - 关注按钮（右侧）

    func setupButton() {
        followButton.setTitle("关注 +", for: .normal)
        followButton.backgroundColor = .systemRed
        followButton.setTitleColor(.white, for: .normal)
        followButton.layer.cornerRadius = 20
        followButton.clipsToBounds = true

        cardView.addSubview(followButton)

        followButton.snp.makeConstraints { make in
            make.centerY.equalTo(avatar)
            make.right.equalTo(cardView).offset(-20)
            make.width.equalTo(80)
            make.height.equalTo(35)
        }
    }

    // MARK: - 简介

    func setupIntro() {
        introLabel.text = "这个人很懒，什么都没有写..."
        introLabel.font = .systemFont(ofSize: 14)
        introLabel.textColor = .darkGray
        introLabel.numberOfLines = 0

        cardView.addSubview(introLabel)

        introLabel.snp.makeConstraints { make in
            make.top.equalTo(avatar.snp.bottom).offset(16)
            make.left.equalTo(cardView).offset(16)
            make.right.equalTo(cardView).offset(-16)
            make.bottom.equalTo(cardView).offset(-16)
        }
    }
}

#if canImport(SwiftUI)
import SwiftUI

#Preview {
    SecondViewController()
}
#endif

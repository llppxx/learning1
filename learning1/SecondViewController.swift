//
//  SecondViewController.swift
//  learning1
//
//  Created by Lipeixuan on 2026/7/3.
//
import UIKit
import SnapKit

class SecondViewController: UIViewController {
    
    var user: UserModel?
    
    // MARK: - 初始化控件
    private lazy var backgroundImageView: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "image_background")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
        
    }()
    
    private lazy var cardView:UIView = {
        let card = UIView()
        
        card.backgroundColor = .white
        card.layer.cornerRadius = 20
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOpacity = 0.1
        card.layer.shadowRadius = 10
        return card
    }()
    
    private lazy var avatar:UIImageView = {
        let avatarView = UIImageView()
        
        avatarView.contentMode = .scaleAspectFill
        avatarView.clipsToBounds = true
        avatarView.layer.cornerRadius = 50
        return avatarView
    }()
    
    private lazy var nameField: UITextField = {
        
        let textField = UITextField()
        
        textField.font = .systemFont(ofSize: 18)
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.keyboardType = .default
        textField.returnKeyType = .done
        
        return textField
        
    }()
    
    private lazy var phoneLabel: UILabel = {
        
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        
        return label
        
    }()
    
    private lazy var followButton: UIButton = {
        
        let button = UIButton(type: .system)
        
        button.setTitle("关注 +", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        
        return button
        
    }()
    
    private lazy var introLabel: UILabel = {
        
        let label = UILabel()
        
        label.text = "这个人很懒，什么都没有写..."
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        
        return label
        
    }()
    
    private lazy var backButton: UIButton = {

        let button = UIButton(type: .system)
        button.setImage(
            UIImage(systemName:"chevron.left"),
            for:.normal
        )
        
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 20

        button.addTarget(
            self,
            action:#selector(backClick),
            for:.touchUpInside
        )
        return button
    }()
    @objc private func backClick(){

        navigationController?.popViewController(animated:true)

    }
    
    // MARK: - 加入视图
    private func setupViews() {
        
        view.addSubview(backgroundImageView)
        view.addSubview(cardView)
        view.addSubview(backButton)
        
        cardView.addSubview(avatar)
        cardView.addSubview(nameField)
        cardView.addSubview(phoneLabel)
        cardView.addSubview(followButton)
        cardView.addSubview(introLabel)
        
    }
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        setupViews()
        setupConstraints()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: true)
        print("second出现")
    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
        print("second消失")
    }

    // MARK: - 设置布局
    private func setupConstraints(){
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.33)
        }
        
        cardView.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.bottom).offset(-40)
            make.left.right.equalToSuperview().inset(16)
        }
        
        avatar.snp.makeConstraints { make in
            make.top.equalTo(cardView).offset(20)
            make.left.equalTo(cardView).offset(16)
            make.width.height.equalTo(100)
        }
        
        nameField.snp.makeConstraints { make in
            make.top.equalTo(avatar).offset(10)
            make.left.equalTo(avatar.snp.right).offset(20)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(30)
            make.left.equalTo(nameField)
        }
        
        followButton.snp.makeConstraints { make in
            make.centerY.equalTo(avatar)
            make.right.equalTo(cardView).offset(-20)
            make.width.equalTo(80)
            make.height.equalTo(35)
        }
        
        introLabel.snp.makeConstraints { make in
            
            make.top.equalTo(phoneLabel.snp.bottom).offset(20)
            make.left.right.equalTo(cardView).inset(16)
            make.bottom.equalTo(cardView).offset(-20)

        }
        
        backButton.snp.makeConstraints { make in
            
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(40)

        }
        
    }
    
    // MARK: - 设置控件数据
    private func setupData(){
        
        guard let user = user else {
            return
        }
        avatar.image = UIImage(named:user.avatar)
        nameField.text = user.name
        phoneLabel.text = "ip 青青草原"
        
    }
}

#if canImport(SwiftUI)
import SwiftUI

#Preview {
    CustomNavigationController(
            rootViewController: ViewController()
        )
}#endif

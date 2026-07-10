//
//  ProfileViewController.swift
//  learning1
//
//  Created by Lipeixuan on 2026/7/3.
//
import UIKit
import SnapKit

class ProfileViewController: UIViewController ,UITextFieldDelegate{
    
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
        avatarView.isUserInteractionEnabled = true  //允许点击交互
        return avatarView
    }()
    
    private lazy var nameField: UITextField = {
        
        let textField = UITextField()
        
        textField.font = .systemFont(ofSize: 18)
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.delegate = self
        
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
    
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        setupViews()
        setupConstraints()
        setupData()
        addAvatarGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        print("profile出现")
    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        print("profile消失")
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
        let ss:String = "ip "
        let ProfileAddress = ss + user.address
        avatar.image = UIImage(named:user.avatar)
        nameField.text = user.name
        phoneLabel.text = ProfileAddress
        introLabel.text = user.desc
        
    }
    
    private func addAvatarGesture(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(changeAvatar))
        avatar.addGestureRecognizer(tap)
    }
    @objc private func changeAvatar(){
        
        let changeAvatarvc = AvatarPickerViewController()
        changeAvatarvc.onAvatarSelected = { [weak self] avatarName in
            self?.user?.avatar = avatarName
            self?.avatar.image = UIImage(named: avatarName)
            print("Pvc收到头像",avatarName)
        }
        changeAvatarvc.modalPresentationStyle = .pageSheet
        let nav = ModalNavigationController(rootViewController: changeAvatarvc)
        present(nav,animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameField{
            guard let user = user else{
                return true
            }
            if let text = textField.text, !text.isEmpty{ user.name = text }
        }
        return true
    }
}


#if canImport(SwiftUI)
import SwiftUI

#Preview {
    CustomNavigationController(
            rootViewController: ViewController()
        )
}#endif

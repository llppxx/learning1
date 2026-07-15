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
        avatarView.isUserInteractionEnabled = true//允许点击交互
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
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(followButtonTapped), for: .touchUpInside)
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
    
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.setupViews()
        self.setupConstraints()
        self.setupData()
        self.addAvatarGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        print("profile出现")
    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        print("profile消失")
    }
    

    // MARK: - UI搭建
    private func setupViews() {
        self.view.addSubview(self.backgroundImageView)
        self.view.addSubview(self.cardView)
        self.view.addSubview(self.backButton)
        self.cardView.addSubview(self.avatar)
        self.cardView.addSubview(self.nameField)
        self.cardView.addSubview(self.phoneLabel)
        self.cardView.addSubview(self.followButton)
        self.cardView.addSubview(self.introLabel)
    }

    private func setupConstraints(){
        self.backgroundImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.33)
        }
        
        self.cardView.snp.makeConstraints {  make in
            make.top.equalTo(self.backgroundImageView.snp.bottom).offset(-40)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        self.avatar.snp.makeConstraints {  make in
            make.top.equalTo(self.cardView).offset(20)
            make.leading.equalTo(self.cardView).offset(16)
            make.width.height.equalTo(100)
        }
        
        self.nameField.snp.makeConstraints {  make in
            make.top.equalTo(self.avatar).offset(10)
            make.leading.equalTo(self.avatar.snp.trailing).offset(20)
        }
        
        self.phoneLabel.snp.makeConstraints {  make in
            make.top.equalTo(self.nameField.snp.bottom).offset(30)
            make.leading.equalTo(self.nameField)
        }
        
        self.followButton.snp.makeConstraints {  make in
            make.centerY.equalTo(self.avatar)
            make.trailing.equalTo(self.cardView).offset(-20)
            make.width.equalTo(80)
            make.height.equalTo(35)
        }
        
        self.introLabel.snp.makeConstraints {  make in
            make.top.equalTo(self.phoneLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.cardView).inset(16)
            make.bottom.equalTo(self.cardView).offset(-20)
        }
        
        self.backButton.snp.makeConstraints {  make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(40)
        }
        
    }
    
    // MARK: - 设置控件数据
    private func setupData(){
        guard let user = self.user else {
            return
        }
        let ss:String = "ip "
        let ProfileAddress = ss + user.address
        self.avatar.image = UIImage(named:user.avatar)
        self.nameField.text = user.name
        self.phoneLabel.text = ProfileAddress
        self.introLabel.text = user.desc
        self.updateFollowButton()
    }
    
    private func updateFollowButton(){
        guard let user = self.user else { return }
        if user.isFollowed{
            let title = __("profile.button.followed")
            self.followButton.setTitle(title, for: .normal)
            self.followButton.backgroundColor = .systemGray
        }
        else{
            let title = __("profile.button.follow")
            self.followButton.setTitle(title, for: .normal)
            self.followButton.backgroundColor = .systemRed
        }
    }
    
    // MARK: - 业务逻辑
    private func addAvatarGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(changeAvatar))
        self.avatar.addGestureRecognizer(tap)
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
        if textField == self.nameField{
            guard let user = self.user else{
                return true
            }
            if let text = textField.text, !text.isEmpty{ user.name = text }
        }
        return true
    }
    
    @objc private func backClick(){
        self.navigationController?.popViewController(animated:true)
    }
    
    @IBAction func followButtonTapped(_ sender: UIButton){
        user?.isFollowed.toggle()
        updateFollowButton()
    }
}


#if canImport(SwiftUI)
import SwiftUI

#Preview {
    CustomNavigationController(
            rootViewController: ViewController()
        )
}#endif

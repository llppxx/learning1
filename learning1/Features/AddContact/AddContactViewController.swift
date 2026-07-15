//
//  AddContactViewcontroller.swift
//  learning1
//
//  Created by Lipeixuan on 2026/7/8.
//

import UIKit
import SnapKit

protocol AddContactDelegate: AnyObject {
    func didAddContact(_ user: UserModel)
}

class AddContactViewController: UIViewController {
    
    weak var delegate: AddContactDelegate?
    
    // MARK: 控件初始化
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = __("addcontact.name.placeholder")
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var descTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = __("addcontact.desc.placeholder")
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var addressTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = __("addcontact.address.placeholder")
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    // MARK: 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = __("addcontact.navigation.title")
        self.setupNavigationBar()
        self.setupViews()
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("addContact出现la")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("addContact消失la")
    }
    
    // MARK: UI搭建
    private func setupNavigationBar(){
        // 左侧取消按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: __("addcontact.navigation.cancel"),
            style: .plain,
            target: self,
            action: #selector(cancelAction)
        )
        // 右侧保存按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: __("addcontact.navigation.save"),
            style: .done,
            target: self,
            action: #selector(self.saveAction)
        )
        
    }
    
    private func setupViews(){
        self.view.addSubview(self.nameTextField)
        self.view.addSubview(self.descTextField)
        self.view.addSubview(self.addressTextField)
    }
    
    private func setupUI(){
        self.nameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
                .offset(50)
            make.leading.trailing.equalToSuperview()
                .inset(30)
            make.height.equalTo(50)
        }
        
        self.descTextField.snp.makeConstraints { make in
            make.top.equalTo(self.nameTextField.snp.bottom)
                .offset(20)
            make.leading.trailing.equalToSuperview()
                .inset(30)
            make.height.equalTo(50)
        }
        
        self.addressTextField.snp.makeConstraints { make in
            make.top.equalTo(self.descTextField.snp.bottom)
                .offset(20)
            make.leading.trailing.equalToSuperview()
                .inset(30)
            make.height.equalTo(50)
        }
        
    }
    
    // MARK: 业务逻辑
    @objc private func saveAction(){
        guard let name = self.nameTextField.text,
              !name.isEmpty
        else { return }
        let  desc: String
        if let text = self.descTextField.text, !text.isEmpty{  desc = text  }
        else{  desc = __("addcontact.desc.default")  }
            
        let  address: String
        if let text = self.addressTextField.text, !text.isEmpty{  address = text  }
        else{  address = __("addcontact.address.default") }
        let user = UserModel(
            name: name,
            avatar: "avatar_defualt",
            desc: desc,
            address: address
        )
        self.delegate?.didAddContact(user)
        dismiss(animated: true)
    }
    
    @objc private func cancelAction() {
        dismiss(animated: true)
    }
}


#if canImport(SwiftUI)
import SwiftUI

#Preview {
    AddContactViewController()
}#endif

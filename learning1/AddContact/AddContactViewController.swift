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

extension AddContactDelegate {
    func didAddContact(_ user: UserModel) {
        print("add联系人啦")
    }
}

class AddContactViewController: UIViewController {
    
    weak var delegate: AddContactDelegate?
    
    private lazy var nameTextField: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "请输入姓名"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    
    private lazy var descTextField: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "请输入描述"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    
    private lazy var saveButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("保存", for: .normal)
        button.addTarget(
            self,
            action: #selector(saveAction),
            for: .touchUpInside
        )
        
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "添加联系人"
        
        setupViews()
        setupUI()
    }
    
    
    private func setupViews(){
        
        view.addSubview(nameTextField)
        view.addSubview(descTextField)
        view.addSubview(saveButton)
        
    }
    
    
    private func setupUI(){
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
                .offset(50)
            make.left.right.equalToSuperview()
                .inset(30)
            make.height.equalTo(50)
        }
        
        descTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom)
                .offset(20)
            make.left.right.equalToSuperview()
                .inset(30)
            make.height.equalTo(50)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(descTextField.snp.bottom)
                .offset(30)
            make.centerX.equalToSuperview()
        }
    }

    @objc private func saveAction(){

        guard let name = nameTextField.text,
              !name.isEmpty
        else { return }
        
        let desc = descTextField.text ?? ""
        
        let user = UserModel(
            name: name,
            avatar: "avatar_defualt",
            desc: desc
        )
        
        delegate?.didAddContact(user)
        
        dismiss(animated: true)
    }
}


#if canImport(SwiftUI)
import SwiftUI

#Preview {
    AddContactViewController()
}#endif

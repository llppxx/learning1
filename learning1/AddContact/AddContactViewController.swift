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
        textField.placeholder = NSLocalizedString("addcontact.name.placeholder", comment: "")
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    
    private lazy var descTextField: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = NSLocalizedString("addcontact.desc.placeholder", comment: "")
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private lazy var addressTextField: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = NSLocalizedString("addcontact.address.placeholder", comment: "")
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = NSLocalizedString("addcontact.navigation.title", comment: "")
        
        setupNavigationBar()
        setupViews()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("addContact出现la")
    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("addContact消失la")
    }
    
    private func setupNavigationBar(){
        
        // 左侧取消按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("addcontact.navigation.cancel", comment: ""),
            style: .plain,
            target: self,
            action: #selector(cancelAction)
        )

        // 右侧保存按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("addcontact.navigation.save", comment: ""),
            style: .done,
            target: self,
            action: #selector(saveAction)
        )
        
    }
    
    private func setupViews(){
        
        view.addSubview(nameTextField)
        view.addSubview(descTextField)
        view.addSubview(addressTextField)
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
        
        addressTextField.snp.makeConstraints { make in
            make.top.equalTo(descTextField.snp.bottom)
                .offset(20)
            make.left.right.equalToSuperview()
                .inset(30)
            make.height.equalTo(50)
        }
        
    }

    @objc private func saveAction(){

        guard let name = nameTextField.text,
              !name.isEmpty
        else { return }
        let  desc: String
        if let text = descTextField.text, !text.isEmpty{  desc = text  }
        else{  desc = NSLocalizedString("addcontact.desc.default", comment: "")  }
            
        let  address: String
        if let text = addressTextField.text, !text.isEmpty{  address = text  }
        else{  address = NSLocalizedString("addcontact.address.default", comment: "")  }
        
        let user = UserModel(
            name: name,
            avatar: "avatar_defualt",
            desc: desc,
            address: address
        )
        
        delegate?.didAddContact(user)
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

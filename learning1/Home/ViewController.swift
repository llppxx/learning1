//
//  ViewController.swift
//  learning1
//
//  Created by Lipeixuan on 2026/6/30.
//

import UIKit

import SnapKit

class ViewController: UIViewController  {
    
    var filteredUsers = contactList
    
    // MARK: 控件初始化
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = __("home.search.placeholder")
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.leftView = UIView(frame: CGRect(x: 0,y: 0,width: 10,height: 0))
        textField.leftViewMode = .always
        return textField
    }()
    
    private lazy var tableView: UITableView = {
        let tableViews = UITableView() //创建列表
        tableViews.dataSource = self  // 设置数据源
        tableViews.delegate = self
        tableViews.register(ProfileCell.self, forCellReuseIdentifier: "cell") // 注册cell（自定义）
        return tableViews
    }()
    
    // MARK: 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.navigationItem.title = __("home.navigation.title")
        self.setupAddButton()
        self.setupView()
        self.setupConstraints()
        self.setupTextFiled()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableViewSort()
        print("主页出现啦")
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("主页消失啦")
    }
    
    // MARK: UI搭建
    private func setupView(){
        self.view.addSubview(searchTextField)
        self.view.addSubview(tableView)
    }
    
    private func setupConstraints(){
        self.searchTextField.snp.makeConstraints{  make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        
        self.tableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            make.width.equalTo(300)
            make.height.equalTo(500)
        }
    }
    private func setupAddButton(){
        //系统自动在右上角生成+号，点击后通知当前页面，并调用addContact函数
        let addButton = UIBarButtonItem(barButtonSystemItem:  .add, target: self, action: #selector(addContact))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    // MARK: 业务逻辑
    private func setupTextFiled(){
        self.searchTextField.addTarget(self, action: #selector(searchTextChange), for: .editingChanged)
    }
    @objc private func searchTextChange(){
        guard let text = self.searchTextField.text else {  return  }
        if text.isEmpty { self.filteredUsers = contactList }
        else {
            self.filteredUsers = contactList.filter{
                $0.name.contains(text)
            }
        }
        self.tableViewSort()
    }
    
    @objc func addContact(){
        print("点击添加联系人按钮")
        let addVC = AddContactViewController()
        addVC.delegate = self
        let nav = ModalNavigationController(rootViewController: addVC)
        addVC.modalPresentationStyle = .pageSheet
        self.present(
            nav,
            animated:true
        )
    }
    
    private func tableViewSort(){
        self.filteredUsers.sort{
            if $0.isFollowed != $1.isFollowed{
                return $0.isFollowed && !$1.isFollowed
            }
            return $0.name < $1.name
        }
        self.tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    //UITableViewDataSource 协议，必须写
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredUsers.count
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileCell
        
        let model = self.filteredUsers[indexPath.row]

        cell.configure(model: model)
        return cell
    }
    
    //UITableViewDelegate协议，规定怎么交互
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = self.filteredUsers[indexPath.row]
        let vc = ProfileViewController()
        vc.user = user
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

extension ViewController: AddContactDelegate {
    
    func didAddContact(_ user: UserModel) {
        contactList.append(user)
        self.filteredUsers = contactList
        self.tableViewSort()
    }
}

#if canImport(SwiftUI)
import SwiftUI

#Preview {
    CustomNavigationController(
            rootViewController: ViewController()
        )
}
#endif

//
//  ViewController.swift
//  learning1
//
//  Created by Lipeixuan on 2026/6/30.
//

import UIKit

import SnapKit

class ViewController: UIViewController , UITableViewDataSource ,  UITableViewDelegate  {
    
    let tableView = UITableView() //创建列表
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.title = "通讯录"
        setupAddButton()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    func setupAddButton(){
        //系统自动在右上角生成+号，点击后通知当前页面，并调用addContact函数
        let addButton = UIBarButtonItem(barButtonSystemItem:  .add, target: self, action: #selector(addContact))
        
        navigationItem.rightBarButtonItem = addButton
    }
    @objc func addContact(){
        
        print("点击添加联系人按钮")
        let addVC = AddContactViewController()
        
        addVC.delegate = self
        let nav = ModalNavigationController(rootViewController: addVC)
        
        addVC.modalPresentationStyle = .pageSheet
        present(
            nav,
            animated:true
        )
    }
    
    
    func setupTableView(){
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            make.width.equalTo(300)
            make.height.equalTo(500)
        }
        
        tableView.dataSource = self  // 设置数据源
        tableView.delegate = self
        
        tableView.register(ProfileCell.self, forCellReuseIdentifier: "cell") // 注册cell（自定义）
    }
    //UITableViewDataSource 协议，必须写
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileCell
        
        let model = contactList[indexPath.row]

        cell.configure(model: model)
        return cell
    }
    
    //UITableViewDelegate协议，规定怎么交互
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = contactList[indexPath.row]
        let vc = ProfileViewController()
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
extension ViewController: AddContactDelegate {

    func didAddContact(_ user: UserModel) {

        contactList.append(user)
        tableView.reloadData()
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

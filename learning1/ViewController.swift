//
//  ViewController.swift
//  learning1
//
//  Created by Lipeixuan on 2026/6/30.
//

import UIKit

import SnapKit

class ProfileCell: UITableViewCell {  //创建列表自定义cell子类
    
    let avatar = UIImageView()   //创建控件
    let nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {  //初始化布局
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    required init?(coder: NSCoder) {  //必须写，swift强制
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {  //ui布局
        
        contentView.addSubview(avatar)  // UITableViewCell 里面专门用来放 UI 的“容器视图”,类似View
        contentView.addSubview(nameLabel)
        
        avatar.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }

        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(avatar.snp.right).offset(12)
            make.centerY.equalToSuperview()
        }
        
    }
    
    func configure(model: UserModel) {
        nameLabel.text = model.name
        avatar.image = UIImage(named: model.avatar)
    }
}
    

class ViewController: UIViewController , UITableViewDataSource ,  UITableViewDelegate  {
    
    let tableView = UITableView() //创建列表
    let data: [UserModel] = [
        UserModel(name: "懒羊羊", avatar: "avatar1", desc: "睡觉中"),
        UserModel(name: "喜羊羊", avatar: "avatar2", desc: "奔跑"),
        UserModel(name: "美羊羊", avatar: "avatar3", desc: "漂亮")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.title = "通讯录"
        setupAddButton()
        setupTableView()
    }
    
    func setupAddButton(){
        //系统自动在右上角生成+号，点击后通知当前页面，并调用addContact函数
        let addButton = UIBarButtonItem(barButtonSystemItem:  .add, target: self, action: #selector(addContact))
        
        navigationItem.rightBarButtonItem = addButton
    }
    @objc func addContact(){
        print("点击添加联系人按钮")
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
        return data.count
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileCell
        
        let model = data[indexPath.row]

        cell.configure(model: model)
        return cell
    }
    
    //UITableViewDelegate协议，规定怎么交互
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = data[indexPath.row]
        let vc = SecondViewController()
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    
}

#if canImport(SwiftUI)
import SwiftUI

#Preview {
    UINavigationController(
            rootViewController: ViewController()
        )
}
#endif

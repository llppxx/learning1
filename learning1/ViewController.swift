//
//  ViewController.swift
//  learning1
//
//  Created by Lipeixuan on 2026/6/30.
//

import UIKit

import SnapKit

class ProfileCell: UITableViewCell {  //创建自定义cell子类
    
    let avatar = UIImageView()   //创建控件
    let nameLabel = UILabel()
    let followButton = UIButton()
    
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
        contentView.addSubview(followButton)
        
        avatar.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }

        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(avatar.snp.right).offset(12)
            make.centerY.equalToSuperview()
        }
        
        followButton.snp.makeConstraints { make in
            make.right.equalTo(-16)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(model: UserModel) {
        nameLabel.text = model.name
        avatar.image = UIImage(named: model.avatar)
    }
}
    
    
struct UserModel {
    let name: String
    let avatar: String   // ⭐图片名
    let desc: String
}
    
class ViewController: UIViewController , UITableViewDataSource , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate  {
    
    let label = UILabel() //创建显示文本
    let button = UIButton()  //创建按钮
    let imageView = UIImageView()  //创建图片
    let textField = UITextField()  //创建单行输入框
    let textView = UITextView() //创建多行输入框
    let tableView = UITableView() //创建列表
    var collectionView: UICollectionView! //创建高级布局
    let data: [UserModel] = [
        UserModel(name: "懒羊羊", avatar: "avatar1", desc: "睡觉中"),
        UserModel(name: "喜羊羊", avatar: "avatar2", desc: "奔跑"),
        UserModel(name: "美羊羊", avatar: "avatar3", desc: "漂亮")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //显示文本
        setupLabel()
        setupButton()
        setupImageView()
        //setupTextField()
        //setupTextView()
        setupTableView()
        //setupCollectionView()
    }
    
    //文本显示
    private func setupLabel(){
        // 1. 配置属性
        label.text = "第一个显示文本哈哈哈哈哈"
        label.textColor = .black
        label.font = .systemFont(ofSize: 30)
        label.numberOfLines = 0  //与宽度配合使用
        label.textAlignment = .center
        
        // 2. 加入视图
        view.addSubview(label)
        
        // 3. 布局
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)    //顶部等于安全距离（状态栏），再向下偏移20
            make.width.equalTo(500)   //宽度约束，如果不约束宽度，不会换行
            make.centerX.equalToSuperview()
        }
    }
    
    
    //按钮
    @objc func buttonClick() {  //点击按钮方法实现
        print("按钮被点击")
    }
    private func setupButton(){
        //属性
        button.setTitle("点我有惊喜", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10  //设置圆角
        button.clipsToBounds = true
        
        //交互函数
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)  //点击事件交互
        
        //加入视图
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(label.snp.bottom).offset(40)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    //图片显示
    private func setupImageView(){
        imageView.image = UIImage(named: "Image") //设置图片
        imageView.contentMode = .scaleAspectFill //配置属性
        imageView.clipsToBounds = true
        
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(button.snp.bottom).offset(40)
            make.width.height.equalTo(100)
        }
        
        imageView.layer.cornerRadius = 50 //圆形头像
    }
    
    //单行输入框
    private func setupTextField(){
        textField.placeholder = "请输入用户名"  //配置属性
        textField.font = .systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.keyboardType = .default  //键盘类型
        textField.returnKeyType = .done
        
        view.addSubview(textField)
        
        textField.snp.makeConstraints { make in  //布局
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.width.equalTo(250)
            make.height.equalTo(40)
        }
    }
    
    
    //多行输入框
    private func setupTextView(){
        
        //多行输入框
        textView.text = "请输入你的个人简介"
        textView.font = .systemFont(ofSize: 18)
        textView.textColor = .black
        textView.isEditable = true //是否可以编辑
        textView.isScrollEnabled = true //是否可以滚动
        textView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        textView.layer.cornerRadius = 10
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)  //内容的内边距
        
        view.addSubview(textView)
        
        textView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.width.equalTo(300)
            make.height.equalTo(250)
        }
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
        print("点击：\(data[indexPath.row])")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //列表，自定义cell
    private func setupTableView(){
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.width.equalTo(300)
            make.height.equalTo(500)
        }
        
        tableView.dataSource = self  // 设置数据源
        tableView.delegate = self
        
        tableView.register(ProfileCell.self, forCellReuseIdentifier: "cell") // 注册cell（自定义）
    }
    
    
    //高级布局
    private func setupCollectionView(){
        
        let layout = UICollectionViewFlowLayout() //控制每个格子大小、间距
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")//告诉系统要用这个cell
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.width.equalTo(300)
            make.height.equalTo(500)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)  //复用cell，不用重复创建
        cell.backgroundColor = .systemBlue
        return cell
    }
    // 点击
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("点击：\(data[indexPath.item])")

        }
    
}

#if canImport(SwiftUI)
import SwiftUI

#Preview {
    ViewController()
}
#endif

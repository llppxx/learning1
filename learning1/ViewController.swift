//
//  ViewController.swift
//  learning1
//
//  Created by Lipeixuan on 2026/6/30.
//

import UIKit

import SnapKit

class ViewController: UIViewController {
    
    let label = UILabel() //创建显示文本
    let button = UIButton()  //创建按钮
    let imageView = UIImageView()  //创建图片
    let textField = UITextField()  //创建单行输入框
    let textView = UITextView() //创建多行输入框
    
    @objc func buttonClick() {  //点击按钮方法实现
        print("按钮被点击")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //显示文本
        
        // 1. 配置属性
        label.text = "第一个显示文本哈哈哈哈哈"
        label.textColor = .black
        label.font = .systemFont(ofSize: 50)
        label.numberOfLines = 0  //与宽度配合使用
        label.textAlignment = .center
        
        // 2. 加入视图
        view.addSubview(label)
        
        // 3. 布局
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)    //顶部等于安全距离（状态栏），再向下偏移20
            make.width.equalTo(300)   //宽度约束，如果不约束宽度，不会换行
            make.centerX.equalToSuperview()
        }
        
        
        //按钮
        
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
            make.height.equalTo(100)
        }
        
        //图片
        
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
        
        //单行输入框
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
        
        //多行输入框
        textView.text = "请输入你的个人简介"
        textView.font = .systemFont(ofSize: 14)
        textView.textColor = .black
        textView.isEditable = true //是否可以编辑
        textView.isScrollEnabled = true //是否可以滚动
        textView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        textView.layer.cornerRadius = 10
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        view.addSubview(textView)

        textView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(textField.snp.bottom).offset(40)
              make.width.equalTo(300)
              make.height.equalTo(100)
        }

    }
}

#if canImport(SwiftUI)
import SwiftUI

#Preview {
    ViewController()
}
#endif

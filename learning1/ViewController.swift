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
        
            button.snp.makeConstraints { make in  //布局
                make.center.equalToSuperview()
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

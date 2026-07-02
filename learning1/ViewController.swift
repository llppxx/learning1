//
//  ViewController.swift
//  learning1
//
//  Created by Lipeixuan on 2026/6/30.
//

import UIKit

import SnapKit

class ViewController: UIViewController {
    
    let label = UILabel() //创建

    override func viewDidLoad() {
            super.viewDidLoad()

            // 1. 配置属性
            label.text = "第一个显示文本哈哈哈哈哈"
            label.textColor = .black
            label.font = .systemFont(ofSize: 50)
            label.numberOfLines = 0
            label.textAlignment = .center

            // 2. 加入视图
            view.addSubview(label)

            // 3. 布局
            label.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).offset(20)//顶部等于安全距离（状态栏），再向下偏移20
                make.width.equalTo(300) //宽度约束，如果不约束宽度，不会换行
                make.centerX.equalToSuperview()
            }
        }

}

#if canImport(SwiftUI)
import SwiftUI

#Preview {
    ViewController()
}
#endif

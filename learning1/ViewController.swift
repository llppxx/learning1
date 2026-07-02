//
//  ViewController.swift
//  learning1
//
//  Created by Lipeixuan on 2026/6/30.
//

import UIKit

import SnapKit

class ViewController: UIViewController {
    
    let box = UIView()

        override func viewDidLoad() {
            super.viewDidLoad()
            view.addSubview(box)
            box.backgroundColor = .blue
            
            box.snp.makeConstraints { make in
                make.center.equalToSuperview()  //约束位置
                make.width.height.equalTo(100)  //约束大小
            }
        }

}

#if canImport(SwiftUI)
import SwiftUI

#Preview {
    ViewController()
}
#endif

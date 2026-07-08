//
//  Theme.swift
//  learning1
//
//  Created by Lipeixuan on 2026/7/8.
//

import UIKit

class CustomNavigationController: UINavigationController {  //把导航样式放到UINavigationController的子类

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    
    private func setupNavigationBar(){

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGray5
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.label
        ]

        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        
        navigationBar.tintColor = .systemBlue
    }

}

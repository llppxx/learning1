//
//  userModel.swift
//  learning1
//
//  Created by Lipeixuan on 2026/7/7.
//

import UIKit
struct UserModel {
    var name: String
    var avatar: String
    let desc: String
    let address: String
}

var contactList: [UserModel] = [
    UserModel(name: "懒羊羊", avatar: "avatar1", desc: "睡觉中",address: "青青草原"),
    UserModel(name: "喜羊羊", avatar: "avatar2", desc: "奔跑",address: "青青草原"),
    UserModel(name: "美羊羊", avatar: "avatar3", desc: "漂亮",address: "青青草原")
]

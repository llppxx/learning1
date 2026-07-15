//
//  userModel.swift
//  learning1
//
//  Created by Lipeixuan on 2026/7/7.
//

import UIKit
class UserModel {
    var name: String
    var avatar: String
    let desc: String
    let address: String
    var isFollowed: Bool
    init(name: String, avatar: String, desc: String, address: String) {
        self.name = name
        self.avatar = avatar
        self.desc = desc
        self.address = address
        self.isFollowed = false
    }
}

var contactList: [UserModel] = [
    UserModel(name: "懒羊羊", avatar: "avatar1", desc: "我的梦就是每天睡饱了吃，吃饱了睡~~~",address: "羊村"),
    UserModel(name: "喜羊羊", avatar: "avatar2", desc: "今天天气不错，去看看灰太狼有没有来羊村捣乱",address: "羊村"),
    UserModel(name: "美羊羊", avatar: "avatar3", desc: "今天心情很美丽呢",address: "羊村"),
    UserModel(name: "灰太狼", avatar: "avatar4", desc: "我一定会回来的！！",address: "狼堡"),
    UserModel(name: "小灰灰", avatar: "avatar5", desc: "我爱我的爸爸妈妈",address: "狼堡")
]

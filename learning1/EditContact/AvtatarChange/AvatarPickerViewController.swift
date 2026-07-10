//
//  AvatarPickerViewController.swift
//  learning1
//
//  Created by Lipeixuan on 2026/7/9.
//

import UIKit

import SnapKit

class AvatarPickerViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource {
    
    var onAvatarSelected: ((String)->Void)?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .white
        vc.dataSource = self
        vc.delegate = self
        
        vc.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return vc
    }()
    
    let avatars = ["avatar1", "avatar2", "avatar3", "avatar4", "avatar5", "avatar_defualt", "avatar6"] //数据
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        title = "更换头像"
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("avatarChange出现啦~~~~")
    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("avatarChange消失啦~~~~")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return avatars.count
        }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)  //复用cell，不用重复创建
        let imageView = UIImageView(
                image: UIImage(named: avatars[indexPath.item])
            )
        imageView.frame = cell.contentView.bounds
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        cell.contentView.addSubview(imageView)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath ) {
        let avatarName = avatars[indexPath.item]
        selectAvatar(name: avatarName)
    }

    func selectAvatar(name:String){
        print("Ap选择头像",name)
        onAvatarSelected?(name)
        dismiss(
            animated: true
        )
    }
    
    
    private func setupConstraints(){
        collectionView.snp.makeConstraints{  make in
            make.center.equalToSuperview()
            make.width.equalTo(320)
            make.height.equalTo(400)
        }
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

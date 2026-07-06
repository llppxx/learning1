//
//  PostViewCotroller.swift
//  learning1
//
//  Created by Lipeixuan on 2026/7/6.
//

import UIKit
import SnapKit

struct PostModel {
    let imageName: String
    let title: String
    var likeCount: Int
    var isLiked: Bool
}

class PostCell: UICollectionViewCell {

    let imageView = UIImageView()
    let titleLabel = UILabel()
    let likeButton = UIButton()

    private var model: PostModel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupUI() {

        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.numberOfLines = 2

        likeButton.setTitleColor(.systemRed, for: .normal)
        likeButton.addTarget(self, action: #selector(likeTap), for: .touchUpInside)

        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(likeButton)

        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(150)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(6)
            make.left.right.equalToSuperview().inset(8)
        }

        likeButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.left.equalTo(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }

    func configure(model: PostModel) {
        self.model = model
        imageView.image = UIImage(named: model.imageName)
        titleLabel.text = model.title
        updateLikeUI()
    }
    private func updateLikeUI() {
        guard let model = model else { return }

        let heart = model.isLiked ? "❤️" : "🤍"
        likeButton.setTitle("\(heart) \(model.likeCount)", for: .normal)
    }

    var likeAction: ((UICollectionViewCell) -> Void)?

    @objc func likeTap() {
        likeAction?(self)
    }
}

class PostViewController: UIViewController,
                      UICollectionViewDataSource,
                          UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    
    var data: [PostModel] = [
        PostModel(imageName: "avatar1", title: "今天很开心", likeCount: 10, isLiked: false),
        PostModel(imageName: "avatar2", title: "iOS学习中", likeCount: 50, isLiked: false),
        PostModel(imageName: "avatar3", title: "UICollectionView入门", likeCount: 99, isLiked: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupCollectionView()
    }
    
    func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.frame.width - 30) / 2, height: 220)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .systemGroupedBackground
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: "PostCell")
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "PostCell",
            for: indexPath
        ) as! PostCell

        cell.configure(model: data[indexPath.item])
        cell.likeAction = { [weak self] cell in
            guard let self = self,
                  let indexPath = self.collectionView.indexPath(for: cell) else { return }

            self.data[indexPath.item].isLiked.toggle()
            self.data[indexPath.item].likeCount += self.data[indexPath.item].isLiked ? 1 : -1

            self.collectionView.reloadItems(at: [indexPath])
        }
        cell.configure(model: data[indexPath.item])
        return cell
    }
}

#if canImport(SwiftUI)
import SwiftUI

#Preview {
    PostViewController()
}
#endif

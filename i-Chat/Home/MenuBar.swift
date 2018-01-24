//
//  MenuBar.swift
//  i-Chat
//
//  Created by cindy on 2017/12/15.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // Set up  menu bar collection view
    lazy var collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    let cellId = "cellId"

    let imageNames = ["user", "cupid", "chat" ]

    var homeController: HomeViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)

        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)

        addSubview(collectionView)
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        let selectedIndexPath = IndexPath(item: 1, section: 0)

        // View 先出現第一個cell
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition())

        // 底線
        setupHorizontalBar()
    }

    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?

    func setupHorizontalBar() {

        let horizontalBarView = UIView()

        horizontalBarView.backgroundColor = UIColor(red: 215/255.0, green: 38/255.0, blue: 56/255.0, alpha: 1)

        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(horizontalBarView)

        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)

        horizontalBarLeftAnchorConstraint?.isActive = true

        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true

        horizontalBarView.heightAnchor.constraint(equalToConstant: 3).isActive = true
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        homeController?.scrollToMenuIndex(indexPath.item)

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // swiftlint:disable force_cast

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell

        // swiftlint:enable force_cast

        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)

        cell.tintColor = .white

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: frame.width / 3, height: frame.height - 20)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return 0

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

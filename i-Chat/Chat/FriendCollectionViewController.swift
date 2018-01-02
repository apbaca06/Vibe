//
//  FriendCollectionViewController.swift
//  i-Chat
//
//  Created by cindy on 2018/1/2.
//  Copyright © 2018年 Jui-hsin.Chen. All rights reserved.
//

import Foundation

class FriendCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let layout = UICollectionViewFlowLayout()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)

        layout.itemSize = CGSize(width: 60, height: 60)

        layout.scrollDirection = .horizontal

        layout.minimumLineSpacing = 0

        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height), collectionViewLayout: layout)

        collectionView.delegate = self

        collectionView.dataSource = self

        collectionView.backgroundColor = .darkGray

        collectionView.setCollectionViewLayout(layout, animated: true)

        let nib = UINib(
            nibName: "FriendCollectionViewCell",
            bundle: nil
        )

        collectionView.register(nib, forCellWithReuseIdentifier: "FriendCollectionViewCell")

        view.addSubview(collectionView)

        let collectionViewTop = NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)

        let collectionViewLeading = NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)

        let collectionViewHeight = NSLayoutConstraint(item: collectionView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0)

        let collectionViewWidth = NSLayoutConstraint(item: collectionView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        view.addConstraints([collectionViewTop, collectionViewLeading, collectionViewHeight, collectionViewWidth])

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // swiftlint:disable force_cast

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCollectionViewCell", for: indexPath) as! FriendCollectionViewCell

        // swiftlint:enable force_cast

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

}

//
//  FriendCollectionViewController.swift
//  i-Chat
//
//  Created by cindy on 2018/1/2.
//  Copyright © 2018年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import Nuke

class FriendCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let layout = UICollectionViewFlowLayout()

    var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        layout.scrollDirection = .horizontal

        layout.minimumLineSpacing = 0

        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height), collectionViewLayout: layout)

        collectionView.delegate = self

        collectionView.dataSource = self

        collectionView.backgroundColor = .white

        FirebaseManager.getFriendList { (friends) in
            print(friends)
            self.users = friends
            collectionView.reloadData()

        }

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

        guard let url = URL(string: users[indexPath.row].profileImgURL)
            else { return cell }

        Manager.shared.loadImage(with: url, into: cell.profileImageView)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 135)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

}

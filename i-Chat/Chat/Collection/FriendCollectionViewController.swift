//
//  FriendCollectionViewController.swift
//  i-Chat
//
//  Created by cindy on 2018/1/2.
//  Copyright © 2018年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import Nuke
import KeychainSwift

protocol FriendCollectionViewControllerDelegate: class {
    func controller(_ controller: FriendCollectionViewController, didCall user: (User, String))

}

class FriendCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    weak var delegate: FriendCollectionViewControllerDelegate?

    let layout = UICollectionViewFlowLayout()

    typealias UserWithChat = (User, String)

    var users: [UserWithChat] = []

    var collectionView: UICollectionView!

    let keychain = KeychainSwift()

    override func viewDidLoad() {
        super.viewDidLoad()

        layout.scrollDirection = .horizontal

        layout.minimumLineSpacing = 0

        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height), collectionViewLayout: layout)

        collectionView.delegate = self

        collectionView.dataSource = self

        collectionView.backgroundColor = .white

        let nib2 = UINib(
            nibName: "FriendCollectionReusableView",
            bundle: nil
        )

        collectionView.register(nib2, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView")

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FirebaseManager.getFriendList(eventType: .value) { (friends) in
            self.users = friends
            self.collectionView.reloadData()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.users = []
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // swiftlint:disable force_cast

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCollectionViewCell", for: indexPath) as! FriendCollectionViewCell

        // swiftlint:enable force_cast

        guard let url = URL(string: users[indexPath.row].0.profileImgURL)
            else { return cell }

        Manager.shared.loadImage(with: url, into: cell.profileImageView)

        cell.friendName.text = users[indexPath.row].0.name
        cell.callButton.addTarget(self, action: #selector(call(_:)), for: .touchUpInside)

        return cell
    }

    @objc func call(_ sender: UIButton) {
        guard
            let callButton = sender as? UIButton,
            let cell = callButton.superview?.superview as? FriendCollectionViewCell,
            let indexPath = self.collectionView.indexPath(for: cell)
            else { return }

        self.delegate?.controller(self, didCall: users[indexPath.row])

            print("****,Callsession\(CallManager.shared.session)")

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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        return CGSize(width: 100, height: 135)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {

        case UICollectionElementKindSectionHeader:

            // swiftlint:disable force_cast
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath)
                as! FriendCollectionReusableView
            // swiftlint:enable force_cast

            headerView.label.text = NSLocalizedString("Likes", comment: "")
            headerView.numberOfLikeLabel.text = "10+"

            return headerView

        default:

            assert(false, "Unexpected element kind")
        }
    }

}

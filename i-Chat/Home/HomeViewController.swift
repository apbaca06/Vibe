//
//  HomeViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/15.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit
import SVProgressHUD
import KeychainSwift
import Firebase
import CoreLocation
import Koloda
import Nuke

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UserProviderDelegate {

    func userProvider(_ provider: UserProvider, didFetch users: [User], didGet distanceBtwn: [Int], didFetch currentUser: User) {
        self.userArray = users
        self.distanceBtwnArray = distanceBtwn
        self.currentUser = currentUser

        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }

    let userProvider = UserProvider()

    let friendCollectionViewController = FriendCollectionViewController()

    let keychain = KeychainSwift()

    let friendViewController = FriendTableViewController()

    var currentUser: User?

    var userArray: [User] = []

    var distanceBtwnArray: [Int] = []

    let locationManager = CLLocationManager()

    var cityName: String?

    var imageArray: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        userProvider.loadSwipeImage()

        userProvider.delegate = self

        // self class must conform to QBRTCClientDelegate protocol
        QBRTCClient.instance().add(self)

        QBRTCAudioSession.instance().initialize()

        SVProgressHUD.dismiss()

        setupCollectionView()

        setupMenuBar()

        setupNibCell()

        scrollToMenuIndex(1)

        setupLocationManager()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func setupNibCell() {

        let nib1 = UINib(
            nibName: "ProfileCollectionViewCell",
            bundle: nil
        )

        collectionView?.register(
            nib: nib1,
            forCellWithClass: ProfileCollectionViewCell.self
        )

        let nib2 = UINib(
            nibName: "SwipingCollectionViewCell",
            bundle: nil
        )

        collectionView?.register(
            nib: nib2,
            forCellWithClass: SwipingCollectionViewCell.self
        )

        let nib3 = UINib(
            nibName: "ChatCollectionViewCell",
            bundle: nil
        )

        collectionView?.register(
            nib: nib3,
            forCellWithClass: ChatCollectionViewCell.self
        )
    }

    func setupCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {

            flowLayout.scrollDirection = .horizontal

            flowLayout.minimumLineSpacing = 0

        }

        collectionView?.backgroundColor = .gray

        collectionView?.register(

            ProfileCollectionViewCell.self,

            forCellWithReuseIdentifier: HomeComponent.profile.rawValue
        )

        collectionView?.register(

            SwipingCollectionViewCell.self,

            forCellWithReuseIdentifier: HomeComponent.swipe.rawValue
        )

        collectionView?.register(

            ChatCollectionViewCell.self,

            forCellWithReuseIdentifier: "ChatCollectionViewCell"
        )

        collectionView?.contentInset = UIEdgeInsets(top: 70, left: 0, bottom: 0, right: 0)

        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 70, left: 0, bottom: 0, right: 0)

        collectionView?.isPagingEnabled = true
    }

    func scrollToMenuIndex(_ menuIndex: Int) {

        let indexPath = IndexPath(

            item: menuIndex,

            section: 0
        )

        collectionView?.scrollToItem(

            at: indexPath,

            at: UICollectionViewScrollPosition(),

            animated: true
        )

    }

    lazy var menuBar: MenuBar = {

        let menuBar = MenuBar()

        menuBar.homeController = self

        return menuBar
    }()

    fileprivate func setupMenuBar() {

        view.addSubview(menuBar)

        view.addConstraints(withFormat: "H:|[v0]|", views: menuBar)

        view.addConstraints(withFormat: "V:|[v0(70)]|", views: menuBar)

        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {

        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 3

    }

    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let index = targetContentOffset.pointee.x / view.frame.width

        let indexPath = IndexPath(item: Int(index), section: 0)

        menuBar.collectionView.selectItem(

            at: indexPath,

            animated: true,

            scrollPosition: UICollectionViewScrollPosition()
        )

    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let identifier: String

        if indexPath.item == 0 {

            identifier = HomeComponent.profile.rawValue

            // swiftlint:disable force_cast

            let cell = collectionView.dequeueReusableCell(

                withReuseIdentifier: identifier,

                for: indexPath

                ) as! ProfileCollectionViewCell

            // swiftlint:enable force_cast

            cell.toSettingButton.addTarget(self, action: #selector(toSettingPage), for: .touchUpInside)

            let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(changeImg))

            cell.profileImg.isUserInteractionEnabled = true

            cell.profileImg.addGestureRecognizer(longPressGestureRecognizer)

            return cell

        } else if indexPath.item == 1 {

            identifier = HomeComponent.swipe.rawValue

            // swiftlint:disable force_cast

            let cell = collectionView.dequeueReusableCell(

                withReuseIdentifier: identifier,

                for: indexPath

                ) as! SwipingCollectionViewCell

                // swiftlint:enable force_cast

            cell.swipeView.delegate = self

            cell.swipeView.dataSource = self

            return cell

        } else {

            identifier = "ChatCollectionViewCell"

            // swiftlint:disable force_cast

            let cell = collectionView.dequeueReusableCell(

                withReuseIdentifier: identifier,

                for: indexPath

            ) as! ChatCollectionViewCell

            // swiftlint:enable force_cast

            cell.contentView.addSubviews([friendViewController.view, friendCollectionViewController.view])

            friendCollectionViewController.view.topAnchor.constraint(equalTo: cell.contentView.topAnchor).isActive = true

            friendCollectionViewController.view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor).isActive = true

            friendCollectionViewController.view.widthAnchor.constraint(equalTo: cell.contentView.widthAnchor).isActive = true

            friendCollectionViewController.view.heightAnchor.constraint(equalToConstant: 135).isActive = true

            friendViewController.view.topAnchor.constraint(equalTo: friendCollectionViewController.view.bottomAnchor).isActive = true

            friendViewController.view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor).isActive = true

            friendViewController.view.widthAnchor.constraint(equalTo: cell.contentView.widthAnchor).isActive = true

            friendViewController.view.heightAnchor.constraint(equalTo: cell.contentView.heightAnchor, multiplier: 1, constant: -135).isActive = true

            friendCollectionViewController.view.translatesAutoresizingMaskIntoConstraints = false

            friendViewController.view.translatesAutoresizingMaskIntoConstraints = false

            return cell

        }

    }

    @objc func callOther() {

        QBRTCAudioSession.instance().currentAudioDevice = .receiver

        // swiftlint:disable force_cast
        let callOutViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CallOutViewController") as! CallOutViewController
        // swiftlint:enable force_cast

        self.present(callOutViewController, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: view.frame.width, height: view.frame.height - 70)

    }
}

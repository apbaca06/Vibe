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
import Crashlytics

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UserProviderDelegate {
    func userProvider(_ provider: UserProvider, didFetch distanceUser: [(User, Int)], didFetch allUsers: [(User, Int)], didFetch currentUser: User) {
        self.allUsers = allUsers
        self.distanceUsers = distanceUser
        self.currentUser = currentUser
        self.collectionView?.reloadData()
    }

    var distanceUsers: [(User, Int)] = []

    var allUsers: [(User, Int)] = []

    var userInfo: [String: String]?

    let userProvider = UserProvider()

    let locationManager = CLLocationManager()

    let friendCollectionViewController = FriendCollectionViewController()

    let friendViewController = FriendTableViewController()

    let settingTableViewController = SettingTableViewController()

    let keychain = KeychainSwift()

    var currentUser: User?

    typealias UserWithChatBlock = (User, String, Bool)

    var friends: [UserWithChatBlock] = []

    var distanceBtwnArray: [Int] = [] {
        didSet {
            // swiftlint:disable force_cast
            let cell = self.collectionView?.cellForItem(at: IndexPath(item: 1, section: 0)) as! SwipingCollectionViewCell
            // swiftlint:enable force_cast
            cell.swipeView.reloadData()
        }
    }

    var imageArray: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationManager.delegate = self

        self.locationManager.distanceFilter = kCLLocationAccuracyBest

        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest

        locationManager.requestWhenInUseAuthorization()

        locationManager.startUpdatingLocation()

        friendCollectionViewController.delegate = self

        FirebaseManager.getFriendList(eventType: .value) { (friends) in
            self.friends = friends
            self.collectionView?.reloadData()
        }

        userProvider.delegate = self

        QBRTCClient.instance().add(self)

        QBRTCAudioSession.instance().initialize()

        setupCollectionView()

        setupMenuBar()

        setupNibCell()

        scrollToMenuIndex(1)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userProvider.loadSwipeImage(prefUserObserveType: .value)
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

        collectionView?.backgroundColor = .white

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

            guard let profileImgString = keychain.get("profileImgURL"),
                  let age = keychain.get("age"),
                  let name = keychain.get("name")

            else { return cell }

            cell.ageLabel.text = "\(age) yr"

            cell.nameLabel.text = name

            if let profileImgURL = URL(string: profileImgString) {

                Manager.shared.loadImage(with: profileImgURL, into: cell.profileImg)
                Manager.shared.loadImage(with: profileImgURL, into: cell.circleProfileImg)

                cell.profileImg.contentMode = .scaleAspectFill
            }

            let tapGestureRecognizer =
                UITapGestureRecognizer(target: self, action: #selector(showSelfProfile))

            cell.profileImg.isUserInteractionEnabled = true

            cell.profileImg.addGestureRecognizer(tapGestureRecognizer)

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

            cell.swipeView.resetCurrentCardIndex()

            cell.turningIndicator.startAnimating()

            return cell

        } else {

            identifier = "ChatCollectionViewCell"

            // swiftlint:disable force_cast

            let cell = collectionView.dequeueReusableCell(

                withReuseIdentifier: identifier,

                for: indexPath

            ) as! ChatCollectionViewCell

            // swiftlint:enable force_cast

            friendCollectionViewController.users = self.friends

            if friends.count > 0 {
                cell.numberLabel.text = "\(friends.count)"
            } else {
                cell.numberLabel.text = "0"
            }
        cell.contentView.addSubviews([ friendCollectionViewController.view])

        self.addChildViewController(friendCollectionViewController)

//            cell.contentView.addSubviews([friendViewController.view, friendCollectionViewController.view])

            friendCollectionViewController.view.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 80).isActive = true

            friendCollectionViewController.view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor).isActive = true

            friendCollectionViewController.view.widthAnchor.constraint(equalTo: cell.contentView.widthAnchor).isActive = true

            friendCollectionViewController.view.heightAnchor.constraint(equalTo: cell.contentView.heightAnchor).isActive = true

            friendCollectionViewController.view.translatesAutoresizingMaskIntoConstraints = false

            //            friendCollectionViewController.view.heightAnchor.constraint(equalToConstant: 135).isActive = true

            //            friendViewController.view.topAnchor.constraint(equalTo: friendCollectionViewController.view.bottomAnchor).isActive = true
            //
            //            friendViewController.view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor).isActive = true
            //
            //            friendViewController.view.widthAnchor.constraint(equalTo: cell.contentView.widthAnchor).isActive = true
            //
            //            friendViewController.view.heightAnchor.constraint(equalTo: cell.contentView.heightAnchor, multiplier: 1, constant: -135).isActive = true

            //            friendViewController.view.translatesAutoresizingMaskIntoConstraints = false

            return cell

        }

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: view.frame.width, height: view.frame.height - 70)

    }

}

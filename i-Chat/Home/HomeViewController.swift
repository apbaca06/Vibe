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

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let locationManager = CLLocationManager()

    var cityName: String?

    override func viewDidLoad() {
        super.viewDidLoad()

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

        collectionView?.backgroundColor = .clear

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

        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)

        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)

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

            return cell

        } else {

            identifier = "ChatCollectionViewCell"

            // swiftlint:disable force_cast

            let cell = collectionView.dequeueReusableCell(

                withReuseIdentifier: identifier,

                for: indexPath

            ) as! ChatCollectionViewCell

            // swiftlint:enable force_cast

            cell.button.addTarget(self, action: #selector(callOther), for: .touchUpInside)

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

        return CGSize(width: view.frame.width, height: view.frame.height - 90)

    }
}

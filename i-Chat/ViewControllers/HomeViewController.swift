//
//  HomeViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/15.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit
import SVProgressHUD

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let settingCellId = "settingCellId"

    let swipingCellId = "swipingCellId"

    let chatCellId = "chatCellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self class must conform to QBRTCClientDelegate protocol
        QBRTCClient.instance().add(self)
        
        QBRTCAudioSession.instance().initialize()

        SVProgressHUD.dismiss()
        
        setupCollectionView()

        setupMenuBar()

    }

    func setupCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {

            flowLayout.scrollDirection = .horizontal

            flowLayout.minimumLineSpacing = 0
        }

        collectionView?.backgroundColor = .white

        collectionView?.register(SettingCollectionViewCell.self, forCellWithReuseIdentifier: settingCellId)

        collectionView?.register(SwipingCollectionViewCell.self, forCellWithReuseIdentifier: swipingCellId)

        collectionView?.register(ChatCollectionViewCell.self, forCellWithReuseIdentifier: chatCellId)

        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)

        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)

        collectionView?.isPagingEnabled = true
    }

    func scrollToMenuIndex(_ menuIndex: Int) {

        let indexPath = IndexPath(item: menuIndex, section: 0)

        collectionView?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition(), animated: true)

    }

    lazy var menuBar: MenuBar = {

        let menuBar = MenuBar()

        menuBar.homeController = self

        return menuBar
    }()

    fileprivate func setupMenuBar() {

        view.addSubview(menuBar)
        
        view.addConstraints(withFormat: "H:|[v0]|", views: menuBar)
        
        view.addConstraints(withFormat: "V:[v0(50)]", views: menuBar)

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

        if indexPath.item == 1 {

            identifier = settingCellId

        } else if indexPath.item == 2 {

            identifier = swipingCellId

        } else {

            identifier = chatCellId

        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: view.frame.width, height: view.frame.height - 50)

    }

}

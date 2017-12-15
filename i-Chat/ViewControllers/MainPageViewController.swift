////
////  MainPageViewController.swift
////  i-Chat
////
////  Created by cindy on 2017/12/15.
////  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
////
//
//import UIKit
//
//class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        collectionView?.backgroundColor = UIColor.white
//        
////        collectionView?.registerClass(VideoCell.self, forCellWithReuseIdentifier: "cellId")
//        
//        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
//        collectionView?.scrollInadicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
//        
//        setupMenuBar()
//    }
//    
//    let menuBar: MenuBar = {
//        let mb = MenuBar()
//        return mb
//    }()
//    
//    private func setupMenuBar() {
//        view.addSubview(menuBar)
//        view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
//        view.addConstraintsWithFormat("V:|[v0(50)]", views: menuBar)
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//    }
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = (view.frame.width - 16 - 16) * 9 / 16
//        return CGSize(view.frame.width, height + 16 + 68)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    
//}

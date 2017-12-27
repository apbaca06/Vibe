//
//  SwipeViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/27.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import Koloda
import Firebase

class SwipeViewController: UIViewController {

    var dataSource = [#imageLiteral(resourceName: "chicken"), #imageLiteral(resourceName: "heart"), #imageLiteral(resourceName: "cancel"), #imageLiteral(resourceName: "cupid")]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal

        DatabasePath.userRef.queryOrdered(byChild: "profileImgURL").observe(.value) { (datasnapshot) in
            print("***", datasnapshot)
        }

    }
}

// MARK: KolodaViewDelegate

extension SwipeViewController: KolodaViewDelegate {

    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {

        let position = koloda.currentCardIndex
//        for i in 1...4 {
//            dataSource.append(UIImage(named: "Card_like_\(i)")!)
//        }
//        koloda.insertCardAtIndexRange(position..<position + 4, animated: true)
    }

    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
    }

}

// MARK: KolodaViewDataSource

extension SwipeViewController: KolodaViewDataSource {

    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return dataSource.count
    }

    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }

    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return UIImageView(image: dataSource[Int(index)])
    }

    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? OverlayView
    }
}

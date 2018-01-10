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
import Crashlytics

protocol FriendCollectionViewControllerDelegate: class {
    func controller(_ controller: FriendCollectionViewController, didCall user: (User, String, Bool))

}

class FriendCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    weak var delegate: FriendCollectionViewControllerDelegate?

    let layout = UICollectionViewFlowLayout()

    typealias UserWithChatBlock = (User, String, Bool)

    var users: [UserWithChatBlock] = []

    var collectionView: UICollectionView!

    let keychain = KeychainSwift()

    override func viewDidLoad() {
        super.viewDidLoad()

        layout.scrollDirection = .vertical

        layout.minimumInteritemSpacing = 10

        layout.minimumLineSpacing = 10

        layout.minimumLineSpacing = 0

        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height), collectionViewLayout: layout)

        collectionView.contentInset = UIEdgeInsets(top: 15, left: 30, bottom: 0, right: 30)

        collectionView.delegate = self

        collectionView.dataSource = self

        collectionView.backgroundColor = .white

//        let nib2 = UINib(
//            nibName: "FriendCollectionReusableView",
//            bundle: nil
//        )
//
//        collectionView.register(nib2, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView")

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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if users.count == 0 {
            // swiftlint:disable force_cast
            let noFriendViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoFriendViewController") as! NoFriendViewController
            // swiftlint:enable force_cast
            noFriendViewController.modalPresentationStyle = .formSheet
            noFriendViewController.modalTransitionStyle = .crossDissolve

            self.addChildViewController(noFriendViewController)

            self.view.addSubview(noFriendViewController.view)
            noFriendViewController.didMove(toParentViewController: self)

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

        cell.callButton.addTarget(self, action: #selector(call(_:)), for: .touchUpInside)

        cell.friendName.text = users[indexPath.row].0.name

        if users[indexPath.row].2 == true {
            cell.callButton.tintColor = .gray
            cell.friendName.textColor = .gray
            cell.profileImageView.tintColor = .gray
        } else {
            cell.friendName.textColor = .black

            cell.callButton.tintColor = UIColor(red: 215/255.0, green: 38/255.0, blue: 56/255.0, alpha: 1)
            cell.profileImageView.tintColor = UIColor(red: 215/255.0, green: 38/255.0, blue: 56/255.0, alpha: 1)
        }

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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let uid = self.keychain.get("uid")
            else { return }

        let actionSheetController = UIAlertController(title: NSLocalizedString("Please select", comment: "" ), message: "", preferredStyle: .actionSheet)

        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ -> Void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)

        // swiftlint:disable force_cast
        let reportActionSheet = UIAlertAction(title: NSLocalizedString("Report", comment: "" ), style: .default) { _ -> Void in

        let reportViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReportViewController") as! ReportViewController
        // swiftlint:enable force_cast
            reportViewController.reportedID = self.users[indexPath.row].0.id

            self.present(reportViewController, animated: true, completion: nil)

            print("Report")
        }
        actionSheetController.addAction(reportActionSheet)

        let blockActionButton = UIAlertAction(title: NSLocalizedString("Block", comment: "" ), style: .default) { _ -> Void in
            let alertController = UIAlertController(title: NSLocalizedString("You may never unoblock!", comment: ""), message: "Please be sure to block \(self.users[indexPath.row].0.name)", preferredStyle: .alert)
            let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
            alertController.addAction(cancel)
            let block = UIAlertAction(title: NSLocalizedString("Block", comment: ""), style: .default, handler: { (_) in

                DatabasePath.userFriendRef.child(uid).child(self.users[indexPath.row].0.id).updateChildValues(["block": true])
                DatabasePath.userFriendRef.child(self.users[indexPath.row].0.id).child(uid).updateChildValues(["block": true])

                let alertController = UIAlertController(title: NSLocalizedString("\(self.users[indexPath.row].0.name) is blocked!", comment: ""), message: "\(self.users[indexPath.row].0.name) can never contact you again.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
                alertController.addAction(okAction)
                alertController.show()
            })

            alertController.addAction(block)
            alertController.show()
            print("Block")
        }
        actionSheetController.addAction(blockActionButton)
        self.present(actionSheetController, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 140)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//
//        return CGSize(width: self.view.bounds.width, height: 80)
//    }

//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        switch kind {
//
//        case UICollectionElementKindSectionHeader:
//
//

//            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath)
//                as! FriendCollectionReusableView

//            headerView.numberOfFriends.layer.cornerRadius = headerView.numberOfFriends.bounds.width/2
//            headerView.numberOfFriends.text = "\(self.users.count)"
//
//            return headerView
//
//        default:
//
//            assert(false, "Unexpected element kind")
//        }
//    }

}

//
//  SetImgViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/21.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
import KeychainSwift
import SVProgressHUD
import Crashlytics

class SetImgViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var dismissButton: UIButton!

    @IBOutlet weak var imgView: UIImageView!

    var profilePic: ProfileImage?

    var imageIsUploaded: Bool = false

    let keychain = KeychainSwift()

    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionLabel.text = NSLocalizedString("Tap to add photo!", comment: "")

        dismissButton.setTitle(NSLocalizedString("Go to chat!", comment: ""), for: .normal)

        dismissButton.cornerRadius = 10

        imgView.cornerRadius = 40

        if #available(iOS 11.0, *) {
            imgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }

    }

    @IBAction func tapGesture(_ sender: Any) {

        changePhoto()

    }

    func changePhoto() {

        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {

            let controller = UIImagePickerController()

            controller.delegate = self

            controller.sourceType = .photoLibrary

            controller.allowsEditing = true

            self.present(controller, animated: true, completion: nil)

        }

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

        dismiss(animated: true, completion: nil)
        let alert = UIAlertController(title: NSLocalizedString("Please select one photo", comment: ""), message: NSLocalizedString("For people to know you better", comment: ""), preferredStyle: .alert)

        alert.addAction(title: NSLocalizedString("OK", comment: ""))

        alert.show()

    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {

        guard
            let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage,
            let uid = keychain.get("uid")
            else { return }

        profilePic = ProfileImage(profileImage: selectedImage)

        imgView.image = profilePic?.profileImage

        imgView.contentMode = .scaleAspectFit

        self.dismiss(animated: true, completion: nil)

        SVProgressHUD.show(withStatus: NSLocalizedString("Saving Photo", comment: ""))

        // Points to the root reference
        let storageRef = Storage.storage().reference()

        // Points to "images"
        let imagesRef = storageRef.child("profileImg").child(uid)

        // Data in memory
        let data: Data = UIImageJPEGRepresentation(selectedImage, 0.5)!

        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = imagesRef.putData(data, metadata: nil) { (metadata, error) in

            SVProgressHUD.show(withStatus: NSLocalizedString("Uploading Photo", comment: ""))

            guard let metadata = metadata

            else {
                let alertController = UIAlertController(title: NSLocalizedString("Having trouble saving photo!", comment: ""), message: "We will try to fix it soon!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
                alertController.addAction(okAction)
                alertController.show()
                print(error)
                return
            }
            // Metadata contains file metadata such as size, content-type, and download URL.
            guard let downloadURL = metadata.downloadURL(),
                  let gender = UserDefaults.standard.string(forKey: "Gender"),
                  let preference = UserDefaults.standard.string(forKey: "Preference")
                else { return }
                let age = UserDefaults.standard.integer(forKey: "Age")

            DatabasePath.userRef
                .child(uid)
                .updateChildValues(
                    ["gender": "\(gender)",
                     "preference": "\(preference)",
                     "age": age,
                     "agePreference": ["min": 18, "max": 55],
                     "maxDistance": 160,
                     "likeList": ["test": 0],
                     "profileImgURL": "\(downloadURL)" ], withCompletionBlock: { (_, databaseReference) in

                    self.imageIsUploaded = true

                    SVProgressHUD.dismiss()
                    print(databaseReference, "*****")
            })

        }
    }

    @IBAction func dismissController(_ sender: Any) {

        if profilePic?.profileImage != nil  && imageIsUploaded == true {

            navigationController?.popToRootViewController(animated: true)

            let layout = UICollectionViewFlowLayout()

            AppDelegate.shared.window?.rootViewController = HomeViewController(collectionViewLayout: layout)

        } else {

            let alert = UIAlertController(title: NSLocalizedString("Please select one photo", comment: ""), message: NSLocalizedString("For people to know you better", comment: ""), preferredStyle: .alert)

            alert.addAction(title: NSLocalizedString("OK", comment: ""))

            alert.show()
        }
    }
}

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

class SetImgViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var dismissButton: UIButton!

    @IBOutlet weak var imgView: UIImageView!

    var profilePic: ProfileImage?

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
            let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage
            else { return }

        profilePic = ProfileImage(profileImage: selectedImage)

        imgView.image = profilePic?.profileImage

        imgView.contentMode = .scaleAspectFit

        self.dismiss(animated: true, completion: nil)

        // Points to the root reference
        let storageRef = Storage.storage().reference()

        // Points to "images"
        let imagesRef = storageRef.child("profileImg").child(FirebaseManager.uid)

        // Data in memory
        let data: Data = UIImageJPEGRepresentation(selectedImage, 0.5)!

        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = imagesRef.putData(data, metadata: nil) { (metadata, error) in

            guard let metadata = metadata

            else {
                print(error)
                return
            }
            // Metadata contains file metadata such as size, content-type, and download URL.
            guard let downloadURL = metadata.downloadURL()

                else { return }

            print("***", downloadURL)
            DatabasePath.userRef.child(FirebaseManager.uid).updateChildValues(["profileImgURL": "\(downloadURL)"])

        }
    }

    @IBAction func dismissController(_ sender: Any) {

        if profilePic?.profileImage != nil {

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

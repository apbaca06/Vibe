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

    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var imgView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func tapGesture(_ sender: Any) {

        changePhoto()

    }

    func changePhoto() {

        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {

            let controller = UIImagePickerController()

            controller.delegate = self

            controller.sourceType = .photoLibrary

            self.present(controller, animated: true, completion: nil)

        }

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

        dismiss(animated: true, completion: nil)

    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        guard
            let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            else { return }

        imgView.image = selectedImage

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

        navigationController?.popToRootViewController(animated: true)

        let layout = UICollectionViewFlowLayout()

        AppDelegate.shared.window?.rootViewController = HomeViewController(collectionViewLayout: layout)
    }
}

//
//  SetImgViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/21.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import Firebase

class SetImgViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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

        // Points to the root reference
        let storageRef = Storage.storage().reference()

        // Points to "images"
        let imagesRef = storageRef.child("images")

        // Points to "images/space.jpg"
        // Note that you can use variables to create child values
        let fileName = "space.jpg"
        let spaceRef = imagesRef.child(fileName)

        // File path is "images/space.jpg"
        let path = spaceRef.fullPath

        // File name is "space.jpg"
        let name = spaceRef.name

        // Points to "images"
        let images = spaceRef.parent()

    }
}

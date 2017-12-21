//
//  SetImgViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/21.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation

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

        dismiss(animated: true, completion: nil)

        dismiss(animated: true, completion: nil)

    }
}

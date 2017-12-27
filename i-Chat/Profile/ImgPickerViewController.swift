//
//  ImgPickerViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/21.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import KeychainSwift
import Firebase

protocol ImgPickerViewControllerDelegate: class {

}

class ImgPickerViewController: UIImagePickerController {

    let keychain = KeychainSwift()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
//        
//        guard
//            let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage,
//            let uid = keychain.get("uid")
//            else { return }
//        
////        profilePic = ProfileImage(profileImage: selectedImage)
////        
////        imgView.image = profilePic?.profileImage
////        
////        imgView.contentMode = .scaleAspectFit
////        
//        self.dismiss(animated: true, completion: nil)
//        
//        // Points to the root reference
//        let storageRef = Storage.storage().reference()
//        
//        // Points to "images"
//        let imagesRef = storageRef.child("profileImg").child(uid)
//        
//        // Data in memory
//        let data: Data = UIImageJPEGRepresentation(selectedImage, 0.5)!
//        
//        // Upload the file to the path "images/rivers.jpg"
//        let uploadTask = imagesRef.putData(data, metadata: nil) { (metadata, error) in
//            
//            guard let metadata = metadata
//                
//                else {
//                    print(error)
//                    return
//            }
//            // Metadata contains file metadata such as size, content-type, and download URL.
//            guard let downloadURL = metadata.downloadURL()
//                
//                else { return }
//            DatabasePath.userRef.child(uid).updateChildValues([
//                "profileImgURL": "\(downloadURL)",
//                ])
//            
//        }
//    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

        dismiss(animated: true, completion: nil)
        let alert = UIAlertController(title: NSLocalizedString("Please select one photo", comment: ""), message: NSLocalizedString("For people to know you better", comment: ""), preferredStyle: .alert)

        alert.addAction(title: NSLocalizedString("OK", comment: ""))

        alert.show()

    }

}

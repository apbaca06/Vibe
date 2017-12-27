//
//  SliderTableViewCell.swift
//  i-Chat
//
//  Created by cindy on 2017/12/27.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit
import KeychainSwift

class SliderTableViewCell: UITableViewCell {

    @IBOutlet weak var leftLabel: UILabel!

    @IBOutlet weak var rightLabel: UILabel!

    @IBOutlet weak var slider: UISlider!

    let keychain = KeychainSwift()

    override func awakeFromNib() {
        super.awakeFromNib()

        guard let uid = keychain.get("uid")
            else { return }
        DatabasePath.userRef.child(uid).observeSingleEvent(of: .value) { [unowned self](datashot) in

            print("***", datashot)

            self.rightLabel.text = "50Km"
        }
    }

    @IBAction func sliderValueChange(_ sender: UISlider) {

        rightLabel.text = "\(String(describing: Int(sender.value)))Km"

        guard let uid = keychain.get("uid")
            else { return }
        DatabasePath.userRef.child(uid).updateChildValues(["maxDistance": Int(sender.value)])
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

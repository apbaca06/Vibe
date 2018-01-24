//
//  StoryboardExtension.swift
//  i-Chat
//
//  Created by cindy on 2018/1/24.
//  Copyright © 2018年 Jui-hsin.Chen. All rights reserved.
//

import Foundation

extension UIViewController {

    static func load<VC: UIViewController>(_ type: VC.Type) -> VC {
        let mainStorybard = UIStoryboard(name: "Main", bundle: nil)
        let identifier = String(describing: type)
        let controller = mainStorybard.instantiateViewController(withIdentifier: identifier)
        // swiftlint:disable force_cast
        return controller as! VC
        // swiftlint:enable force_cast
    }

}

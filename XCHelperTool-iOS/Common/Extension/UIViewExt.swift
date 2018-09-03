//
//  UIViewExt.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/28.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

extension UIView {
    func copyView() -> Any? {
        let tempArchive = NSKeyedArchiver.archivedData(withRootObject: self)
        let view = NSKeyedUnarchiver.unarchiveObject(with: tempArchive)
        return view
    }
}

//
//  CustomView.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/7/6.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 透明的View
class ClearView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
    }
}

/// 主题颜色的View
class ThemeView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        frame = CGRect(x: 0, y: -UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        backgroundColor = UIColor.theme
    }
}

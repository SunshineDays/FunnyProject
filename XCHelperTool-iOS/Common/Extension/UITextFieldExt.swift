//
//  UITextFieldExt.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/8.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

extension UITextField {
    /// 设置占位符的文字以及字体大小
    public func placeholder(_ placeholder: String, font: CGFloat = 17) {
        let placeholderString = NSMutableAttributedString(string: placeholder)
        placeholderString.addAttribute(.font, value: UIFont.systemFont(ofSize: font), range: NSRange(location: 0, length: placeholder.count))
        attributedPlaceholder = placeholderString
    }
        
}

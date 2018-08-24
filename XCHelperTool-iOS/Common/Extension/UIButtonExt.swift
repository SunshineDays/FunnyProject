//
//  UIButtonExt.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/6.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

extension UIButton {
    /// 更新底部黄色按钮的状态
    ///
    /// - Parameters:
    ///   - textFields: textField的数组
    ///   - types: InputTextType
    func updateEnabled(textFields: [UITextField], types: [InputTextType]) {
        var isEnabled = true
        for (index, textField) in textFields.enumerated() {
            if (textField.text ?? "").count < types[index].minCount {
                isEnabled = false
                break
            }
        }
        isUserInteractionEnabled = isEnabled
        isSelected = isEnabled
    }
}





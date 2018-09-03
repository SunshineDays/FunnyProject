//
//  UIViewControllerExt.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/7/3.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlertController(title: String?,
                              message: String?,
                         confirmTitle: String = "确定",
                          cancelTitle: String = "取消",
                       confirmHandler: ((UIAlertAction) -> Void)?,
                        cancelHandler: ((UIAlertAction) -> Void)?)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: confirmTitle, style: .default, handler: confirmHandler))
        alertController.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        present(alertController, animated: true, completion: nil)
    }

}

extension UIViewController {
    /// 设置导航栏样式
    ///
    /// - Parameters:
    ///   - backgroundColor: 背景颜色
    ///   - titleColor: 标题颜色
    ///   - tintColor: 两边按钮颜色
    ///   - isHiddenShadowImage: 是否隐藏底部的线
    ///   - alpha: 透明度
    func wrSetNaviBar(backgroundColor: UIColor = BaseNavigationController.naviBarDefaultBackgroundColor,
                           titleColor: UIColor = BaseNavigationController.naviBarDefaultTitleColor,
                            tintColor: UIColor = BaseNavigationController.naviBarDefaultTintColor,
                  isHiddenShadowImage: Bool = false,
                                alpha: CGFloat? = 1.0)
    {
        wr_setNavBarBarTintColor(backgroundColor)
        wr_setNavBarTitleColor(titleColor)
        wr_setNavBarTintColor(tintColor)
        wr_setNavBarShadowImageHidden(isHiddenShadowImage)
        if let alpha = alpha {
            wr_setNavBarBackgroundAlpha(alpha)
        }
    }
    
}

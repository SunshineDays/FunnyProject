//
//  BaseNavigationController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/5/31.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 自定义导航栏
class BaseNavigationController: UINavigationController {
    /// 导航栏默认的背景颜色
    static let naviBarDefaultBackgroundColor = UIColor.white
    /// 导航栏标题默认颜色
    static let naviBarDefaultTitleColor = UIColor.black
    /// 导航栏左右按钮的默认颜色
    static let naviBarDefaultTintColor = UIColor.darkGray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
        navigationBar.tintColor = BaseNavigationController.naviBarDefaultTintColor
        setNaviBarApperence()
    }
    
    func setNaviBarApperence() {
        WRNavigationBar.wr_widely()
        // 设置导航栏默认的背景颜色
        WRNavigationBar.wr_setDefaultNavBarBarTintColor(BaseNavigationController.naviBarDefaultBackgroundColor)
        // 设置导航栏标题默认颜色
        WRNavigationBar.wr_setDefaultNavBarTitleColor(BaseNavigationController.naviBarDefaultTitleColor)
        // 设置导航栏左右按钮的默认颜色
        WRNavigationBar.wr_setDefaultNavBarTintColor(BaseNavigationController.naviBarDefaultTintColor)
        // 是否隐藏底部分割线
        WRNavigationBar.wr_setDefaultNavBarShadowImageHidden(false)
        // 状态栏字体颜色
//        WRNavigationBar.wr_setDefaultStatusBarStyle(.lightContent)
        UIApplication.shared.statusBarStyle = .default
    }

}

extension BaseNavigationController: UINavigationControllerDelegate {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.tabBarController?.tabBar.isHidden = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}

extension BaseNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return childViewControllers.count > 1
    }
}

//
//  XCHomeController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/1.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 首页
class XCHomeController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let vc = R.storyboard.xcChatUp.xcChatUpController()!
            navigationController?.pushViewController(vc, animated: true)
        case (0, 1):
            let vc = R.storyboard.xcRemind.xcRemindController()!
            navigationController?.pushViewController(vc, animated: true)
        case (0, 2):
            let vc = XCSlideController()
            navigationController?.pushViewController(vc, animated: true)
            let url = URL(string: "caidian310://lottery/bet?lottery_id=42")!
            let str = AppPathUrlTool.parameter(url: url, key: "lottery_id")
            print("----" + str)
        case (0, 3):
            let vc = BaseWebViewController()
            navigationController?.pushViewController(vc, animated: true)
        case (0, 4):
            let vc = R.storyboard.xcTakeOut.xcTakeOutShopController()!
            navigationController?.pushViewController(vc, animated: true)
        case (0, 5):
            let vc = R.storyboard.xcTakeOut.xcTakeOutController()!
            navigationController?.pushViewController(vc, animated: true)
        case (0, 6):
            let vc = XCFixedHeaderController()
            navigationController?.pushViewController(vc, animated: true)
        case (0, 7):
            let vc = XCThirdController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }

}

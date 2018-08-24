//
//  XCPersonalController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/1.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 我的
class XCPersonalController: BaseTableViewController {
    
    @IBOutlet weak var infoTitleView: XCPersonalInfoTitleView!

    override func viewDidLoad() {
        super.viewDidLoad()
        wrSetNaviBar(titleColor: UIColor.clear, isHiddenShadowImage: true, alpha: 0)
        if UserToken.shared.isLogin {
            present(InterfaceCtrl.userLoginController(), animated: true, completion: nil)
        }
    }
    
    override func getData() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

extension XCPersonalController {

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeaderInSectionHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kFooterInSectionHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section, indexPath.row) {
        case (0, 1): //余额
            let vc = R.storyboard.xcBalance.xcBalanceController()!
            navigationController?.pushViewController(vc, animated: true)
        case (1, 1): //银行卡
            let vc = R.storyboard.xcBankCard.xcBankCardController()!
            navigationController?.pushViewController(vc, animated: true)
        case (1, 0): //账单
            let vc = R.storyboard.xcBill.xcBillController()!
            navigationController?.pushViewController(vc, animated: true)
        case (2, 0): //浏览历史
            let vc = R.storyboard.xcCircle.xcCircleController()!
            navigationController?.pushViewController(vc, animated: true)
        case (2, 1): //分享
            ShareTool.share(with: ShareModel(), from: self)
        default:
            break
        }
    }
    
}

extension XCPersonalController {
    @IBAction func settingItemAction(_ sender: UIBarButtonItem) {
        let vc = R.storyboard.xcSetting.xcSettingController()!
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func inforAction(_ sender: Any) {
        let vc = R.storyboard.xcInformation.xcInformationController()!
        vc.initWith(avatar: infoTitleView.avatarImageView.image!) { (avatar) in
            self.infoTitleView.avatarImageView.image = avatar
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func historyAction(_ sender: UIButton) {
        let vc = R.storyboard.xcIssue.xcIssueController()!
        let navi = BaseNavigationController(rootViewController: vc)
        present(navi, animated: true, completion: nil)
    }
    
    @IBAction func followAction(_ sender: UIButton) {
        
    }
    
    @IBAction func fansAction(_ sender: UIButton) {
        
    }
    
    
}

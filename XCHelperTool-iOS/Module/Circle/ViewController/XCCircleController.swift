//
//  XCCircleController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/8.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 朋友圈
class XCCircleController: BaseTableViewController {
    
    private var image = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        isClearNaviBackgroundColor = true
        naviBackgroundAlpha = 0
        tableView.register(R.nib.xcCircleCell)
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .default
    }

    private var isClearNaviBackgroundColor: Bool = true {
        didSet {
            wrSetNaviBar(tintColor: isClearNaviBackgroundColor ? UIColor.white : BaseNavigationController.naviBarDefaultTintColor,
               isHiddenShadowImage: isClearNaviBackgroundColor ? true : false,
                             alpha: nil)
            UIApplication.shared.statusBarStyle = isClearNaviBackgroundColor ? .lightContent : .default
        }
    }
    
    private var naviBackgroundAlpha: CGFloat = 0 {
        didSet {
            wr_setNavBarBackgroundAlpha(naviBackgroundAlpha)
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
        let changeHeight = (tableView.tableHeaderView?.frame.height ?? 200) - kNavigationHeight * 2 + kStatusBarHeight
        if y <= changeHeight {
            naviBackgroundAlpha = 0
            isClearNaviBackgroundColor = true
        } else if y > changeHeight && y < changeHeight + kNavigationHeight {
            naviBackgroundAlpha = (y - changeHeight) / kNavigationHeight
            isClearNaviBackgroundColor = false
        } else {
            naviBackgroundAlpha = 1
            isClearNaviBackgroundColor = false
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.xcCircleCell, for: indexPath)!

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 380
    }

}

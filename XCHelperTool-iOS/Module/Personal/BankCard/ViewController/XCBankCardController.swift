//
//  XCBankCardController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/29.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 银行卡列表
class XCBankCardController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        wrSetNaviBar(backgroundColor: UIColor.black, titleColor: UIColor.white, tintColor: UIColor.white)
        tableView.backgroundColor = UIColor.white
        tableView(forEmptyDataSet: tableView, isRequestSuccess: false)
        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func getData() {
//        tableView(forEmptyDataSet: tableView, isRequestSuccess: true)
    }
    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }


    @IBAction func addCardAction(_ sender: UIBarButtonItem) {
        let vc = R.storyboard.xcBankCard.xcBankCardAddController()!
        navigationController?.pushViewController(vc, animated: true)
    }
}

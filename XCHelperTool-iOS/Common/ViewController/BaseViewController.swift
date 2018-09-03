//
//  BaseViewController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/5/31.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// UIViewController基类
class BaseViewController: UIViewController {
    
    /// 空数据提示view
    private lazy var errorView: UIView = {
        let view = UIView(frame: CGRect(x: 20, y: self.view.center.y - 60, width: self.view.frame.width - 40, height: 120))
        view.backgroundColor = UIColor.clear
        self.view.addSubview(view)
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        titleLabel.attributedText = EmptyRequestType.error.title
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        view.addSubview(titleLabel)
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(getDataAgain(_:)), for: .touchUpInside)
        view.addSubview(button)
        return view
    }()
    
    /// 请求是否成功
    private var isRequestSuccess = true
    
    /// 子类调用(请求成功和失败都需要调用)
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - isRequestSuccess: 请求失败与否
    public func tableView(forEmptyDataSet tableView: UITableView!, isRequestSuccess: Bool) {
        self.isRequestSuccess = isRequestSuccess
        /// 判断tableView里是否存在cell(数据是否为空)
        let isEmpty = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) == nil
        if isEmpty {
            tableView.emptyDataSetDelegate = self
            tableView.emptyDataSetSource = self
        }
    }
    
    /// 网络错误(没有使用tabelView时调用)
    ///
    /// - Parameter isShow: 是否显示网络错误view
    public func isShowErrorView(_ isShow: Bool) {
        errorView.isHidden = !isShow
    }
    
    func getData() {
        fatalError("子类必须实现此方法")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func getDataAgain(_ sender: UIButton) {
        getData()
    }
}

extension BaseViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return isRequestSuccess ? EmptyRequestType.noData.image : EmptyRequestType.error.image
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return isRequestSuccess ? EmptyRequestType.noData.title : EmptyRequestType.error.title
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true // 是否可以滚动
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap view: UIView!) {
        if !isRequestSuccess { getData() }
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        if !isRequestSuccess { getData() }
    }
}

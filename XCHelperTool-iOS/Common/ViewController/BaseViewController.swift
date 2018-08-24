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
        titleLabel.attributedText = emptyTitle
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        view.addSubview(titleLabel)
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(getDataAgain(_:)), for: .touchUpInside)
        view.addSubview(button)
        return view
    }()
    
    /// 请求是否失败
    private var isRequestSuccess = true
    /// 空数据占位图片(tableView)
    private var emptyImage = UIImage()
    /// 空数据占位文字(tableView)
    private var emptyTitle = NSAttributedString()
    
    /// 子类调用(请求成功和失败都需要调用)
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - image: 占位图片
    ///   - title: 占位文字
    func tableView(forEmptyDataSet tableView: UITableView!,
                            isRequestSuccess: Bool = true,
                                       image: UIImage = UIColor.clear.colorToImage(),
                                       title: String = " ")
    {
        emptyImage = image
        emptyTitle = title.attributed(font: 16, color: UIColor.darkGray)
        self.isRequestSuccess = isRequestSuccess
        /// 判断tableView里是否存在cell(数据是否为空)
        let isEmpty = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) == nil
        if !isRequestSuccess && isEmpty {
            emptyImage = UIColor.clear.colorToImage()
            emptyTitle = PublicTool.attributedString(texts: ["加载失败\n\n", "点击重试"],
                                                     fonts: [UIFont.systemFont(ofSize: 23), UIFont.systemFont(ofSize: 14)],
                                                    colors: [UIColor.lightGray, UIColor(hex: 0x3B83F7)])
        }
        if isRequestSuccess && isEmpty {
            emptyImage = UIColor.clear.colorToImage()
            emptyTitle = PublicTool.attributedString(texts: ["暂无数据"],
                                                     fonts: [UIFont.systemFont(ofSize: 14)],
                                                    colors: [UIColor.lightGray])
        }
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self
    }
    
    /// 网络错误
    ///
    /// - Parameter isShow: 是否显示网络错误view
    func errorView(isShow: Bool = false) {
        if isShow {
            emptyTitle = PublicTool.attributedString(texts: ["加载失败\n\n", "点击重试"],
                                                     fonts: [UIFont.systemFont(ofSize: 23), UIFont.systemFont(ofSize: 14)],
                                                    colors: [UIColor.lightGray, UIColor(hex: 0x3B83F7)])
        }
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
        return emptyImage
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return emptyTitle
    }
    
    /// 设置是否可以滚动
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap view: UIView!) {
        if !isRequestSuccess { getData() }
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        if !isRequestSuccess { getData() }
    }
}

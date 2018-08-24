//
//  BaseTableViewController.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/11.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// UITableViewController基类
class BaseTableViewController: UITableViewController {
    
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
    
    func getData() {
        fatalError("子类必须实现此方法")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.groupTableViewBackground
    }
}

extension BaseTableViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
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

extension Array {
    subscript(input: [Int]) -> ArraySlice<Element> {
        get {
            var result = ArraySlice<Element>()
            for i in input {
                assert(i < self.count, "Index out of range")
                result.append(self[i])
            }
            return result
        } set {
            for (index, i) in input.enumerated() {
                assert(i < self.count, "Index out of range")
                self[i] = newValue[index]
            }
        }
    }
}

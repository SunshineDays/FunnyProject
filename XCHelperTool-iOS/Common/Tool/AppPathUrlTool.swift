//
//  AppPathUrlTool.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/14.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

class AppPathUrlTool: NSObject {
    
    class func pushToViewController(url: URL) {
        let path = urlPath(url: url)
        switch path {
        case .home:             push(InterfaceCtrl.homePageController())
        case .chatup:           push(InterfaceCtrl.chatupController())
        case .remind:           push(InterfaceCtrl.remindController())
        case .userInfo:         push(InterfaceCtrl.userInfoController())
        case .userIssue:        push(InterfaceCtrl.userIssueController())
        case .userFollow:       push(InterfaceCtrl.userFollowController())
        case .userFans:         push(InterfaceCtrl.userFansController())
        case .userVip:          push(InterfaceCtrl.userVipController())
        case .userBalance:      push(InterfaceCtrl.userBlanceController())
        case .userBill:         push(InterfaceCtrl.userBillController())
        case .userBankCard:     push(InterfaceCtrl.userBankCardController())
        case .topicDetail:      push(InterfaceCtrl.topicDetailController(id: parameter(url: url, key: "id")))
        default: break
        }
    }
    
    private class func push(_ controller: UIViewController) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            PublicTool.rootViewController().pushViewController(controller, animated: true)
        }
    }
    
    /// 通过url判断类型
    private class func urlPath(url: URL) -> AppPathURLType {
        var result = url.absoluteString
        result = result.replacingOccurrences(of: "sunshine://", with: "")
        let index = result.index(where: { $0 == "?" })
        if let index = index {
            result = result.substring(to: index.encodedOffset)
        }
        return AppPathURLType(rawValue: result) ?? .home
    }
    
    /// 根据URL中的 参数名 获取 参数内容
    class func parameter(url: URL, key: String) -> String {
        var result = url.absoluteString
        if !result.contains(key) {
            return ""
        } else {
            let range: NSRange = (result as NSString).range(of: key + "=")
            let lastIndex = range.location + range.length
            
            var ands = [Int]() // &的下标数组
            for (i, r) in result.enumerated() {
                if r == "&" {
                    ands.append(i)
                }
            }
            if ands.count == 0 {
                result = result.substring(from: lastIndex)
                return result
            } else {
                for a in ands {
                    if a - lastIndex > 0 {
                        result = result.substring(with: NSRange(location: lastIndex, length: a - lastIndex))
                        return result
                    }
                }
                if let _ = ands.index(where: { $0 > lastIndex }) {
                    return result
                } else {
                    result = result.substring(from: lastIndex)
                    return result
                }
            }
        }
    }
}




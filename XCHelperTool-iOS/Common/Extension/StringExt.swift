//
//  StringExt.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/5.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

extension String {
    /// 字符串截取
    func substring(to index: Int) -> String {
        return (self as NSString).substring(to: index)
    }
    
    /// 字符串截取
    func substring(from index: Int) -> String {
        return (self as NSString).substring(from: index)
    }
    
    /// 字符串截取
    func substring(with range: NSRange) -> String {
        return (self as NSString).substring(with: range)
    }
    
    /// 彩色字符串
    func attributed(font: CGFloat, color: UIColor) -> NSAttributedString {
        var attributes = [NSAttributedStringKey : Any]()
        attributes[.font] = UIFont.systemFont(ofSize: font)
        attributes[.foregroundColor] = color
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    /// 拨打电话
    func callToNum() {
        let tel = "tel:" + self
        if let url = URL(string: tel) {
            let callWebView = UIWebView()
            callWebView.loadRequest(URLRequest(url: url))
            UIApplication.shared.keyWindow?.addSubview(callWebView)
        }
    }
    
    /// 打开指定QQ的聊天界面
    func chatToQQ() {
        let qq = "mqq://im/chat?chat_type=wpa&uin=" + self + "&version=1&src_type=web"
        if let url = URL(string: qq) {
            if UIApplication.shared.canOpenURL(url) {
                let webView = UIWebView(frame: CGRect.zero)
                let request = URLRequest(url: url)
                webView.loadRequest(request)
                UIApplication.shared.keyWindow?.addSubview(webView)
            }
            else {
                MBProgressHUD.show(info: "您还没有安装QQ")
            }
        }
    }
}

extension String {
    /// string -> base64
    var base64Encode: String {
        let data = self.data(using: String.Encoding.utf8)
        let resultString = data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: UInt(0)))
        return resultString ?? ""
    }
    
    /// base64 -> string
    var base64Decode: String {
        let data = NSData(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0))
        let resultString = String(data:data! as Data, encoding:String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        return resultString ?? ""
    }

    /// 去掉字符串中的空格
    var full: String {
        return replacingOccurrences(of: " ", with: "")
    }
    
    /// 电话号码格式(输出类似 188 1234 1234 的电话号码)）
    var mobile: String {
        if isMobile() {
            return substring(to: 2) + " " + substring(with: NSRange(location: 3, length: 4)) + " " + substring(from: 7)
        } else {
            return self
        }
    }
    
    /// 电话号码格式(输出类似 188******88 的电话号码)）
    var mobileSecurity: String {
        if isMobile() {
            let result = full
            return result.substring(to: 2) + "******" + result.substring(from: count - 2)
        } else {
            return self
        }
    }    
    
    /// 银行卡号格式(输出类似 6666 6666 6666 6666 6666 的银行卡号)
    var bankCard: String {
        var result = ""
        for (index, string) in enumerated() {
            result = result + String(string)
            if index % 5 == 0 {
                result = result + " "
            }
        }
        return result
    }
    
    /// 银行卡号格式(输出类似 **** **** **** 6666 的银行卡号)
    var bankCardSecurity: String {
        let result = full
        return "**** **** **** " + result.substring(from: count - 4)
    }
    
    /// 身份证号码格式(输出类似 666666 1999 0802 0000 的身份证号码)
    var idCard: String {
        if isIDCard() {
            return substring(to: 5) + " " + substring(with: NSRange(location: 6, length: 4)) + " " + substring(with: NSRange(location: 10, length: 4)) + " "  + substring(from: 14)
        } else {
            return self
        }
    }

    /// 身份证号码格式(输出类似 6****************0 的身份证号码)
    var idCardSecurity: String {
        if isIDCard() {
            let result = full
            return result.substring(to: 1) + "****************" + result.substring(from: count - 1)
        } else {
            return self
        }
    }
}

extension String {
    /// 是否是手机号码
    func isMobile(_ showError: Bool = false) -> Bool {
        //手机号以13,15,17,18开头，八个 \d 数字字符
        let regex: String = "^((13[0-9])|(15[^4,\\D])|(17[0-9])|(18[0,0-9]))\\d{8}$"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        let isMobild = test.evaluate(with: full)
        if showError && !isMobild {
            MBProgressHUD.show(info: "请输入正确的手机号码")
        }
        return isMobild
    }
    
    /// 是否是固定电话
    func isTel(_ showError: Bool = false) -> Bool {
        //010,020,021,022,023,024,025,027,028,029,400
        let regex: String = "^((0(10|2[0-5789]|\\d{3}))|(400))\\d{7,8}$"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        let isTel = test.evaluate(with: full)
        if showError && !isTel {
            MBProgressHUD.show(info: "电话号码格式错误")
        }
        return isTel
    }
    
    /// 是否是邮箱
    func isEmail(_ showError: Bool = false) -> Bool {
        let regex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        let isEmail = test.evaluate(with: self)
        if showError && !isEmail {
            MBProgressHUD.show(info: "邮箱格式错误")
        }
        return isEmail
    }
    
    /// 是否是身份证号码
    func isIDCard(_ showError: Bool = false) -> Bool {
        let regex: String = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        let isIDCard = test.evaluate(with: full)
        if showError && !isIDCard {
            MBProgressHUD.show(info: "身份证号码格式错误")
        }
        return isIDCard
    }    
}

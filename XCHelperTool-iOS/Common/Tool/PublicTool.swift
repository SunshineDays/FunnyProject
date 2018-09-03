//
//  PublicTool.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/5/31.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

/// 工具类
class PublicTool: NSObject {
    /// 彩色字符串
    class func attributedString(texts: [String], fonts: [UIFont]? = nil, colors: [UIColor]) -> NSAttributedString {
        let result = NSMutableAttributedString()
        for (index, text) in texts.enumerated() {
            var attribute: [NSAttributedStringKey: Any] = [.foregroundColor: colors[index]]
            if let fonts = fonts {
                attribute[.font] = fonts[index]
            }
            let str = NSAttributedString(string: text, attributes: attribute)
            result.append(str)
        }
        return result
    }
    
    /// 相机或相册返回的图片
    class func imagePicker(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) -> UIImage? {
        if picker.allowsEditing {
            if let editedImage = info[UIImagePickerControllerEditedImage] {
                let image = editedImage as! UIImage
                return image
            }
        } else {
            if let originalImage = info[UIImagePickerControllerOriginalImage] {
                let image = originalImage as! UIImage
                return image
            }
        }
        return nil
    }
}

extension PublicTool {
    ///  获取rootViewController
    class func rootViewController() -> (AnyObject) {
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        if (rootViewController?.isKind(of: UINavigationController.self))! {
            rootViewController = (rootViewController as? UINavigationController)?.viewControllers.first
        }
        if (rootViewController?.isKind(of: UITabBarController.self))! {
            rootViewController = (rootViewController as? UITabBarController)?.selectedViewController
        }
        return rootViewController!
    }
    
    /// 返回到前面的控制器
    class func popToViewController(_ count: Int) {
        let navigationController: UINavigationController = rootViewController() as! UINavigationController
        let viewControllers = navigationController.viewControllers
        navigationController.popToViewController(viewControllers[viewControllers.count - 1 - count], animated: true)
    }
}

extension PublicTool {
    /// 设置html界面的颜色和字体大小
    ///
    /// - Parameters:
    ///   - html: HTML字符串
    ///   - color: 颜色（#666666）
    ///   - font: 字体大小
    /// - Returns: HTML字符串
    class func htmlString(html: String, color: String, font: Int) -> String {
        return String(format: "<span style=\"font-size:%dpx;color:%@\">%@</span>", font, color, html)
    }
    
    /// 设置html界面的格式
    ///
    /// - Parameters:
    ///   - html: HTML字符串
    /// - Returns: HTML字符串
    class func htmlString(html: String) -> String {
        return """
        <!doctype html>
        <html>
        <head>
        <meta charset='utf-8'/>
        <meta name='viewport' content='width=device-width, initial-scale=1.0, user-scalable=no'/>
        <meta name='format-detection' content='telephone=no' />
        <link href='web/label/labelContent.css' rel='stylesheet'/>
        </head>
        <body>
        <article id='content'>
        \(html)
        </article>
        </body>
        </html>
        """
    }
    
}

extension PublicTool {
    /// 字典转json字符串
    class func json(from dictionary: Any) -> String {
        let data = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        let jsonString = String(data: data ?? Data(), encoding: String.Encoding.utf8)
        return jsonString ?? ""
    }
    
    
}



//
//  UIWebViewExt.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/21.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

extension UIWebView {
    var jsWidth: CGFloat {
        let width: Float = Float(stringByEvaluatingJavaScript(from: "document.getElementById('content').offsetWidth") ?? "0.0") ?? 0.0
        return CGFloat(width)
    }
    
    var jsHeight: CGFloat {
        let height: Float = Float(stringByEvaluatingJavaScript(from: "document.getElementById('content').offsetHeight") ?? "0.0") ?? 0.0
        return CGFloat(height)
    }
}



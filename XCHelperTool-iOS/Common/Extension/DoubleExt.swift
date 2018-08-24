//
//  DoubleExt.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/6/28.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit

extension Double {
    /// 小数位数
    func decimal(_ num: Int) -> String {
        return String(format: "%.\(num)f", self)
    }
    
    /// 金额（每三位用，隔开）
    ///
    /// - Parameter num: 小数位数
    /// - Returns: String
    func moneyText(_ num: Int = 0) -> String {
        var result = ""
        let money = Int(self)
        let moneyStr = money.string.reversed()
        
        for (index, m) in moneyStr.enumerated() {
            result = result + String(m)
            if (index + 1) % 3 == 0 && index + 1 != moneyStr.count {
                result = result + ","
            }
        }
        result = String(result.reversed())
        
        if num > 0 {
            var decimal = (self - Double(money)).decimal(num)
            decimal.removeFirst()
            result = result + decimal
        }
        
        return result
    }
    
    /// 对应的像素值
    var pixel: CGFloat {
        return CGFloat(self) / UIScreen.main.scale
    }

}

extension Double {
    
    /// 时间戳转字符串
    ///
    /// - Parameters:
    ///   - format: 格式 (默认："MM-dd HH:mm:ss")
    ///   - isIntelligent: 是否智能转换(true: 显示昨天、今天、明天等格式, false:按照format格式转换)
    /// - Returns: 按格式转换后的字符串
    func timeString(with format: String = "MM-dd HH:mm", isIntelligent: Bool = false) -> String {
//        "yyyy-MM-dd HH:mm:ss"
        if self < 0 { return "" }
        
        var format = format
        
        if isIntelligent {
            let day: TimeInterval = 24 * 60 * 60

            let now = Foundation.Date().timeIntervalSince1970
            let nowDay = Int(now / day)
            
            let selfDay = Int(self / day)
            
            let nowFormatter = DateFormatter()
            nowFormatter.dateFormat = "yyyy"
            let nowYeaString = nowFormatter.string(from: Foundation.Date(timeIntervalSince1970: now))
            
            let selfFormatter = DateFormatter()
            selfFormatter.dateFormat = "yyyy"
            let selfYeaString = nowFormatter.string(from: Foundation.Date(timeIntervalSince1970: self))
            
            let sameYear = nowYeaString == selfYeaString

            if selfDay < nowDay {
                if nowDay - selfDay == 1 {
                    format = "昨天 HH:mm"
                } else if nowDay - selfDay == 2 {
                    format = "前天 HH:mm"
                } else if !sameYear {
                    format = "yyyy-MM-dd HH:mm"
                }
            } else if selfDay == nowDay {
                format = "今天 HH:mm"
            } else if selfDay > nowDay {
                if selfDay - nowDay == 1 {
                    format = "明天 HH:mm"
                } else if selfDay - nowDay == 2 {
                    format = "后天 HH:mm"
                } else if !sameYear {
                    format = "yyyy-MM-dd HH:mm"
                }
            }
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let result = formatter.string(from: Foundation.Date(timeIntervalSince1970: self))        
        return result
    }
    
    private func chineseCalendar(with format: String = "yyyy-MM-dd HH:mm:ss", date: String) -> String {
        let chineseYears = ["甲子", "乙丑", "丙寅", "丁卯", "戊辰", "己巳", "庚午", "辛未", "壬申", "癸酉",
                            "甲戌", "乙亥", "丙子", "丁丑", "戊寅", "己卯", "庚辰", "辛己", "壬午", "癸未",
                            "甲申", "乙酉", "丙戌", "丁亥", "戊子", "己丑", "庚寅", "辛卯", "壬辰", "癸巳",
                            "甲午", "乙未", "丙申", "丁酉", "戊戌", "己亥", "庚子", "辛丑", "壬寅", "癸丑",
                            "甲辰", "乙巳", "丙午", "丁未", "戊申", "己酉", "庚戌", "辛亥", "壬子", "癸丑",
                            "甲寅", "乙卯", "丙辰", "丁巳", "戊午", "己未", "庚申", "辛酉", "壬戌", "癸亥", nil]
        
        let chineseMonths = ["正月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "冬月", "腊月", nil]
        
        let chineseDays = ["初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十",
                           "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十",
                           "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十", nil]
        
        var dateTemp  = Date()
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        
        dateTemp = dateFormatter.date(from: date)!
        
        let localeCalerdar = NSCalendar(calendarIdentifier: .chinese)!
        
        let flags = UInt8(NSCalendar.Unit.year.rawValue) | UInt8(NSCalendar.Unit.month.rawValue) | UInt8(NSCalendar.Unit.day.rawValue)
        
        let localeComp: DateComponents = localeCalerdar.components(NSCalendar.Unit(rawValue: NSCalendar.Unit.RawValue(flags)), from: dateTemp)
        
        
        let year = chineseYears[localeComp.year! - 1] ?? ""
        let month = chineseMonths[localeComp.month! - 1] ?? ""
        let day = chineseDays[localeComp.month! - 1] ?? ""
        
        let formatter = DateFormatter()
        formatter.dateFormat = format.replacingOccurrences(of: "yyyy-MM-dd ", with: "")
        
        return year + month + day + formatter.string(from: Foundation.Date(timeIntervalSince1970: self))
    }
    
    
}

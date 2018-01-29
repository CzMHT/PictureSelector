//
//  Common.swift
//  Swift01
//
//  Created by YuanGu on 2017/11/1.
//  Copyright © 2017年 YuanGu. All rights reserved.
//

import UIKit

let Screen_Height = UIScreen.main.bounds.size.height
let Screen_Width  = UIScreen.main.bounds.size.width

// 判断 iPhone5
let iPhone5 = UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 960, height: 1336).equalTo((UIScreen.main.currentMode?.size)!) : false
// 判断 iPhone6
let iPhone6 = UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 750, height: 1334).equalTo((UIScreen.main.currentMode?.size)!) : false
// 判断 iPhone6p
let iPhone6p = UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1242, height: 2208).equalTo((UIScreen.main.currentMode?.size)!) : false
// 判断 iPhone6p 大屏幕
let iPhone6pBigMode = UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1125, height: 2001).equalTo((UIScreen.main.currentMode?.size)!) : false
// 判断iPhoneX
let iPhoneX = UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? CGSize(width: 1125, height: 2436).equalTo((UIScreen.main.currentMode?.size)!) : false
//适配参数
let suitParm:CGFloat = (iPhone6p ? 1.12 : (iPhone6 ? 1.0 : (iPhone6pBigMode ? 1.01 : (iPhoneX ? 1.0 : 0.85))))

// 状态栏高度
let STATUS_BAR_HEIGHT = (iPhoneX ? 44.0 : 20.0)
// 导航栏高度
let NAVIGATION_BAR_HEIGHT = (iPhoneX ? 88.0 : 64.0)
// tabBar高度
let TAB_BAR_HEIGHT = (iPhoneX ? (49.0+34.0) : 49.0)
// home indicator
let HOME_INDICATOR_HEIGHT = (iPhoneX ? 34.0 : 0.0)

// MARK:- 自定义打印
func Log<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        
        let timeFormatter = DateFormatter()
        
        timeFormatter.dateFormat = "HH:mm:ss.SSS"
        
        let strNowTime = timeFormatter.string(from: NSDate() as Date) as String
        
        let fileName = (file as NSString).lastPathComponent
        
        print("\(strNowTime)-\(fileName)-(\(lineNum)) : \(message)")
        
    #endif
}

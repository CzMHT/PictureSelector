//
//  UIImage+Extension.swift
//  PictureSelector
//
//  Created by YuanGu on 2018/1/29.
//  Copyright © 2018年 YuanGu. All rights reserved.
//

import UIKit

extension UIImage {
    
    /**
     * 根据传入的宽度生成一张图片
     * 按照图片的宽高比来压缩以前的图片
     * :param: width 制定宽度
     */
    
    func imageWithScale(width: CGFloat) -> UIImage {
        
        //得到缩放的height
        let height = width/size.width*size.height
        //重新制定size
        let currentSize = CGSize.init(width: width, height: height)
        //开始绘制
        UIGraphicsBeginImageContext(currentSize)
        
        draw(in: CGRect.init(origin: CGPoint.zero, size: currentSize))
        //得到新的图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //结束绘制
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

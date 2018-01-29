//
//  PictureSelectorFlowLayout.swift
//  PictureSelector
//
//  Created by YuanGu on 2018/1/29.
//  Copyright © 2018年 YuanGu. All rights reserved.
//

import UIKit

class PictureSelectorFlowLayout: UICollectionViewFlowLayout {

    override func prepare() {
        super.prepare()
        
        itemSize = CGSize(width: (Screen_Width-41)/3.0, height: 100)
        // 行之间的间距c
        minimumLineSpacing = 10
        // 列之间的间距
        minimumInteritemSpacing = 10
        
        sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

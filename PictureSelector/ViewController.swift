//
//  ViewController.swift
//  PictureSelector
//
//  Created by YuanGu on 2018/1/29.
//  Copyright © 2018年 YuanGu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PictureSelector"
        view.backgroundColor = UIColor.white
        addChildViewController(PictureSelectorVC)
        view.addSubview(PictureSelectorVC.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: 添加图片选择器
    private lazy var PictureSelectorVC: PictureSelectorController = {
        
        let vc = PictureSelectorController()
        
        vc.view.frame = view.bounds
        
        return vc
    }()
}


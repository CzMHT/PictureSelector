//
//  PictureSelectorController.swift
//  PictureSelector
//
//  Created by YuanGu on 2018/1/29.
//  Copyright © 2018年 YuanGu. All rights reserved.
//

import UIKit

private let PictureSelectorReuseIdentifier = "PictureSelectorReuseIdentifier"

class PictureSelectorController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        setUpUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpUI() {
        // 1.添加子控件
        view.addSubview(collectionView)
        
        // 2.布局子控件
        /**
         translatesAutoresizingMaskIntoConstraints属性和autolayout有关
         如果你定义的view想用autolayout，就将translatesAutoresizingMaskIntoConstraints设为false，如果你使用的不是autolayout，就将translatesAutoresizingMaskIntoConstraints设为true
         */
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        var cons = [NSLayoutConstraint]()
        cons += NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[collectionView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["collectionView":collectionView])
        cons += NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(NAVIGATION_BAR_HEIGHT)-[collectionView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["collectionView":collectionView])
        view.addConstraints(cons)
    }

    // MARK: lazy
    lazy var collectionView: UICollectionView = {
        let collectionview = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: PictureSelectorFlowLayout())
        collectionview.register(PictureSelectorCell.self, forCellWithReuseIdentifier: PictureSelectorReuseIdentifier)
        collectionview.delegate = self
        collectionview.dataSource = self
        return collectionview
    }()

    //存放图片
    private lazy var images = [UIImage]()
}

extension PictureSelectorController: PictureSelectorCellDelegate {
    //新增
    func photoDidAddSelector(cell: PictureSelectorCell) {
        
        /*
         case photoLibrary 照片库(所有的照片，拍照&用 iTunes & iPhoto `同步`的照片 - 不能删除)
         case camera  相机
         case savedPhotosAlbum 相册 (自己拍照保存的, 可以随便删除)
         */
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            print("不能打开相册")
            return
        }
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        print("添加照片")
    }
    //删除
    func photoDidDeleteSelector(cell: PictureSelectorCell) {
        print("删除照片")
        
        let indexPath = collectionView.indexPath(for: cell)
        images.remove(at: (indexPath?.row)!)
        collectionView.reloadData()
    }
}

extension PictureSelectorController: UIImagePickerControllerDelegate ,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("info=\(info)")
        /*
         注意: 一般情况下,只要涉及到从相册中获取图片的功能, 都需要处理内存
         一般情况下一个应用程序启动会占用20M左右的内存, 当内存飙升到500M左右的时候系统就会发送内存警告, 此时就需要释放内存 , 否则就会闪退
         只要内存释放到100M左右, 那么系统就不会闪退我们的应用程序
         也就是说一个应用程序占用的内存20~100时是比较安全的内容范围
         */
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        /*
         注意: 1.如果是通过JPEG来压缩图片, 图片压缩之后是不保真的
         2.苹果官方不推荐我们使用JPG图片,因为现实JPG图片的时候解压缩非常消耗性能
         两种压缩方式
          let data1 = UIImageJPEGRepresentation(image, 1.0)
          data1?.writeToFile("/Users/xiaomage/Desktop/1.jpg", atomically: true)
          let data2 = UIImageJPEGRepresentation(image, 0.1)
          data2?.writeToFile("/Users/xiaomage/Desktop/2.jpg", atomically: true)
         */
        let newImage = image.imageWithScale(width: Screen_Width-20)
        
        images.append(newImage)
        
        collectionView.reloadData()
        // 注意: 如果实现了该方法, 需要我们自己关闭图片选择器
        dismiss(animated: true, completion: nil)
    }
}

extension PictureSelectorController: UICollectionViewDataSource ,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureSelectorReuseIdentifier, for: indexPath) as! PictureSelectorCell
        
        cell.delegate = self
        cell.image = (images.count == indexPath.item) ? nil : images[indexPath.item]
        
        return cell
    }
}

//
//  PictureSelectorCell.swift
//  PictureSelector
//
//  Created by YuanGu on 2018/1/29.
//  Copyright © 2018年 YuanGu. All rights reserved.
//

import UIKit

@objc
protocol PictureSelectorCellDelegate: NSObjectProtocol {
    
    @objc optional func photoDidAddSelector(cell: PictureSelectorCell)
    @objc optional func photoDidDeleteSelector(cell: PictureSelectorCell)
}

class PictureSelectorCell: UICollectionViewCell {
    
    weak var delegate: PictureSelectorCellDelegate?
    
    var image: UIImage?
    {
        didSet{
            if image != nil{
                
                deleteButton.isHidden = false
                addButton.setImage(image!, for: UIControlState.normal)
                addButton.isUserInteractionEnabled = false
            }else{
                
                deleteButton.isHidden = true
                addButton.isUserInteractionEnabled = true
                addButton.setImage(UIImage(named: "compose_pic_add"), for: UIControlState.normal)
            }
        }
    }
    
    // MARK: lazy
    private lazy var addButton: UIButton = {
       
        let button = UIButton()
        button.addTarget(self, action: #selector(addAction), for: UIControlEvents.touchUpInside)
        button.imageView?.contentMode = UIViewContentMode.scaleAspectFill
        button.setImage(UIImage(named:"compose_pic_add"), for: UIControlState.normal)
        button.setImage(UIImage(named:"compose_pic_add_highlighted"), for: UIControlState.highlighted)
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        
        let button = UIButton()
        button.isHidden = true
        button.addTarget(self, action: #selector(deleteAction), for: UIControlEvents.touchUpInside)
        button.setImage(UIImage(named:"compose_photo_close"), for: UIControlState.normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    func setUI() {
        
        contentView.backgroundColor = UIColor.purple
        contentView.addSubview(addButton)
        contentView.addSubview(deleteButton)
        
        //布局
        addButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        var cons = [NSLayoutConstraint]()
        
        cons += NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[addButton]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["addButton" : addButton])
        cons += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[addButton]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["addButton" : addButton])
        
        cons += NSLayoutConstraint.constraints(withVisualFormat: "H:[deleteButton]-2-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["deleteButton" : deleteButton])
        cons += NSLayoutConstraint.constraints(withVisualFormat: "V:|-2-[deleteButton]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["deleteButton" : deleteButton])
        contentView.addConstraints(cons)
    }
    
    // Mark: Action
    @objc func addAction() {
        delegate?.photoDidAddSelector!(cell: self)
    }
    @objc func deleteAction() {
        delegate?.photoDidDeleteSelector!(cell: self)
    }
}

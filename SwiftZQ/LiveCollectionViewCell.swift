//
//  LiveCollectionViewCell.swift
//  Tableview
//
//  Created by XGJ on 16/7/5.
//  Copyright © 2016年 XGJ. All rights reserved.
//

import UIKit
import Kingfisher
class LiveCollectionViewCell: UICollectionViewCell {
    internal var Img         = UIImageView()
    internal var nameLabel   = UILabel()
    internal var titleLabel  = UILabel()
    internal var numberLabel = UILabel()
    internal var sexImg      = UIImageView()
    var model:ListClassModel = ListClassModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        Img = self.initImageVC(UIColor.whiteColor())
        Img.image = UIImage.init(named: "11")
        Img.contentMode = .ScaleAspectFit
        nameLabel = self.initLabel(UIFont.systemFontOfSize(14), titlecolor: UIColor.clearColor())
        nameLabel.backgroundColor = UIColor.whiteColor();
        nameLabel.textColor = UIColor.redColor()
        titleLabel = self.initLabel(UIFont.systemFontOfSize(14), titlecolor: UIColor.clearColor())
        titleLabel.backgroundColor = UIColor.whiteColor();
        numberLabel = self.initLabel(UIFont.systemFontOfSize(8), titlecolor: UIColor.clearColor())

        sexImg = self.initImageVC(UIColor.whiteColor())
        sexImg.image = UIImage.init(named: "tabbar_me")
        
        
        self.contentView.addSubview(Img)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(sexImg)
        self.contentView.addSubview(numberLabel)
        self.contentView.addSubview(titleLabel)

//        Img.addSubview(titleLabel)


    }
    override func layoutSubviews() {
        super.layoutSubviews();
        Img.snp_makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(UIEdgeInsetsMake(5, 5, -45, -5));
        }
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(0);
            make.right.equalTo(0);
            make.bottom.equalTo(-23);
            make.height.equalTo(20);
        }
        sexImg.snp_makeConstraints { (make) in
            make.left.equalTo(0);
            make.bottom.equalTo(-2);
            make.size.equalTo(CGSizeMake(20, 20))
        }
//        print(titleLabel.text)
        nameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(sexImg.snp_right).offset(5);
            make.bottom.equalTo(-2);
//            make.size.equalTo(CGSizeMake(20, 20))
            make.right.equalTo(-25)
            make.height.equalTo(20)
        }
        
    }
    func initLabel(font:UIFont,titlecolor:UIColor) -> UILabel {
        let label = UILabel.init()
        label.font = font
        label.tintColor = titlecolor
        return label
    }
    func initImageVC(imgbc:UIColor) -> UIImageView {
        let imgVC = UIImageView.init()
        imgVC.backgroundColor = imgbc
        return imgVC
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setdataS(dic:ListClassModel) {
        model = dic;
        nameLabel.text = model.online
        titleLabel.text = model.title
        /**
         *  初始化URL并且获取图片地址
         */
        let  url : NSURL = NSURL(string:model.spic)!
        /**
         *  初始化data。从URL中获取数据
         */
    
//        let data : NSData = NSData(contentsOfURL:url)!
//        /**
//         *  创建图片
//         */
//        let image = UIImage(data:data, scale: 1.0)
//        print(image?.size.height);
//        Img.image = image
//        类似sdwebimageview
        Img.kf_setImageWithURL(url, placeholderImage: nil, optionsInfo: nil, progressBlock: { (receivedSize, totalSize) in
            
            }) { (image, error, cacheType, imageURL) in
                self.Img.image = image
                
        }
        
    
    }

}

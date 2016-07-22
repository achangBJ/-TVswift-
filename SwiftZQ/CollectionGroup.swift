//
//  CollectionGroup.swift
//  Tableview
//
//  Created by XGJ on 16/7/20.
//  Copyright © 2016年 XGJ. All rights reserved.
//

import UIKit

class CollectionGroup: UICollectionReusableView {
    internal var nameLabel   = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame);

        nameLabel = self.initLabel(UIFont.systemFontOfSize(24), titlecolor: UIColor.redColor())
        nameLabel.frame = CGRectMake(10, 5, frame.size.width-20, frame.size.height-10)
        nameLabel.backgroundColor = UIColor.clearColor();
        self.addSubview(nameLabel)

        
        
    }

    
    func setTItle(title:String) {
        nameLabel.text = ":"+title
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initLabel(font:UIFont,titlecolor:UIColor) -> UILabel {
        let label = UILabel.init()
        label.font = font
        label.tintColor = titlecolor
        label.textColor = titlecolor
        return label
    }
}

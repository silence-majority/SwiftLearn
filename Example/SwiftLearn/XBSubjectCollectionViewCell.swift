//
//  XBSubjectCollectionViewCell.swift
//  SwiftLearn_Example
//
//  Created by xy_yanfa_imac on 2017/11/3.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
class XBSubjectCollectionViewCell: UICollectionViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var imageView = UIImageView()
    private var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = .white
        
        self.contentView.addSubview(imageView)
        imageView.image = UIImage(named: "语文-1 copy")
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self.snp.centerY).offset(5)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        self.contentView.addSubview(titleLabel)
        titleLabel.text = "音乐"
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.textColor = .gray
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(imageView.snp.bottom).offset(10)
        }
    }
    
    func setCell(name:String){
        titleLabel.text = name
        imageView.image = UIImage(named: "\(name)-1 copy")
    }
    
}

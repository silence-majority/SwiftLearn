//
//  SegmentSliderView.swift
//  SwiftLearn_Example
//
//  Created by xy_yanfa_imac on 2017/10/30.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import Masonry
import SnapKit
enum sliderLengthType{
    case equalToTitle(height:CGFloat)
    case constantValue(height:CGFloat,width:CGFloat)
}

enum SegmentSliderViewFoldStyle{
    case fold
    case unFold
}

enum SegmentSliderViewType{
    //Segment较少，可以全部展示出来
    case simple
    //Segment较多，不可以全部展示出来，只能通过scrollView来放置。unfoldEnable用来标识是否可以展开。
    case complex(unfoldEnable:Bool)
}

class SegmentSliderView: UIView {
    var titleArray = [String]()
    var segmentSliderViewType = SegmentSliderViewType.simple
    var foldStyle = SegmentSliderViewFoldStyle.fold
    var horizontalMargin : CGFloat = 12
    var font : UIFont?
    var normalTitleColor : UIColor?
    var selectedTitleColor : UIColor?
    
    var scrollView : UIScrollView!
    var titleBtnArray = [UIButton]()
    var slider = UIView()
    
    let baseTag = 100
    var maxTextLength : CGFloat = 0
    
    init(frame:CGRect, titleArray:[String], segmentSliderViewType:SegmentSliderViewType){
        super.init(frame: frame)
        self.titleArray = titleArray
        self.segmentSliderViewType = segmentSliderViewType
        maxTextLength = self.getSegmentMaxLength(titleArr: titleArray)
        
        scrollView = UIScrollView()
        self.addSubview(scrollView)
        
        for index in 0...titleArray.count-1{
            let btn = UIButton()
            self.addSubview(btn)
            btn.tag = baseTag + index
            btn.setTitle(titleArray[index], for: .normal)
        }
    
    }
    
    override func layoutSubviews() {
        
        scrollView.frame = self.bounds
        scrollView.contentSize = self.getScrollViewContentSize()
        scrollView.backgroundColor = .purple
        
        
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func getScrollViewContentSize()->CGSize{
        var size : CGSize!
        switch segmentSliderViewType {
        case .simple:
            size = CGSize(width: self.frame.width, height: self.frame.width)
        case .complex(let unfoldEnable):
            print(unfoldEnable)
            size = CGSize(width: self.frame.width, height: self.frame.width)
        }
        return size
    }
    
    private func getSegmentSpace()->CGFloat{
        var space : CGFloat!
        let maxLengthOfSegment = self.getSegmentMaxLength(titleArr: titleArray)
        switch segmentSliderViewType {
        case .simple:
            space = (self.frame.width-horizontalMargin*2-maxLengthOfSegment*(CGFloat)(titleArray.count))/(CGFloat)(titleArray.count-1)
        case .complex(let unfoldEnable):
            print(unfoldEnable)
            space = 10
        }
        return space
    }
    
    private func getSegmentMaxLength(titleArr:[String]) -> CGFloat{
        var max = 0
        var text = ""
        for str in titleArray{
            if str.characters.count > max{
                max = str.characters.count
                text = str
            }
        }
        return self.getStrLength(str: text, font: UIFont.systemFont(ofSize: 14))
    }
    
    private func getStrLength(str:String,font:UIFont)->CGFloat{
        let size = str.boundingRect(with: CGSize(width: 1000, height: 100), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : font], context: nil)
        return size.width
    }
}

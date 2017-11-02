//
//  XBSegmentControl.swift
//  SwiftLearn_Example
//
//  Created by xy_yanfa_imac on 2017/11/1.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

protocol XBSegmentControlDeletate{
     func xbSegmentControl(_ xbSegmentControl : XBSegmentControl,didSelectIndex index : Int )
}

enum XBSegmentControlSliderSizeStyle{
    case constant(size:CGSize)
    case fitTitle
}

enum XBSegmentControlSliderUpdateSourece{
    case touchButton(buttonIndex:Int)
    case slideScrollView
}

enum XBSegmentControlSegmentStyle{
    case focus
    case normal
}

class XBSegmentControl: UIView {
    
    var delegete : XBSegmentControlDeletate!
    
    var titleArray = [String]()
    var titleFont : UIFont = UIFont.systemFont(ofSize: 14)
    var titleNormalColor : UIColor = .black
    var titleFocusColor : UIColor = .red
    
    var horizontalMargin : CGFloat = 16
    private var titleMaxWidth : CGFloat = 0
    private var segmentInterSpace : CGFloat = 0
    
    let baseTag : Int = 100
    private var focusIndex : Int = 0
    
    private var sliderView = UIView()
    private var silderViewSizeStyle : XBSegmentControlSliderSizeStyle = .constant(size: CGSize(width: 15, height: 3))
    
    init(frame: CGRect,titles:[String]) {
        super.init(frame: frame)
        titleArray = titles
        self.backgroundColor = .white
        for index in 0...titleArray.count-1{
            let segmentBtn = UIButton()
            segmentBtn.tag = baseTag + index
            segmentBtn.setTitle(titleArray[index], for: .normal)
            segmentBtn.addTarget(self, action: #selector(segmentBtnAction(sender:)), for: .touchUpInside)
            self.addSubview(segmentBtn)
        }
        self.addSubview(sliderView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleMaxWidth = self.getSegmentMaxWidth(titleArr: titleArray,font: titleFont)
        segmentInterSpace = self.getSegmentInterSpace()
        
        for index in 0...titleArray.count-1{
            let segmentBtn = viewWithTag(baseTag+index) as! UIButton
            segmentBtn.snp.makeConstraints({ (make) in
                make.left.equalTo(horizontalMargin + (titleMaxWidth+segmentInterSpace)*(CGFloat)(index))
                make.centerY.equalTo(self)
                make.size.equalTo(CGSize(width: titleMaxWidth, height: 30))
            })
            segmentBtn.titleLabel?.font = titleFont
            if focusIndex != index{
                segmentBtn.setTitleColor(titleNormalColor, for: .normal)
            }else{
                segmentBtn.setTitleColor(titleFocusColor, for: .normal)
                switch silderViewSizeStyle{
                case .constant(let size):
                    sliderView.backgroundColor = titleFocusColor
                    sliderView.layer.cornerRadius = size.height/2
                    sliderView.snp.removeConstraints()
                    sliderView.snp.makeConstraints({ (make) in
                        make.size.equalTo(size)
                        make.bottom.equalTo(-5)
                        make.centerX.equalTo(segmentBtn.snp.centerX)
                    })
                default:
                    fatalError("自适应还没有实现")
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //获取最长label的宽度 作为所有button的宽度
    private func getSegmentMaxWidth(titleArr:[String], font:UIFont) -> CGFloat{
        var maxWidth : CGFloat = 0
        for text in titleArray{
            let width = self.getStrLength(str: text, font: font)
            if width > maxWidth{
                maxWidth = width
            }
        }
        return maxWidth+10
    }
    
    //根据字符串获取label的宽度
    private func getStrLength(str:String,font:UIFont)->CGFloat{
        let size = str.boundingRect(with: CGSize(width: 1000, height: 100), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : font], context: nil)
        return size.width
    }
    
    //获取segment间的间距
    private func getSegmentInterSpace() -> CGFloat{
        return (self.frame.width - horizontalMargin*2 - titleMaxWidth*(CGFloat)(titleArray.count))/(CGFloat)(titleArray.count-1)
    }
    
    @objc private func segmentBtnAction(sender:Any){
        let segmentBtn = sender as! UIButton
        if((segmentBtn.tag-baseTag) != focusIndex){
            focusIndex = segmentBtn.tag-baseTag
            delegete.xbSegmentControl(self, didSelectIndex: focusIndex)
//            self.setNeedsLayout()
        }
    }
    
    func updateSlider(percent:CGFloat, source:XBSegmentControlSliderUpdateSourece){
        //设置滑块的位置
        var center : CGPoint = sliderView.center
        center.x = horizontalMargin + titleMaxWidth/2 + percent*(titleMaxWidth+segmentInterSpace)
        sliderView.center = center
        
        //配置title的颜色
        let offset = percent - CGFloat(focusIndex)
        if fabs(offset) > 0.5{
            self.setSegmentStyle(index: focusIndex, focusStyle: .normal)
            if offset > 0{
                focusIndex += 1
            }else{
                focusIndex -= 1
            }
            
            switch source{
            case .touchButton(let buttonIndex):
                if buttonIndex == focusIndex{
                    self.setSegmentStyle(index: focusIndex, focusStyle: .focus)
                }
            case .slideScrollView:
                self.setSegmentStyle(index: focusIndex, focusStyle: .focus)
            }
        }
    }
    
    private func setSegmentStyle(index:Int, focusStyle:XBSegmentControlSegmentStyle){
        let segmentBtn = viewWithTag(baseTag+index) as! UIButton
        switch focusStyle {
        case .focus:
            segmentBtn.setTitleColor(titleFocusColor, for: .normal)
        case .normal:
            segmentBtn.setTitleColor(titleNormalColor, for: .normal)
        }
    }
    
}

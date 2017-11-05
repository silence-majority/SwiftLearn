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
    func xbSegmentControl(_ xbSegmentControl : XBSegmentControl,didSelectIndex index : Int, source:XBSegmentControlSelecteSegmentSource)
    func xbSegmentControl(_ xbSegmentControl : XBSegmentControl,didPressUnfoldBtnWithBtnStyle foldStyle : XBSegmentControlFoldStyle)
}

enum XBSegmentControlSelecteSegmentSource{
    case touchSegmentButton
    case touchUnfoldCollectionViewCell
}

enum XBSegmentControlStyle{
    case simple
    case complex(segmentInterSpace:CGFloat, foldUnable:Bool)
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

enum XBSegmentControlFoldStyle{
    case fold //折叠
    case unfold //展开
}

class XBSegmentControl: UIView {
    
    var delegete : XBSegmentControlDeletate!
    
    var segmentControlStyle = XBSegmentControlStyle.simple
    
    var foldBtn : UIButton?
    var indicateLabel : UILabel?
    var foldStyle : XBSegmentControlFoldStyle = .fold{
        willSet(newTotal){
            print("foldStyle将要改变: \(newTotal)")
        }
        didSet{
            switch foldStyle{
            case .fold:
                foldBtn?.setImage(UIImage(named:"键盘"), for: .normal)
                self.insertSubview(scrollView, belowSubview: foldBtn!)
                indicateLabel?.removeFromSuperview()
                indicateLabel = nil
            case .unfold:
                foldBtn?.setImage(UIImage(named:"添加"), for: .normal)
                scrollView.removeFromSuperview()
                indicateLabel = UILabel()
                indicateLabel?.text = "请选择"
                indicateLabel?.font = UIFont.systemFont(ofSize: 12)
                indicateLabel?.textColor = .gray
                self.addSubview(indicateLabel!)
                indicateLabel?.snp.makeConstraints({ (make) in
                    make.left.equalTo(16)
                    make.centerY.equalTo(self)
                })
            }
        }
    }
    
    var scrollView = UIScrollView()
    
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect,titles:[String],style:XBSegmentControlStyle) {
        super.init(frame: frame)
        titleArray = titles
        segmentControlStyle = style                                                                                                                                                        
        self.backgroundColor = .white
        
        scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsHorizontalScrollIndicator = false
        self.addSubview(scrollView)
        for index in 0...titleArray.count-1{
            let segmentBtn = UIButton()
            segmentBtn.tag = baseTag + index
            segmentBtn.setTitle(titleArray[index], for: .normal)
            segmentBtn.addTarget(self, action: #selector(segmentBtnAction(sender:)), for: .touchUpInside)
            scrollView.addSubview(segmentBtn)
        }
        scrollView.addSubview(sliderView)
        
        switch segmentControlStyle {
        case .simple:break
        case.complex(_,let foldUnable):
            if(foldUnable){
                foldBtn = UIButton()
                self.addSubview(foldBtn!)
                foldBtn?.backgroundColor = .white
                foldBtn!.setImage(UIImage(named: "键盘"), for: .normal)
                foldBtn?.addTarget(self, action: #selector(foldBtnAction), for: .touchUpInside)
                
                foldBtn?.snp.makeConstraints({ (make) in
                    make.size.equalTo(CGSize(width:44,height:44))
                    make.centerY.equalTo(self)
                    make.right.equalTo(self)
                })
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleMaxWidth = self.getSegmentMaxWidth(titleArr: titleArray,font: titleFont)
        segmentInterSpace = self.getSegmentInterSpace()
        
        switch segmentControlStyle {
        case .simple:
            self.layoutSegmentsAndSlider()
        case .complex(_, let foldUnable):
            if(!(foldUnable && foldStyle == .unfold)){
                self.layoutSegmentsAndSlider()
            }
        }
        
    }
    
    private func layoutSegmentsAndSlider(){
        scrollView.contentSize = self.getScrollViewContentSize()
        
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
                    sliderView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
                    sliderView.center = CGPoint(x: horizontalMargin+titleMaxWidth/2+(titleMaxWidth+segmentInterSpace)*CGFloat(focusIndex), y: self.frame.height-5-size.height)
                    
                    sliderView.backgroundColor = titleFocusColor
                    sliderView.layer.cornerRadius = size.height/2
                default:
                    fatalError("自适应还没有实现")
                }
            }
        }

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
        switch  segmentControlStyle{
        case .simple:
             return (self.frame.width - horizontalMargin*2 - titleMaxWidth*(CGFloat)(titleArray.count))/(CGFloat)(titleArray.count-1)
        case .complex(let segmentInterSpace, _):
            return segmentInterSpace
        }
    }
    
    //获取scrollview的ContentSize
    private func getScrollViewContentSize() -> CGSize{
        switch  segmentControlStyle{
        case .simple:
            return self.frame.size
        case .complex(let segmentInterSpace, let foldUnable):
            let width = horizontalMargin*2 + titleMaxWidth*CGFloat(titleArray.count) + segmentInterSpace*CGFloat(titleArray.count-1)
            if foldUnable{
                 return CGSize(width: width+50, height: self.frame.height)
            }else{
                 return CGSize(width: width, height: self.frame.height)
            }
        }
    }
    
    //点击segment的事件
    @objc private func segmentBtnAction(sender:Any){
        let segmentBtn = sender as! UIButton
        if((segmentBtn.tag-baseTag) != focusIndex){
            self.logicSelectSegment(index: segmentBtn.tag-baseTag, source: .touchSegmentButton)
        }
    }
    
    func logicSelectSegment(index:Int,source:XBSegmentControlSelecteSegmentSource){
        delegete.xbSegmentControl(self, didSelectIndex: index,source:source)
        self.updateSegmentAppearance(nextFocusIndex: index)
    }
    
    //点击展开按钮的事件
    @objc private func foldBtnAction(){
        //展开这有一个入口 ： 点击按钮，foldStyle立即改变，从而界面立即改变
        //折叠有两个入口：1，点击按钮 2，点击背景。 这两个入口统一调popView的dismiss方法，dismiss里通过闭包设置foldStyle，从而使界面改变
        switch foldStyle {
        case .fold:
            foldStyle = .unfold
            delegete.xbSegmentControl(self, didPressUnfoldBtnWithBtnStyle: foldStyle)
            break
        case .unfold:
//            foldStyle = .fold  // 展开的情况下，这句代码会使界面立即改变（属性观察器）。页面要求是展开的view完全收回后在更换按钮的图片，所以这句代码在代理里实现
            delegete.xbSegmentControl(self, didPressUnfoldBtnWithBtnStyle: .fold)
            break
        }
    }
    
    //根据scrollview的contentoffset.x/screenW，来不停更新滑块的位置
    func updateSlider(percent:CGFloat, source:XBSegmentControlSliderUpdateSourece){
        //设置滑块的位置
        var center : CGPoint = sliderView.center
        center.x = horizontalMargin + titleMaxWidth/2 + percent*(titleMaxWidth+segmentInterSpace)
        sliderView.center = center
        
        //设置title颜色
        switch source {
        case .touchButton( _): break //点击按钮的源已经在segmentBtnAction里处理
        case .slideScrollView:
            let offset = percent - CGFloat(focusIndex)
            if fabs(offset) > 0.5{//scrollview滑动时，本方法会不停的执行，但这个条件会保证下面的代码只执行一次
                var nextFocusIndex = 0
                if offset > 0{
                    nextFocusIndex = focusIndex + 1
                }else{
                    nextFocusIndex = focusIndex - 1
                }
                self.updateSegmentAppearance(nextFocusIndex: nextFocusIndex)
            }
        }
    }
    
    func updateSegmentAppearance(nextFocusIndex:Int){
        self.setSegmentStyle(index: focusIndex, focusStyle: .normal)
        self.setSegmentStyle(index: nextFocusIndex, focusStyle: .focus)
        self.updateScrollViewContentOffset(index: nextFocusIndex)
        focusIndex = nextFocusIndex
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
    
    private func updateScrollViewContentOffset(index:Int){
        let segmentBtn = viewWithTag(index+baseTag) as! UIButton
        let leftCondition = segmentBtn.center.x  > self.frame.width/2
        let rightCondition = scrollView.contentSize.width-segmentBtn.center.x > self.frame.width/2
        
        if(leftCondition && !rightCondition){
            let contentOffsetX = scrollView.contentSize.width - self.frame.width
            if(scrollView.contentOffset.x != contentOffsetX){
                scrollView.setContentOffset(CGPoint(x:contentOffsetX,y:0), animated: true)
            }
        }else if(!leftCondition && rightCondition){
            if(scrollView.contentOffset.x != 0){
                scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
            }
        }else{
            scrollView.setContentOffset(CGPoint(x:(segmentBtn.center.x - self.frame.width/2),y:0), animated: true)
        }
    }
}

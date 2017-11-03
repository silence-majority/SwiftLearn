//
//  BasePopView.swift
//  SwiftLearn_Example
//
//  Created by xy_yanfa_imac on 2017/10/30.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
/*
 * animationId = 0  开始动画
 * animationId = 1  diamiss动画
 */
typealias BasePopViewAnimationClosure = (_ animationId:Int)->Void

/*
 * eventID = 0  点击遮罩
 * 其他由子类定义
 */
typealias BasePodViewEventClosure = (_ eventID : Int)->Void

class BasePopView: UIView {
    
    //点击背景隐藏
    var isDismissByTouchBackgrond : Bool!
    //半透明的遮罩（curtain 窗帘遮罩）
    var curtainView : UIView!
    //透明度
    var backgroundAlpha : CGFloat!
    //动画持续时间
    var animationDuration : CGFloat!
    var dismissGesture : UITapGestureRecognizer!
    //动画闭包
    var animationClosure : BasePopViewAnimationClosure?
    //时间闭包
    var eventClosure : BasePodViewEventClosure?

    override init(frame: CGRect) {

        isDismissByTouchBackgrond = true
        backgroundAlpha = 0.4
        animationDuration = 0.4
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        curtainView = UIView()
        self.addSubview(curtainView)
        curtainView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        curtainView.backgroundColor = .black
        curtainView.alpha = 0
        
        dismissGesture = UITapGestureRecognizer(target: self, action: #selector(tapBackgroundAction))
        curtainView.addGestureRecognizer(dismissGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        UIView.animate(withDuration: TimeInterval(animationDuration), delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.curtainView.alpha = self.backgroundAlpha
            if (self.animationClosure != nil){ //拆可选值方式1
                self.animationClosure!(0)
            }
        }) { (completion) in
            
        }
    }

    func dismiss() {
        UIView.animate(withDuration: TimeInterval(animationDuration), delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.curtainView.alpha = 0
            if let closure = self.animationClosure{ //拆可选值方式2
                closure(1)
            }
        }) { (completion) in
            if let eventClosure = self.eventClosure{
                eventClosure(0)
            }
            self.removeFromSuperview()
        }
    }

    
    func setAnimationClosure(closure:@escaping BasePopViewAnimationClosure){
        animationClosure = closure
    }
    
    func setEventClosure(closure:@escaping BasePodViewEventClosure) -> Void {
        eventClosure = closure
    }
    
    @objc func tapBackgroundAction() {
        if isDismissByTouchBackgrond {
            self.dismiss()
        }
    }

}


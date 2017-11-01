//
//  XBSegmentViewController.swift
//  SwiftLearn_Example
//
//  Created by xy_yanfa_imac on 2017/11/1.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

class XBSegmentViewController: UIViewController,XBSegmentControlDeletate,UIScrollViewDelegate {
    
    var subViewControllers = [UIViewController]()
    var subVCTitles = [String]()
    var segmentControl : XBSegmentControl!
    var segmentControlSliderUpdateSoure : XBSegmentControlSliderUpdateSourece = .slideScrollView
    var scorllView : UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "通讯录"
        
        segmentControl = XBSegmentControl(frame: CGRect(x: 0, y: 64, width: self.view.bounds.width, height: 50), titles: subVCTitles)
        segmentControl.delegete = self
        self.view.addSubview(segmentControl)
        
        scorllView = UIScrollView(frame: CGRect(x: 0, y: 64+50, width: self.view.bounds.width, height: self.view.bounds.height-64-50))
        scorllView.delegate = self
        scorllView.contentSize = CGSize(width:self.view.bounds.width*(CGFloat)(subViewControllers.count) , height: self.view.bounds.height-64-50)
        scorllView.isPagingEnabled = true
        scorllView.backgroundColor = UIColor.groupTableViewBackground
        self.view.addSubview(scorllView)
        
        let view = UIView(frame: CGRect(x: 414, y: 0, width: 414, height: 500))
        view.backgroundColor = .red
        scorllView.addSubview(view)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func xbSegmentControl(_ xbSegmentControl: XBSegmentControl, didSelectIndex index: Int) {
        scorllView.setContentOffset(CGPoint(x:CGFloat(index)*self.view.frame.width,y:0), animated: true)
        segmentControlSliderUpdateSoure = .touchButton(buttonIndex: index)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        
        segmentControl.updateSlider(percent: scrollView.contentOffset.x/self.view.frame.width, source: segmentControlSliderUpdateSoure)
        print(scrollView.contentOffset.x/self.view.frame.width)
    }
        

}

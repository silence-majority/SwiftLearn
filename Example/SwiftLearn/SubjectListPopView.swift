//
//  SubjectListPopView.swift
//  SwiftLearn_Example
//
//  Created by xy_yanfa_imac on 2017/11/2.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

let screenWidth = UIApplication.shared.keyWindow?.frame.width
let screenHeight = UIApplication.shared.keyWindow?.frame.height
class SubjectListPopView: BasePopView,UICollectionViewDelegate,UICollectionViewDataSource{
    
    private var contentView = UIView()
    private var collectionView : UICollectionView!
    private var contentViewHeight : CGFloat = 0
    var subjectNameArray = [String]()

    init(frame: CGRect ,subjectNameArr : [String]) {
        super.init(frame: frame)
    
        subjectNameArray = subjectNameArr
        contentViewHeight = CGFloat(Int((subjectNameArray.count+3)/4)) * (screenWidth!/4)
        print( Int((subjectNameArray.count+3)/4))
        self.addSubview(contentView)
        contentView.backgroundColor = UIColor.white
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(contentViewHeight)
        }
        
        contentView.transform = CGAffineTransform(translationX: 0, y: -contentViewHeight)
        self.setAnimationClosure { (animationId) -> Void in
            if animationId == 0{
                self.contentView.transform = .identity
            }else{
                self.contentView.transform = CGAffineTransform(translationX: 0, y: -self.contentViewHeight)
            }
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth!/4, height: screenWidth!/4)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth!, height: contentViewHeight),collectionViewLayout:layout)
        contentView.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(XBSubjectCollectionViewCell.self, forCellWithReuseIdentifier: "XBSubjectCollectionViewCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return subjectNameArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell : XBSubjectCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:"XBSubjectCollectionViewCell" , for: indexPath) as! XBSubjectCollectionViewCell

        cell.setCell(name: subjectNameArray[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let eventClosure = self.eventClosure{
            eventClosure(100+indexPath.item)
        }
        self.dismiss()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let lineColor = UIColor.lightGray
        let lineWidth : CGFloat = 0.5

        let rowCount : Int = (subjectNameArray.count+3)/4
        let lastRowItemCount = subjectNameArray.count - (rowCount-1)*4
        for index in 0...rowCount-1{
            if index == 0{
                 self.drawLine(starPoint: CGPoint(x: 0, y: CGFloat(index)*screenWidth!/4+1), endPoint: CGPoint(x: collectionView.frame.width, y: CGFloat(index)*screenWidth!/4+1), lineWidth: lineWidth, lineColor: lineColor)
            }else{
                 self.drawLine(starPoint: CGPoint(x: 0, y: CGFloat(index)*screenWidth!/4), endPoint: CGPoint(x: collectionView.frame.width, y: CGFloat(index)*screenWidth!/4), lineWidth: lineWidth, lineColor: lineColor)
            }
        }
        
        for index in 1...3{
            if index <= lastRowItemCount{
                self.drawLine(starPoint: CGPoint(x: CGFloat(index)*screenWidth!/4, y: 0), endPoint: CGPoint(x: CGFloat(index)*screenWidth!/4, y: collectionView.frame.height), lineWidth: lineWidth, lineColor: lineColor)
            }else{
                self.drawLine(starPoint: CGPoint(x: CGFloat(index)*screenWidth!/4, y: 0), endPoint: CGPoint(x: CGFloat(index)*screenWidth!/4, y: collectionView.frame.height-screenWidth!/4), lineWidth: lineWidth, lineColor: lineColor)
            }
        }
    }
    
    func drawLine(starPoint:CGPoint,endPoint:CGPoint,lineWidth:CGFloat,lineColor:UIColor){
        let path = CGMutablePath()
        path.move(to: starPoint)
        path.addLine(to: endPoint)
        
        let lineLayer = CAShapeLayer()
        lineLayer.path = path
        lineLayer.strokeColor = lineColor.cgColor
        lineLayer.lineWidth = lineWidth
        collectionView.layer.addSublayer(lineLayer)
    }
}

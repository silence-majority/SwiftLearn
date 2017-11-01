//
//  ViewController.swift
//  SwiftLearn
//
//  Created by silence-majority on 10/25/2017.
//  Copyright (c) 2017 silence-majority. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "首页"
        self.view.backgroundColor = UIColor.groupTableViewBackground
        self.makeUI()
        
//        if #available(iOS 11.0, *) {
//            self.navigationController?.navigationBar.prefersLargeTitles = true
//            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)]
//            self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor:#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)]
//
//            self.tableView.estimatedSectionHeaderHeight = 0;
//            //当有heightForFooter delegate时设置
//            self.tableView.estimatedSectionFooterHeight = 0;
//        } else {
//            self.automaticallyAdjustsScrollViewInsets = false;
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        let popView = BasePopView(frame: (UIApplication.shared.keyWindow?.bounds)!)
//        UIApplication.shared.keyWindow?.addSubview(popView)
////        popView.animationclosure = { (animationId:Int)->Void in
////            print(animationId)
////        }
//
//        popView.setAnimationClosure { (animationId) -> Void? in
//            print(animationId)
//        }
//        popView.setEventClosure { (eventId) -> Void? in
//            print(eventId)
//        }
//    }
    
    func makeUI() {
//        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: self.view.frame.size.height - 64), style: .grouped)
//        self.view.addSubview(tableView)
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.backgroundColor = UIColor.cyan
//        tableView.estimatedRowHeight = 0
//        tableView.estimatedSectionFooterHeight = 0
//        tableView.estimatedSectionHeaderHeight = 0
        
//        let seg = SegmentSliderView(frame: CGRect(x: 0, y: 100, width: 414, height: 60), titleArray: ["a","b"])
//        self.view.addSubview(seg)
//        seg.horizontalMargin = 100
//        seg.backgroundColor = .red
        
//        let seg = XBSegmentControl(frame: CGRect(x: 0, y: 64, width: 414, height: 50), titles:["我的老师","我的同学","我的群聊"])
//        self.view.addSubview(seg)
    }
    
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell : UITableViewCell =  UITableViewCell(style: .default, reuseIdentifier: "cellId")
//        cell.textLabel?.text = "第\(indexPath.row)行"
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0.001
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let target = SecondTableViewController()
//        self.navigationController?.pushViewController(target, animated: true)
//    }
//
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(self.navigationController?.navigationBar.frame)
//
//    }

    
}


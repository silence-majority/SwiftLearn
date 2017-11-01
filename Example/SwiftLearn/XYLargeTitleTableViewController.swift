//
//  XYLargeTitleTableViewController.swift
//  SwiftLearn_Example
//
//  Created by xy_yanfa_imac on 2017/10/27.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

class XYLargeTitleTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var tableView = UITableView()


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: .default, reuseIdentifier: "XYLargeTitleTableViewCellIdentifier")
        return cell
    }
    

}

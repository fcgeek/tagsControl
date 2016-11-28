//
//  ViewController.swift
//  TagsControl
//
//  Created by liujianlin on 2016/11/28.
//  Copyright © 2016年 fcgeek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tagsView: TagsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func addTagAction(_ sender: Any) {
        tagsView.removeLastTag()        
    }

}


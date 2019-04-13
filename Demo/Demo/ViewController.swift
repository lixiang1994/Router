//
//  ViewController.swift
//  Demo
//
//  Created by 李响 on 2019/4/12.
//  Copyright © 2019 swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func openAction(_ sender: Any) {
        Router.open(.open_live)
    }
    
}


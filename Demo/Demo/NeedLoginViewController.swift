//
//  NeedLoginViewController.swift
//  Demo
//
//  Created by 李响 on 2019/4/27.
//  Copyright © 2019 swift. All rights reserved.
//

import UIKit

class NeedLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 0.3137254902, blue: 0.3137254902, alpha: 1)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapAction() {
        close()
    }
}

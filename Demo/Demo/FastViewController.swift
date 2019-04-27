//
//  FastViewController.swift
//  Demo
//
//  Created by 李响 on 2019/4/10.
//  Copyright © 2019 swift. All rights reserved.
//

import UIKit

class FastViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapAction() {
        close()
    }
}

extension FastViewController: RouterSingleable {
    
    var single: RouterSingleType {
        return .fast
    }
    
    func close(will single: RouterSingleType, completion: @escaping (Bool) -> Void) {
        switch single {
        case .fast:
            completion(false)
            
        default:
            close {
                completion(true)
            }
        }
    }
}

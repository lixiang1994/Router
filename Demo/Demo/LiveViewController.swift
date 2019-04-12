//
//  LiveViewController.swift
//  Demo
//
//  Created by 李响 on 2019/4/10.
//  Copyright © 2019 swift. All rights reserved.
//

import UIKit

class LiveViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapAction() {
        close()
    }
}

extension LiveViewController: RouterSingleable {
   
    var single: RouterSingleType {
        return .live
    }
    
    func close(will single: RouterSingleType, completion: @escaping (Bool) -> Void) {
        switch single {
        case .live:
            completion(false)
            
        default:
            close {
                completion(true)
            }
        }
    }
    
    func open(_ completion: @escaping () -> Void) {
        guard let controller = UIViewController.topMost else {
            return
        }
        controller.present(self, animated: true, completion: completion)
    }
}

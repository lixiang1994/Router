//
//  RouterAccountPlugin.swift
//  Demo
//
//  Created by 李响 on 2019/4/10.
//  Copyright © 2019 swift. All rights reserved.
//

import Router

class RouterAccountPlugin: Plugin<RouterType> {
    
    override func prepare(open type: RouterType, completion: @escaping (Bool) -> Void) {
        guard type == .open_needlogin else {
            completion(true)
            return
        }
        guard !Account.isLogin else {
            completion(true)
            return
        }
        guard let root = AppDelegate.shared.window?.rootViewController else {
            completion(false)
            return
        }
        let controller = LoginViewController.init { (result) in
            completion(result)
        }
        root.present(controller, animated: true)
    }
}

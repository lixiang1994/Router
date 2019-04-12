//
//  RouterAccountPlugin.swift
//  Demo
//
//  Created by 李响 on 2019/4/10.
//  Copyright © 2019 swift. All rights reserved.
//

import Router

class RouterAccountPlugin: Pluginable {
    
    func prepare(open type: RouterType, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            completion(true)
        }
    }
}

//
//  RouterLaunchPlugin.swift
//  Demo
//
//  Created by 李响 on 2019/4/10.
//  Copyright © 2019 swift. All rights reserved.
//

import Router

class RouterLaunchPlugin: Pluginable {
    
    private var completion: ((Bool) -> Void)?
    
    init() {
        
        NotificationCenter.Delegate.add(
            .launched,
            observer: self,
            selector: #selector(launched)
        )
    }
    
    @objc private func launched() {
        completion?(true)
        completion = nil
    }
    
    func prepare(open type: RouterType, completion: @escaping (Bool) -> Void) {
        guard !AppDelegate.shared.isLaunched else {
            completion(true)
            return
        }
        self.completion?(false)
        self.completion = completion
    }
}

//
//  RouterLaunchPlugin.swift
//  Demo
//
//  Created by 李响 on 2019/4/10.
//  Copyright © 2019 swift. All rights reserved.
//

import Router

class RouterLaunchPlugin: Plugin<RouterType> {
    
    private var completion: ((Bool) -> Void)?
    
    override init() {
        super.init()
        
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
    
    /*
        在准备打开阶段 处理启动状态
        通常在APP启动后 我们需要进行一些必要的操作 例如: 加载必要的配置数据等等,
        这些操作没完成之前就打开了某些页面 是非常危险的.
        这里演示的就是根据启动完成状态延后打开操作, 常见的情景为 外部通过OpenURL启动APP打开某一页面.
     */
    override func prepare(open type: RouterType, completion: @escaping (Bool) -> Void) {
        guard !AppDelegate.shared.isLaunched else {
            completion(true)
            return
        }
        self.completion?(false)
        self.completion = completion
    }
}

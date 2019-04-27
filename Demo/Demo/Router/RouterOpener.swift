//
//  RouterOpener.swift
//  Route
//
//  Created by 李响 on 2019/4/10.
//  Copyright © 2019 swift. All rights reserved.
//

import Foundation
import UIKit
import SafariServices
import Router

extension RouterType {
    
    // 根据类型或URL 返回对应的视图控制器
    func controller(url: URLConvertible, values: [String: Any]) -> Routerable? {
        switch self {
        case .open_http, .open_https:
            guard let url = url.urlValue else { return nil }
            return SFSafariViewController(url: url)
            
        case .open_none:
            return NoneViewController()
            
        case .open_live:
            guard let id = url.queryParameters["id"] else { return nil }
            let controller = LiveViewController()
            controller.id = id
            return controller
            
        case .open_fast:
            return FastViewController()
            
        case .open_needlogin:
            return NeedLoginViewController()
        }
    }
    
    // 根据类型或URL 返回对应的处理 注: 当上面方法因无需要打开的控制器返回时 才会执行.
    func handle(url: URLConvertible, values: [String : Any], completion: @escaping (Bool) -> Void) {
        completion(true)
    }
}

// 所有需要支持 Router 的视图控制器都需要实现 Routerable 协议
// Routerable 协议默认实现了通用的打开关闭处理逻辑 如无法满足 可重写

extension NoneViewController: Routerable { }
extension NeedLoginViewController: Routerable { }

extension SFSafariViewController: Routerable {
    
    public func open(_ completion: @escaping () -> Void = {}) {
        guard let controller = UIViewController.topMost else {
            return
        }
        
        controller.present(self, animated: true, completion: completion)
    }
}

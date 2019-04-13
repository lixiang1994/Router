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

class RouterOpener: Openerable {
    
    func controller(type: RouterType,
                    url: URLConvertible,
                    values: [String: Any]) -> Routerable? {
        switch type {
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
        }
    }
    
    func handle(type: RouterType, url: URLConvertible, values: [String : Any], completion: @escaping (Bool) -> Void) {
        completion(true)
    }
}

extension NoneViewController: Routerable { }

extension SFSafariViewController: Routerable {
    
    public func open(_ completion: @escaping () -> Void = {}) {
        guard let controller = UIViewController.topMost else {
            return
        }
        
        controller.present(self, animated: true, completion: completion)
    }
}

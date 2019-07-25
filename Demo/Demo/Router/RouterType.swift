//
//  RouterType.swift
//  Demo
//
//  Created by 李响 on 2019/4/10.
//  Copyright © 2019 swift. All rights reserved.
//

import Foundation
import UIKit
import Router

private let schemes = "router"

enum RouterType {
    case open_http
    case open_https
    case open_none
    case open_live
    case open_fast
    case open_needlogin
}

extension RouterType: RouterTypeable {
    
    // 所有类型注册时使用的URL模板
    var pattern: String {
        switch self {
        case .open_http:        return "http://<path:_>"
        case .open_https:       return "https://<path:_>"
        case .open_none:        return schemes + "://open/none"
        case .open_fast:        return schemes + "://open/fast"
        case .open_live:        return schemes + "://open/live"
        case .open_needlogin:   return schemes + "://open/needlogin"
        }
    }
}

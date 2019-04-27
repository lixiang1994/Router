//
//  RouterSinglePlugin.swift
//  Route
//
//  Created by 李响 on 2019/4/10.
//  Copyright © 2019 swift. All rights reserved.
//

import Router

protocol RouterSingleable: Routerable {
    
    /// 当前类型
    var single: RouterSingleType { get }
    
    /// 关闭
    ///
    /// - Parameters:
    ///   - single: 即将准备打开的类型
    ///   - completion: 关闭完成回调
    func close(will single: RouterSingleType, completion: @escaping (Bool) -> Void)
}

class RouterSinglePlugin: Plugin<RouterType> {
    
    override func prepare(open type: RouterType, completion: @escaping (Bool) -> Void) {
        guard let single = make(type) else {
            completion(true)
            return
        }
        guard let current = current?.object else {
            completion(true)
            return
        }
        current.close(will: single, completion: completion)
    }
    
    override func will(open type: RouterType, controller: Routerable) {
        guard let controller = controller as? Singleable else {
            return
        }
        current = WeakWrapper(controller)
    }
}

extension RouterSinglePlugin {
    
    typealias Singleable = RouterSingleable
    private static var currentWrapper: WeakWrapper?
    
    private var current: WeakWrapper? {
        get { return RouterSinglePlugin.currentWrapper }
        set { RouterSinglePlugin.currentWrapper = newValue }
    }
    
    private class WeakWrapper {
        weak var object: Singleable?
        init(_ object: Singleable?) {
            self.object = object
        }
    }
}

extension RouterSinglePlugin {
    
    func make(_ url: RouterType) -> RouterSingleType? {
        switch url {
        case .open_live:    return .live
        case .open_fast:    return .fast
        default:            return nil
        }
    }
}

enum RouterSingleType {
    case live
    case fast
}

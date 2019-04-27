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
    
    /*
     在准备打开阶段 拦截单一特性页面
     (在一些业务场景中 最多只能有一个打开, 不能同时打开的页面的这种特性 简称单一特性)
     
     判断当前要打开的类型是否为单一特性类型.
     判断当前是否有相同单一特性的页面已经打开.
     告知原来已经打开的页面即将要打开一个新的页面 请求关闭处理.
     */
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
    
    /*
        在即将打开的方法中记录新的单一特性页面, 以供下一次打开时进行操作
     */
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

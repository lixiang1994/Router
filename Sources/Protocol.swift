//
//  Protocol.swift
//  ┌─┐      ┌───────┐ ┌───────┐
//  │ │      │ ┌─────┘ │ ┌─────┘
//  │ │      │ └─────┐ │ └─────┐
//  │ │      │ ┌─────┘ │ ┌─────┘
//  │ └─────┐│ └─────┐ │ └─────┐
//  └───────┘└───────┘ └───────┘
//
//  Created by lee on 2019/4/1.
//  Copyright © 2019年 lee. All rights reserved.
//

import Foundation
import UIKit

public protocol RouterPluginable {
    
    associatedtype T
    
    /// 是否可以打开
    ///
    /// - Parameter url: 类型
    /// - Returns: true or false
    func should(open type: T) -> Bool
    
    /// 准备打开
    ///
    /// - Parameters:
    ///   - url: 类型
    ///   - completion: 准备完成回调 (无论结果如何必须回调)
    func prepare(open type: T, completion: @escaping (Bool) -> Void)
    
    /// 即将打开
    ///
    /// - Parameters:
    ///   - type: 类型
    ///   - controller: 视图控制器
    func will(open type: T, controller: Routerable)
    
    /// 已经打开
    ///
    /// - Parameters:
    ///   - type: 类型
    ///   - controller: 视图控制器
    func did(open type: T, controller: Routerable)
}

public extension RouterPluginable {
    
    func should(open type: T) -> Bool {
        return true
    }
    
    func prepare(open type: T, completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    func will(open type: T, controller: Routerable) {
    }
    
    func did(open type: T, controller: Routerable) {
    }
}

public protocol RouterTypeable: CaseIterable {
    
    /// 模板 用于注册 例如: xxx://open/<path:_>
    var pattern: String { get }
    
    /// 完整 用于打开 例如: xxx://open/xxx?id=1
    var complete: String { get }
    
    /// 打开控制器
    ///
    /// - Parameters:
    ///   - url: url
    ///   - values: 参数值
    /// - Returns: 实现了 Routerable 协议的视图控制器 如果返回为空则会调用下面打开处理方法
    func controller(url: URLConvertible, values: [String: Any]) -> Routerable?
    
    /// 打开处理 (当无控制器时执行)
    ///
    /// - Parameters:
    ///   - url: url
    ///   - values: 参数值
    ///   - completion: 处理完成结果回调 *必须调用
    func handle(url: URLConvertible, values: [String: Any], completion: @escaping (Bool) -> Void)
}

public protocol Routerable: UIViewController {
    
    /// 打开
    ///
    /// - Parameter completion: 打开完成回调
    func open(_ completion: @escaping () -> Void)
    
    /// 关闭
    ///
    /// - Parameters:
    ///   - completion: 关闭完成回调
    func close(_ completion: @escaping () -> Void)
}

public extension RouterTypeable {
    
    func appending(_ params: [String: String]) -> String {
        return appending(complete, params)
    }
    
    func appending(_ url: String, _ params: [String: String]) -> String {
        guard var components = URLComponents(string: url) else {
            return url
        }
        
        let query = components.percentEncodedQuery ?? ""
        let temp = params.compactMap({
            guard !$0.isEmpty, !$1.isEmpty else { return nil }
            guard let _ = Foundation.URL(string: $1) else {
                let encoded = $1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? $1
                return "\($0)=\(encoded)"
            }
            
            let string = "?!@#$^&%*+,:;='\"`<>()[]{}/\\| "
            let character = CharacterSet(charactersIn: string).inverted
            let encoded = $1.addingPercentEncoding(withAllowedCharacters: character) ?? $1
            return "\($0)=\(encoded)"
        }).joined(separator: "&")
        components.percentEncodedQuery = query.isEmpty ? temp : query + "&" + temp
        return components.url?.absoluteString ?? url
    }
}

extension Routerable {
    
    public func open(_ completion: @escaping () -> Void = {}) {
        guard let controller = UIViewController.topMost else {
            return
        }
        
        if let navigation = controller as? UINavigationController {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            navigation.pushViewController(self, animated: true)
            CATransaction.commit()
            
        } else if let navigation = controller.navigationController {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            navigation.pushViewController(self, animated: true)
            CATransaction.commit()
            
        } else {
            let navigation = UINavigationController(rootViewController: self)
            controller.present(navigation, animated: true, completion: completion)
        }
    }
    
    public func close(_ completion: @escaping () -> Void = {}) {
        guard
            let navigation = navigationController,
            navigation.viewControllers.first != self else {
                let presenting = presentingViewController ?? self
                presenting.dismiss(animated: true, completion: completion)
                return
        }
        guard presentedViewController == nil else {
            dismiss(animated: true) { [weak self] in self?.close(completion) }
            return
        }
        
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        let temp = navigation.viewControllers.filter { $0 != self }
        navigation.setViewControllers(temp, animated: true)
        CATransaction.commit()
    }
}

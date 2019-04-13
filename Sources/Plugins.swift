//
//  Plugins.swift
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

public struct Plugins<T: RouterTypeable> {
    
    internal let plugins: [AnyPlugin<T>]
    
    public init<P: RouterPluginable>(_ item: P) where P.T == T {
        self.plugins = [AnyPlugin(item)]
    }
    
    internal init(_ plugins: [AnyPlugin<T>] = []) {
        self.plugins = plugins
    }
    
    public func add<P: RouterPluginable>(_ item: P) -> Plugins where P.T == T {
        return Plugins(plugins + [AnyPlugin(item)])
    }
}

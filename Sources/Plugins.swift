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

public struct Plugins<T: Typeable> {
    
    internal let plugins: [PluginWrapper<T>]
    
    public init() {
        self.plugins = []
    }
    
    internal init(_ plugins: [PluginWrapper<T>] = []) {
        self.plugins = plugins
    }
    
    public func add<P: Pluginable>(_ item: P) -> Plugins where P.T == T {
        return Plugins(plugins + [PluginWrapper(item)])
    }
}

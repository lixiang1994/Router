//
//  Wrapper.swift
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

struct OpenerWrapper<T: Typeable>: Openerable {
    
    private let controller: (T, URLConvertible, [String : Any]) -> Routerable?
    private let handle: (T, URLConvertible, [String : Any], @escaping (Bool)->Void) -> Void
    init<I: Openerable>(_ type: I) where I.T == T {
        controller = { type.controller(type: $0, url: $1, values: $2) }
        handle = { type.handle(type: $0, url: $1, values: $2, completion: $3) }
    }
    
    func controller(type: T, url: URLConvertible, values: [String : Any]) -> Routerable? {
        return controller(type, url, values)
    }
    
    func handle(type: T, url: URLConvertible, values: [String : Any], completion: @escaping (Bool) -> Void) {
        handle(type, url, values, completion)
    }
}

struct PluginWrapper<T: Typeable>: Pluginable {
    
    private let should: (T) -> Bool
    private let prepare: (T, @escaping (Bool) -> Void) -> Void
    private let will: (T, Routerable) -> Void
    private let did: (T, Routerable) -> Void
    
    init<I: Pluginable>(_ type: I) where I.T == T {
        should = { type.should(open: $0) }
        prepare = { type.prepare(open: $0, completion: $1) }
        will = { type.will(open: $0, controller: $1) }
        did = { type.did(open: $0, controller: $1) }
    }
    
    func should(open type: T) -> Bool {
        return should(type)
    }
    
    func prepare(open type: T, completion: @escaping (Bool) -> Void) {
        prepare(type, completion)
    }
    
    func will(open type: T, controller: Routerable) {
        will(type, controller)
    }
    
    func did(open type: T, controller: Routerable) {
        did(type, controller)
    }
}

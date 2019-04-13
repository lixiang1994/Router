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

struct AnyPlugin<T: Typeable> {
    
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
}

extension AnyPlugin: Pluginable {
    
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

//
//  Plugin.swift
//  ┌─┐      ┌───────┐ ┌───────┐
//  │ │      │ ┌─────┘ │ ┌─────┘
//  │ │      │ └─────┐ │ └─────┐
//  │ │      │ ┌─────┘ │ ┌─────┘
//  │ └─────┐│ └─────┐ │ └─────┐
//  └───────┘└───────┘ └───────┘
//
//  Created by lee on 2019/4/27.
//  Copyright © 2019年 lee. All rights reserved.
//
import Foundation

open class Plugin<T: RouterTypeable>: RouterPluginable {
    
    public init() {
        
    }
    
    open func should(open type: T) -> Bool {
        return true
    }
    
    open func prepare(open type: T, completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    open func will(open type: T, controller: Routerable) {
    }
    
    open func did(open type: T, controller: Routerable) {
    }
}

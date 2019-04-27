//
//  Account.swift
//  Demo
//
//  Created by 李响 on 2019/4/27.
//  Copyright © 2019 swift. All rights reserved.
//

import Foundation

enum Account {
    
    static var isLogin: Bool {
        return info != nil
    }
    
    static var info: User?
}

struct User {
    let id: Int
    let name: String
    let avatar: String
    /* ... */
}

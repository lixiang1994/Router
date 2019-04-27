//
//  ViewController.swift
//  Demo
//
//  Created by 李响 on 2019/4/12.
//  Copyright © 2019 swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var list: [String] = [
        "打开http/https链接",
        "打开一个普通的页面",
        "打开一个需要登录的页面",
        "打开一个单一特性的页面 4s后打开另一个",
        "打开一个单一特性的页面 4s后打开新页面"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        )
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0: // 打开http/https链接
            Router.open("https://www.baidu.com")
        
        case 1: // 打开一个普通的页面
            Router.open(.open_none)
            
        case 2: // 打开一个需要登录的页面
            Router.open(.open_needlogin)
            
        case 3: // 打开一个单一特性的页面
            /*
                LiveViewController 和 FastViewController 在业务场景中为单一特性 (最多只能有一个打开, 不能同时打开 简称单一特性)
                这里模拟 LiveViewController 打开后 因某种原因要打开 FastViewController
                演示的逻辑为 关闭 LiveViewController 后再打开 FastViewController
             */
            Router.open(.open_live)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                Router.open(.open_fast)
            }
        
        case 4:
            /*
             LiveViewController 在业务场景中为单一特性 (最多只能有一个打开, 不能同时打开 简称单一特性)
             这里模拟 LiveViewController 打开后 因某种原因要打开另一个 LiveViewController
             (比如点击某个推送通知 触发了打开一个新的 LiveViewController)
             演示的逻辑为 关闭 LiveViewController 后再打开新的 LiveViewController
             */
            Router.open(.open_live)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                Router.open(.open_live)
            }
            
        default:
            break
        }
    }
}


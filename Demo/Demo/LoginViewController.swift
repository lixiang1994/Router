//
//  LoginViewController.swift
//  Demo
//
//  Created by 李响 on 2019/4/27.
//  Copyright © 2019 swift. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    lazy var loginButton: UIButton = {
        $0.setTitle("Login", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return $0
    } ( UIButton() )
    
    lazy var cancelButton: UIButton = {
        $0.setTitle("Cancel", for: .normal)
        $0.setTitleColor(.red, for: .normal)
        $0.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        return $0
    } ( UIButton() )
    
    private var completion: ((Bool) -> Void)?
    
    init(_ completion: @escaping ((Bool) -> Void)) {
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupLayout()
    }
    
    private func setup() {
        view.backgroundColor = .white
        view.addSubview(loginButton)
        view.addSubview(cancelButton)
    }
    
    private func setupLayout() {
        loginButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(40)
        }
    }
}

extension LoginViewController {
    
    @objc private func loginAction(_ sender: UIButton) {
        // 假装登录成功 存储用户信息
        Account.info = User(id: 1994, name: "LEE", avatar: "XXXX")
        
        dismiss(animated: true) {
            self.completion?(true)
        }
    }
    
    @objc private func cancelAction(_ sender: UIButton) {
        dismiss(animated: true) {
            self.completion?(false)
        }
    }
}

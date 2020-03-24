Pod::Spec.new do |s|

s.name         = "Router"
s.version      = "1.1.2"
s.summary      = "基于URLNavigator抽象的路由组件 支持任意类型配置 插件机制"

s.homepage     = "https://github.com/lixiang1994/Router"

s.license      = { :type => "MIT", :file => "LICENSE" }

s.author       = { "LEE" => "18611401994@163.com" }

s.platform     = :ios, "9.0"

s.source       = { :git => "https://github.com/lixiang1994/Router.git", :tag => s.version }

s.source_files  = "Sources/**/*.swift"

s.requires_arc = true

s.frameworks = "UIKit", "Foundation"

s.swift_version = "5.0"

s.dependency "URLNavigator", "2.3.0"

end

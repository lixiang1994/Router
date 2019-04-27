# Router

![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)

[URLNavigator](https://github.com/devxoul/URLNavigator) 抽象路由组件

## [天朝子民](README_CN.md)

## Features

- [x] 支持基于插件机制的不同处理 如登录拦截等.
- [x] 配置独立且易于管理.
- [x] 良好的业务可扩展性.
- [x] 安全的页面管理.
- [x] 支持异步完成结果回调.


## 安装

Router 仅支持CocoaPods.

**CocoaPods - Podfile**

```ruby
source 'https://github.com/lixiang1994/Specs'

pod 'Router'
```

## 使用

首先导入framework:

```swift
import Router
```

下面是一些简单示例. 支持所有设备和模拟器:

### 创建 router

```swift
let router = Provider(
    [RouterXXXXXXPlugin(),
     RouterXXXXXXPlugin(),
     RouterXXXXXXPlugin()]
)
```

### RouterType

```swift
// 可以通过枚举声明所有类型 
enum RouterType: RouterTypeable {
    case open_http
    case open_https
    case open_xxxx
    /* ... */
}

extension RouterType {
    
    var pattern: String {
        switch self {
        case .open_http:        return "http://<path:_>"
        case .open_https:       return "https://<path:_>"
        case .open_xxxx:        return "xxxx://open/xxxx"
        /* ... */
        }
    }
    
    // 视图控制器获取 当路由打开某一URL, 会在这个方法内获取对应的视图控制器
    func controller(url: URLConvertible, values: [String: Any]) -> Routerable? {
        switch self {
        case .open_http, .open_https:
            guard let url = url.urlValue else { return nil }
            return SFSafariViewController(url: url)
            
        case .open_xxxx:
            return XXXXViewController()
        /* ... */
        }
    }
    
    // 打开处理 当路由打开某一URL 例如非打开页面类型业务时 上面的方法可以返回空, 则会执行下面方法处理相关的业务
    func handle(url: URLConvertible, values: [String : Any], completion: @escaping (Bool) -> Void) {
        /* ... */
        completion(true)
    }
}

// 每个支持路由的视图控制器需要实现 Routerable 协议
extension XXXXViewController: Routerable { }
extension SFSafariViewController: Routerable { }
```

### 自定义插件

```swift 
// 继承自 Plugin , 重写需要的方法 你可以在整个打开过程中做一切你想做的事情
class RouterXXXXPlugin: Plugin<RouterType> {
    
    // 能否打开
    override func should(open type: RouterType) -> Bool {
        /* ... */
        return true
    }
    
    // 准备打开时
    override func prepare(open type: RouterType, completion: @escaping (Bool) -> Void) {
        /* ... */
        completion(true)
    }
    
    // 即将打开
    override func will(open type: RouterType, controller: Routerable) {
        /* ... */
    }
    
    // 已经打开
    override func did(open type: RouterType, controller: Routerable) {
        /* ... */
    }
}
```

### 打开

```swift
// 根据类型打开页面
router.open(.open_xxxx)

// 根据URL打开页面
router.open("http://xxxxxxxx")

// 打开结果回调  打开过程中可能由于各种原因导致打开失败 例如: 这个页面需要登录 但是当前没有登录之类的
router.open("http://xxxxxxxx") { (result) in
    // 成功或失败
}
```

## 贡献

如果你需要实现特定功能或遇到错误，请打开issue。 如果你自己扩展了Router的功能并希望其他人也使用它，请提交拉取请求。


## 协议

Router 使用 MIT 协议. 有关更多信息，请参阅 [LICENSE](LICENSE) 文件.

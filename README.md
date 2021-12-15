# Router

![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)

[URLNavigator](https://github.com/devxoul/URLNavigator) abstract routing component written in Swift

## Version 2.0 -> [Apis](https://github.com/lixiang1994/Apis)

## [天朝子民](README_CN.md)

## Features

- [x] Support for different processing based on plugin mechanism.
- [x] Configuration is independent and easy to manage.
- [x] Good business scalability.
- [x] Safer page management.
- [x] Support for asynchronous completion of callbacks.


## Installation

Router officially supports CocoaPods only.

**CocoaPods - Podfile**

```ruby
source 'https://github.com/lixiang1994/Specs'

pod 'Router'
```

## Usage

First make sure to import the framework:

```swift
import Router
```

Here are some usage examples. All devices are also available as simulators:

### Create router

```swift
let router = Provider(
    [RouterXXXXXXPlugin(),
     RouterXXXXXXPlugin(),
     RouterXXXXXXPlugin()]
)
```

### RouterType

```swift
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
    
    func handle(url: URLConvertible, values: [String : Any], completion: @escaping (Bool) -> Void) {
        /* ... */
        completion(true)
    }
}


extension XXXXViewController: Routerable { }
extension SFSafariViewController: Routerable { }
```

### Custom plugins

```swift 
class RouterXXXXPlugin: Plugin<RouterType> {
    
    override func should(open type: RouterType) -> Bool {
        /* ... */
        return true
    }
    
    override func prepare(open type: RouterType, completion: @escaping (Bool) -> Void) {
        /* ... */
        completion(true)
    }
    
    override func will(open type: RouterType, controller: Routerable) {
        /* ... */
    }
    
    override func did(open type: RouterType, controller: Routerable) {
        /* ... */
    }
}
```

### Open

```swift
// Open page based on type
router.open(.open_xxxx)

// Open page based on url
router.open("http://xxxxxxxx")

// Result callback
router.open("http://xxxxxxxx") { (result) in
    // Success or failure
}

```

## Contributing

If you have the need for a specific feature that you want implemented or if you experienced a bug, please open an issue.
If you extended the functionality of Router yourself and want others to use it too, please submit a pull request.


## License

Router is under MIT license. See the [LICENSE](LICENSE) file for more info.

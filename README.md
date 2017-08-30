# DSPopup
![](https://img.shields.io/badge/language-swift-orange.svg)
![](https://img.shields.io/cocoapods/p/DSPopup.svg?style=flat)
![](https://img.shields.io/cocoapods/v/DSPopup.svg?style=flat)
![](https://img.shields.io/cocoapods/l/DSPopup.svg?style=flat)
[![Build Status](https://travis-ci.org/DiorStone/DSPopup.svg?branch=develop)](https://travis-ci.org/DiorStone/DSPopup)
[![codebeat badge](https://codebeat.co/badges/0aca6503-b90c-4b0a-bede-a8c921ce13ff)](https://codebeat.co/projects/github-com-diorstone-dspopup-develop)

DSPopup
平时项目中会经常使用弹框的场景(Alert,Sheet,Picker等),常见的流程是创建一个View然后添加到superView,然后添加各种动画和事件回调.在该流程中会存在一个固定的动作就是添加View可以抽象

## 使用

### Demo1

```
public typealias PopupAnimation = (UIView,(() -> Void)?) -> Void

//弹框协议
public protocol Popupable: class {
    
    /// 弹出框依附View
    var ds_attachedView: UIView? { get }
    
    /// 用于配置弹框和隐藏时的动画、布局等
    var ds_showAnimation: PopupAnimation? { get }
    var ds_hideAnimation: PopupAnimation? { get }
    func ds_showPopup(inView attachView: UIView, completion: (() -> Void)?)
    func ds_hidePopup(inView attachView: UIView, completion: (() -> Void)?)
}


// MARK: Demo
class CityPickerView: UIView, Popupable {
	// 自定义布局等...
}

let picker = CityPickerView()
picker.ds_show()


```



##安装
### CocoaPods
[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1.0+ is required to build DSPopup 0.1.0+.

To integrate Alamofire into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'DSPopup', '~> 0.1.0'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Alamofire into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "DiorStone/DSPopup" ~> 0.1.0
```

Run `carthage update` to build the framework and drag the built `DSPopup.framework` into your Xcode project.

### Manually

If you prefer not to use any of the aforementioned dependency managers, you can integrate Alamofire into your project manually.

#### Embedded Framework

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

  ```bash
  $ git init
  ```

- Add DSPopup as a git [submodule](http://git-scm.com/docs/git-submodule) by running the following command:

  ```bash
  $ git submodule add https://github.com/DiorStone/DSPopup.git
  ```

---

##更新说明
* 0.1.0
	- 初始化版本提交
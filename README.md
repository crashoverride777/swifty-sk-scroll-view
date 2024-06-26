[![Swift 5.6](https://img.shields.io/badge/swift-5.6-ED523F.svg?style=flat)](https://swift.org/download/)
[![Platform](https://img.shields.io/cocoapods/p/SwiftySKScrollView.svg?style=flat)]()
[![SPM supported](https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat)](https://swift.org/package-manager)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/SwiftySKScrollView.svg)](https://img.shields.io/cocoapods/v/SwiftySKScrollView.svg)

# SwiftySKScrollView

A Swift library to add a UIScrollView to your SpriteKit scenes. 

- [Deprecation](#deprecation)
- [Please Read](#please-read)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Deprecation

This library is deprecated and no longer supported.

## Please Read

In general it is not good practice to add UIKit elements to SpriteKit games, all your UI should be done using SpriteKit APIs (SKSpriteNodes, SKLabelNodes, SKNodes etc) directly in the relevant SKScene(s). However there are a few things in UIKit, UIScrollViews and UICollectionViews in particular, that would be quite difficult to recreate with SpriteKit APIs.

It is much better to use a UICollectionView for a scrollable list due to cell reusage end efficiency. 

## Requirements

- iOS 12.0+
- Swift 5.6+

## Installation

### Swift Package Manager

The Swift Package Manager is a tool for automating the distribution of Swift code and is integrated into the swift compiler.

To add a swift package to your project simple open your project in xCode and click File > Swift Packages > Add Package Dependency.
Than enter `https://github.com/crashoverride777/swifty-sk-scroll-view.git` as the repository URL and finish the setup wizard.

Alternatively if you have a Framwork that requires adding SwiftySKScrollView as a dependency is as easy as adding it to the dependencies value of your Package.swift.
```swift
dependencies: [
.package(url: "https://github.com/crashoverride777/swifty-sk-scroll-view.git", from: "2.4.0")
]
```

### Cocoa Pods

[CocoaPods](https://developers.google.com/admob/ios/quick-start#streamlined_using_cocoapods) is a dependency manager for Cocoa projects. Simply install the pod by adding the following line to your pod file


```swift
pod 'SwiftySKScrollView'
```

There is now an [app](https://cocoapods.org/app) which makes handling pods much easier

### Manually

Add the `SwiftySKScrollView.swift` file to your project.

## Usage

- Add the import statement when using CocoaPods or SwiftPackageManager

```swift
import SwiftySKScrollView 
```

- In your relevant SKScene you want to use it you create those 2 properties
 
```swift
class MenuScene: SKScene {
    var scrollView: SwiftySKScrollView?
    let moveableNode = SKNode()
    ...
}
```

- Set up the properties from step above.

In didMoveToView add the moveable node

```swift
addChild(moveableNode)
```

and set up the scrollView

Vertical scrolling
```swift
scrollView = SwiftySKScrollView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height), moveableNode: moveableNode, direction: .vertical)
scrollView?.contentSize = CGSize(width: scrollView!.frame.width, height: scrollView!.frame.height * 3) // makes it 3 times the height
view?.addSubview(scrollView!)
```

Horizontal scrolling
```swift
scrollView = SwiftySKScrollView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height), moveableNode: moveableNode, direction: .horizontal)
scrollView?.contentSize = CGSize(width: scrollView!.frame.width * 3, height: scrollView!.frame.height) // * 3 makes it three times as wide
view?.addSubview(scrollView!)
scrollView?.setContentOffset(CGPoint(x: 0 + scrollView!.frame.width * 2, y: 0), animated: true)
```

Line 1 inits the helper with your scene dimensions. You also pass along the moveableNode you created at step 2 and the scrollDirection you want. 

Line 2 is where you set up the content size of the scrollView.

Line 3 adds the scrollView

Line 4 (horizontal) resets the contentOffset so you start from left to right (UIKit coordinates are different to SpriteKits).

- Add sprites for each page in the scrollView to make positioning your actual stuff later on much easier

Vertical scrolling
```swift
guard let scrollView = scrollView else { return } // unwrap  optional 

let page1ScrollView = SKSpriteNode(color: .clear, size: CGSize(width: scrollView.frame.width, height: scrollView.frame.size.height))
page1ScrollView.position = CGPoint(x: frame.midX, y: frame.midY)
moveableNode.addChild(page1ScrollView)
        
let page2ScrollView = SKSpriteNode(color: .clear, size: CGSize(width: scrollView.frame.width, height: scrollView.frame.size.height))
page2ScrollView.position = CGPoint(x: frame.midX, y: frame.midY - scrollView.frame.height)
moveableNode.addChild(page2ScrollView)
        
let page3ScrollView = SKSpriteNode(color: .clear, size: CGSize(width: scrollView.frame.width, height: scrollView.frame.size.height))
page3ScrollView.position = CGPoint(x: frame.midX, y: frame.midY - (scrollView.frame.height * 2))
moveableNode.addChild(page3ScrollView)
```

Horizontal scrolling (positioning is in reverse)
```swift
guard let scrollView = scrollView else { return } // unwrap  optional 

let page1ScrollView = SKSpriteNode(color: .clear, size: CGSize(width: scrollView.frame.width, height: scrollView.frame.size.height))
page1ScrollView.position = CGPoint(x: frame.midX - (scrollView.frame.width * 2), y: frame.midY)
moveableNode.addChild(page1ScrollView)
        
let page2ScrollView = SKSpriteNode(color: .clear, size: CGSize(width: scrollView.frame.width, height: scrollView.frame.size.height))
page2ScrollView.position = CGPoint(x: frame.midX - (scrollView.frame.width), y: frame.midY)
moveableNode.addChild(page2ScrollView)
        
let page3ScrollView = SKSpriteNode(color: .clear, size: CGSize(width: scrollView.frame.width, height: scrollView.frame.size.height))
page3ScrollView.zPosition = -1
page3ScrollView.position = CGPoint(x: frame.midX, y: frame.midY)
moveableNode.addChild(page3ScrollView)
```

- Add your sprites, labels etc. Because you will add them to the above sprites you can position them as usual which is why its much easier to do Step 4 first.

Vertical scrolling
```swift

/// Test sprites page 1
let sprite1Page1 = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
sprite1Page1.position = CGPoint(x: 0, y: 0)
page1ScrollView.addChild(sprite1Page1)
        
let sprite2Page1 = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
sprite2Page1.position = CGPoint(x: sprite1Page1.position.x, y: sprite1Page1.position.y - sprite2Page1.size.height * 1.5)
sprite1Page1.addChild(sprite2Page1)
        
/// Test sprites page 2
let sprite1Page2 = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
sprite1Page2.position = CGPoint(x: 0, y: 0)
page2ScrollView.addChild(sprite1Page2)
        
let sprite2Page2 = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
sprite2Page2.position = CGPoint(x: sprite1Page2.position.x, y: sprite1Page2.position.y - (sprite2Page2.size.height * 1.5))
sprite1Page2.addChild(sprite2Page2)
        
/// Test sprites page 3
let sprite1Page3 = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
sprite1Page3.position = CGPoint(x: 0, y: 0)
page3ScrollView.addChild(sprite1Page3)
        
let sprite2Page3 = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
sprite2Page3.position = CGPoint(x: sprite1Page3.position.x, y: sprite1Page3.position.y - (sprite2Page3.size.height * 1.5))
sprite1Page3.addChild(sprite2Page3)
```

Horizontal
```swift
/// Test sprites page 1
let sprite1Page1 = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
sprite1Page1.position = CGPoint(x: 0, y: 0)
page1ScrollView.addChild(sprite1Page1)
        
let sprite2Page1 = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
sprite2Page1.position = CGPoint(x: sprite1Page1.position.x + (sprite2Page1.size.width * 1.5), y: sprite1Page1.position.y)
sprite1Page1.addChild(sprite2Page1)
        
/// Test sprites page 2
let sprite1Page2 = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
sprite1Page2.position = CGPoint(x: 0, y: 0)
page2ScrollView.addChild(sprite1Page2)
        
let sprite2Page2 = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
sprite2Page2.position = CGPoint(x: sprite1Page2.position.x + (sprite2Page2.size.width * 1.5), y: sprite1Page2.position.y)
sprite1Page2.addChild(sprite2Page2)
        
/// Test sprites page 3
let sprite1Page3 = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
sprite1Page3.position = CGPoint(x: 0, y: 0)
page3ScrollView.addChild(sprite1Page3)
        
let sprite2Page3 = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
sprite2Page3.position = CGPoint(x: sprite1Page3.position.x + (sprite2Page3.size.width * 1.5), y: sprite1Page3.position.y)
sprite1Page3.addChild(sprite2Page3)
```

- If you need to disable your scrollView incase you overlay another menu ontop of the scrollView or if you pressed a button you can use the isDisabled bool. Remember, UIKit elements get added to your GameViewController and not your SKScenes, so you will have to play around here and see how your SpriteKit UI interacts with the scrollView.

```swift
scrollView?.isDisabled = true
```

- Finally do not forget to remove the scroll view from your scene before transitioning to a new one. As mentioned above one of the pains when dealing with UIKit in SpriteKit. Its best done in WillMoveFromView

```swift
override func willMove(from view: SKView) {
    scrollView?.removeFromSuperview()
    scrollView = nil // nil out reference to deallocate properly
}
```

## License

SwiftySKScrollView is released under the MIT license. [See LICENSE](https://github.com/crashoverride777/swifty-sk-scroll-view/blob/master/LICENSE) for details.

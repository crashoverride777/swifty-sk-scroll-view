# SwiftySKScrollView

A helper class to add a UIScrollView to your SpriteKit scenes. 

The helper will automatically forward button presses to the relevant SKScene and node subclasses. 

# Please Read

In general it is not good practice to add UIKit elements to SpriteKit games, all your UI should be done using SpriteKit APIs (SKSpriteNodes, SKLabelNodes, SKNodes etc) directly in the relevant SKScene(s). However there are a few things in UIKit, UIScrollViews and UICollectionViews in particular, that would be quite difficult to recreate with SpriteKit APIs.

This is also an older project I actually no longer use in my own apps as it is not the most elegant solution in world to achieve a scrollable list. It should only be used for very small things such as a character select menus. 

It is much better to use a UICollectionView for a scrollable list due to cell reusage end efficiency. You can subclass UICollectionViews in similar fashion than this helper.

I will continue to maintain this repositiory indefinately. 

# Cocoa Pods

CocoaPods is a dependency manager for Cocoa projects. You can install it with the following command:

```swift
$ gem install cocoapods
```

To integrate SwiftySKScrollView into your Xcode project using CocoaPods, specify it in your Podfile:

```swift
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.3.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'SwiftySKScrollView'
end
```

Then, run the following command:

```swift
$ pod install
```

You can also download the CocoaPods app for macOS and manage your pods this way.

https://cocoapods.org/app

# Set-Up

- Step 1: Add the SwiftySKScrollView.swift file to your project or if you used CocoaPods add the 

```swift
import SwiftySKScrollView 
```

statement to your .swift file(s).

- Step 2: In your relevant SKScene you want to use it you create those 2 properties
 
```swift
class MenuScene: SKScene {
    var scrollView: SwiftySKScrollView?
    let moveableNode = SKNode()
    ...
}
```

- Step 3: - Set up the properties from step 2.

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

- Step 4: - Add sprites for each page in the scrollView to make positioning your actual stuff later on much easier

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

- Step 5: Add your sprites, labels etc. Because you will add them to the above sprites you can position them as usual which is why its much easier to do Step 4 first.

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

- Step 6: If you need to disable your scrollView incase you overlay another menu ontop of the scrollView or if you pressed a button you can use the isDisabled bool. Remember, UIKit elements get added to your GameViewController and not your SKScenes, so you will have to play around here and see how your SpriteKit UI interacts with the scrollView.

```swift
scrollView?.isDisabled = true
```

- Step 7: Finally do not forget to remove the scroll view from your scene before transitioning to a new one. As mentioned above one of the pains when dealing with UIKit in SpriteKit. Its best done in WillMoveFromView

```swift
override func willMove(from view: SKView) {
    scrollView?.removeFromSuperview()
    scrollView = nil // nil out reference to deallocate properly
}
```

# Release notes

- v2.1

Removed static properties

Sample project cleanup

Small changes to setup, please check instructions again


Know Issues: 

There is a problem with the scroll indicators positioning, so they are hidden for this release. Will fix ASAP

- v2.0.2

Swift 4 update

- v2.0.1

Cleanup

- v2.0

Project has been renamed to SwiftySKScrollView.

No more source breaking changes after this update. All future changes will be handled with deprecated messages unless the whole API changes.

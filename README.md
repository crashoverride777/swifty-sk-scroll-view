# Swift-2-SpriteKit-UIScrollView

A simple helper to add a UIScrollView to your SpriteKit scenes. 
This helper only really works well if your game is either in landscape or portrait, which normally is fairly standard for a game anyway.
Depending on your scene scale mode cropping could occur so you might have play around with your settings to get the best result.

The helper will also automatically forwared button presses to the scene and button presses on nodes. Therefore in your SKScenes your touches method will fire as usual.

This helper works best for smaller scrollable lists for things such as character select screens.

If you want something like a level select screen where there will be alot of buttons than its best to use a UICollectionView as it will make your life easier and the menu more efficient due to cell reusage. You can easily subclass UICollectionView in similar fashion to this helper.


# How to use

- Step 1: Add the CustomScrollView.swift file to your project

- Step 2: In your relevant SKScene you want to use it you create those 2 properties
 
```swift
class MenuScene: SKScene {
    weak var scrollView: CustomScrollView!
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
scrollView = CustomScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), scene: self, moveableNode: moveableNode, scrollDirection: .vertical)
scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height * 3) // makes it 3 times the height
view?.addSubview(scrollView)
```

Horizontal scrolling
```swift
scrollView = CustomScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), scene: self, moveableNode: moveableNode, scrollDirection: .horizontal)
scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 3, scrollView.frame.size.height) // * 3 makes it three times as wide
view?.addSubview(scrollView)

scrollView.setContentOffset(CGPoint(x: 0 + self.frame.size.width * 2, y: 0), animated: true)
```

Line 1 inits the helper with your scene dimensions. You also pass along the scene for reference, the moveableNode you created at step 2 and the scrollDirection. 

Line 2 is where you set up the content size of the scrollView.

Line 3 adds the scrollView to the subview

Line 4 for horizontal scrolling resets the contentOffset so you start from left to right (UIKit coordinates are different to SpriteKits).

- Step 4: - Add sprites for each page in the scrollView to make positioning your actual stuff later on much easier

Vertical scrolling
```swift
let page1ScrollView = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height))
page1ScrollView.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
moveableNode.addChild(page1ScrollView)
        
let page2ScrollView = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height))
page2ScrollView.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - (self.frame.size.height))
moveableNode.addChild(page2ScrollView)
        
let page3ScrollView = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height))
page3ScrollView.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - (self.frame.size.height * 2))
moveableNode.addChild(page3ScrollView)
```

Horizontal scrolling (positioning is in reverse)
```swift
let page1ScrollView = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height))
page1ScrollView.position = CGPointMake(CGRectGetMidX(self.frame) - (self.frame.size.width * 2), CGRectGetMidY(self.frame))
moveableNode.addChild(page1ScrollView)
        
let page2ScrollView = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height))
page2ScrollView.position = CGPointMake(CGRectGetMidX(self.frame) - (self.frame.size.width), CGRectGetMidY(self.frame))
moveableNode.addChild(page2ScrollView)
        
let page3ScrollView = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height))
page3ScrollView.zPosition = -1
page3ScrollView.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
moveableNode.addChild(page3ScrollView)
```

- Step 5: Add your sprites, labels etc. Because you will add them to the above sprites you can position them as usual which is why its much easier to do Step 4 first.

Vertical scrolling
```swift

/// Test sprites page 1
let sprite1Page1 = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 50, height: 50))
sprite1Page1.position = CGPointMake(0, 0)
page1ScrollView.addChild(sprite1Page1)
        
let sprite2Page1 = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 50, height: 50))
sprite2Page1.position = CGPointMake(sprite1Page1.position.x, sprite1Page1.position.y - sprite2Page1.size.height * 1.5)
sprite1Page1.addChild(sprite2Page1)
        
/// Test sprites page 2
let sprite1Page2 = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 50, height: 50))
sprite1Page2.position = CGPointMake(0, 0)
page2ScrollView.addChild(sprite1Page2)
        
let sprite2Page2 = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 50, height: 50))
sprite2Page2.position = CGPointMake(sprite1Page2.position.x, sprite1Page2.position.y - (sprite2Page2.size.height * 1.5))
sprite1Page2.addChild(sprite2Page2)
        
/// Test sprites page 3
let sprite1Page3 = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 50, height: 50))
sprite1Page3.position = CGPointMake(0, 0)
page3ScrollView.addChild(sprite1Page3)
        
let sprite2Page3 = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 50, height: 50))
sprite2Page3.position = CGPointMake(sprite1Page3.position.x, sprite1Page3.position.y - (sprite2Page3.size.height * 1.5))
sprite1Page3.addChild(sprite2Page3)
```

Horizontal
```swift
/// Test sprites page 1
let sprite1Page1 = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 50, height: 50))
sprite1Page1.position = CGPointMake(0, 0)
page1ScrollView.addChild(sprite1Page1)
        
let sprite2Page1 = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 50, height: 50))
sprite2Page1.position = CGPointMake(sprite1Page1.position.x + (sprite2Page1.size.width * 1.5), sprite1Page1.position.y)
sprite1Page1.addChild(sprite2Page1)
        
/// Test sprites page 2
let sprite1Page2 = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 50, height: 50))
sprite1Page2.position = CGPointMake(0, 0)
page2ScrollView.addChild(sprite1Page2)
        
let sprite2Page2 = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 50, height: 50))
sprite2Page2.position = CGPointMake(sprite1Page2.position.x + (sprite2Page2.size.width * 1.5), sprite1Page2.position.y)
sprite1Page2.addChild(sprite2Page2)
        
/// Test sprites page 3
let sprite1Page3 = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 50, height: 50))
sprite1Page3.position = CGPointMake(0, 0)
page3ScrollView.addChild(sprite1Page3)
        
let sprite2Page3 = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 50, height: 50))
sprite2Page3.position = CGPointMake(sprite1Page3.position.x + (sprite2Page3.size.width * 1.5), sprite1Page3.position.y)
sprite1Page3.addChild(sprite2Page3)
```

- Step 7: I made some class func so if you need to disable your scrollView incase you overlay another menu ontop of the scrollView or if you pressed a button. You will have to play around here and see how your buttons interact with the scrollView.

```swift
CustomScrollView.enable()
CustomScrollView.disable()
```

- Step 8: Finally do not forget to remove the scroll view from your scene before transitioning to a new one. One of the pains when dealing with UIKit in SpriteKit.

```swift
scrollView?.removeFromSuperView()
```

# Release notes

- v1.4

Clean-Up

- v1.3.1

Fixed an issue that could cause a crash when changing scenes.

Please change this line in the helper

      private unowned let: SKScene

to

      private let: SKScene
      
A big thanks for member iiMshl for pointing this out.

- v1.3

Moved the method to forward button presses on nodes into the helper so there is no more need to implement it in the gameScene. Please update your helper and remove the methods in your touches method that used the nodesTouched array in the helper (should show as error)

Other small fixes and improvements.

- v1.2.1

Clean-up

- v1.2

Updated sample project to show how to add more sprites to the same scrollView page.

- v1.1

Small improvements to make it easier to select vertical or horizontal scrolling without having to adjust some settings in the helper manually.

- v1.0

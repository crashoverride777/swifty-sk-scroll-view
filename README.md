# Swift-2-SpriteKit-UIScrollView

A simple helper to add a UIScrollView to your SpriteKit scenes. This helper only really works well if your game is either in landscape or portrait, which normally is fairly standard for a game anyway.

It also only works well if your scene scaleMode in your gameViewController is set to
```swift
.ResizeFill
```
which makes sure that your scenes do not get cropped. If you use other scaleModes such as ".AspectFill" than it might crop stuff in your scenes and therefore  the ScrollView, which you would than need to adjust for. 

# How to use

- Step 1: Add the CustomScrollView.swift file to your project

- Step 2: In your relevant SKScene you want to use it you create a moveable node
 
```swift
var moveableNode = SKNode()
```

and add it to the scene in viewDidLoad

```swift
addChild(moveableNode)
```

- Step 3: Init the scroll view helper. Create a property like so

```swift
weak var scrollView: CustomScrollView!
```

and set the scrollView in viewDidLoad like so

Vertical scrolling
```swift
scrollView = CustomScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), scene: self, moveableNode: moveableNode, scrollDirection: .Vertical)
scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height * 3) // makes it 3 times the height
view!.addSubview(scrollView)
```

Horizontal scrolling
```swift
scrollView = CustomScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), scene: self, moveableNode: moveableNode, scrollDirection: .Horizontal)
scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 3, scrollView.frame.size.height) // * 3 makes it three times as wide
view!.addSubview(scrollView)

scrollView.setContentOffset(CGPoint(x: 0 + self.frame.size.width * 2, y: 0), animated: true)
```

Line 1 inits the helper with your scene dimensions. You also pass along the scene for reference, the moveableNode you created at step 2 and the scrollDirection. 

Line 2 is where you set up the content size of the scrollView.

Line 3 adds the scrollView to the subview

Line 4 for horizontal scrolling resets the contentOffset so you start from left to right.

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

- Step 5: Make sure you scene registers for scroll view touch events, as in the buttons or labels added to the scrollView were pressed. So in all the touches methods you need/use you need to make sure that they basically looks like this.

```swift
for touch in touches {
    let location = touch.locationInNode(self)


    nodesTouched = nodesAtPoint(location)
    for node in nodesTouched {
        node.touchesBegan(touches, withEvent: event) // touches began in this case
        print("Item in scroll view pressed/moved,ended")

        // just do you thing here as usual
     }
}
```

- Step 6: Add your sprites to the screen

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
        
/// Test sprites page 2
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
        
/// Test sprites page 2
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
scrollView.removeFromSuperView()
```

# Release notes

- v1.3

Small fixes and improvements.

- v1.2.1

Clean-up

- v1.2

Updated sample project to show how to add more sprites to the same scrollView page.

- v1.1

Small improvements to make it easier to select vertical or horizontal scrolling without having to adjust some settings in the helper manually.

- v1.0

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
let scrollView: CustomScrollView!
```

and set the scrollView in viewDidLoad like so

Vertical scrolling
```swift
scrollView = CustomScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), scene: self, moveableNode: moveableNode, scrollDirection: .Vertical)
scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height * 3) // * 3 makes it 3times as long as screen
view!.addSubview(scrollView)
```

Horizontal scrolling
```swift
scrollView = CustomScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), scene: self, moveableNode: moveableNode, scrollDirection: .Horizontal)
scrollView.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height) // * 3 makes it three times as wide as screen
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
let page1ScrollView = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(self.frame.size.width, self.frame.size.height))
page1ScrollView.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
moveableNode.addChild(page1ScrollView)
        
let page2ScrollView = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(self.frame.size.width, self.frame.size.height))
page2ScrollView.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - (self.frame.size.height))
moveableNode.addChild(page2ScrollView)
        
let page3ScrollView = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(self.frame.size.width, self.frame.size.height))
page3ScrollView.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - (self.frame.size.height * 2))
moveableNode.addChild(page3ScrollView)
```

Horizontal scrolling (positioning is in reverse)
```swift
let page1ScrollView = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(self.frame.size.width, self.frame.size.height))
page1ScrollView.position = CGPointMake(CGRectGetMidX(self.frame) - (self.frame.size.width * 2), CGRectGetMidY(self.frame))
moveableNode.addChild(page1ScrollView)
        
let page2ScrollView = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(self.frame.size.width, self.frame.size.height))
page2ScrollView.position = CGPointMake(CGRectGetMidX(self.frame) - (self.frame.size.width), CGRectGetMidY(self.frame))
moveableNode.addChild(page2ScrollView)
        
let page3ScrollView = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(self.frame.size.width, self.frame.size.height))
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
```swift
let myLabel = SKLabelNode(fontNamed:"Chalkduster")
myLabel.text = "Hello, World!"
myLabel.fontSize = 45
myLabel.position = CGPointMake(0, 0)
page1ScrollView.addChild(myLabel)
        
/// Test sprite page 2
let sprite = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 50, height: 50))
sprite.position = CGPointMake(0, 0)
page2ScrollView.addChild(sprite)
        
/// Test sprite page 3
let sprite2 = SKSpriteNode(color: SKColor.blueColor(), size: CGSize(width: 50, height: 50))
sprite2.position = CGPointMake(0, 0)
page3ScrollView.addChild(sprite2)
```

- Step 7: I made some class func so if you need to disable your scrollView incase you overlay another menu ontop of the scrollView or if you pressed a button. Again you will probably have to play around here and see how the buttons interact with the scrollView.

```swift
CustomScrollView.enable()
CustomScrollView.disable()
```

- Step 8: Finally do not forget to remove the scroll view from your scene before transitioning to a new one. One of the pains when dealing with UIKit in SpriteKit.

```swift
scrollView.removeFromSuperView()
```

# Release notes

- v1.1

Small improvements to make it easier to select vertical or horizontal scrolling without having to adjust some settings in the helper manually.

- v1.0

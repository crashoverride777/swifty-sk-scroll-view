# Swift-2-SpriteKit-UIScrollView

A simple helper to add a UIScrollView to your SpriteKit scenes.
This helper works best scrolling vertically when your game is in portrait mode, and scrolling horizontally when your game is in landscape mode. I will try to address this in a future update.

# How to use

- Step 1: Add the CustomScrollView.swift file to your project

This make a subclass of UIScrollView and sets up the basic properties of it. It than has its own touches method which get passed along to the relevant scene.

- Step 2: In your relevant SKScene you want to use it you create a moveable node
 
```swift
var moveableNode = SKNode()
```

and add it to the scene in viewDidLoad

```swift
addChild(moveableNode)
```

Step 3: Init the scroll view helper like so

```swift
let scrollView: CustomScrollView!
```

and in viewDidLoad like so

```swift
scrollView = CustomScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), scene: self, moveableNode: moveableNode)
scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height * 2)
view.addSubview(scrollView) 
```

What you do here is in line 1 you init the helper with you scene dimensions. You also pass along the scene for reference and the moveableNode you created at step 2. Line 2 is where you set up the content size of the scrollView, in this case its twice as long as the screen height.

Step 4: - Add you labels or nodes etc and position them.

```swift
label1.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - self.frame.size.height)
moveableNode.addChild(label1)
```

In this example the label would be on the 2nd page in the scrollView. This is where you have to play around with you labels and positioning.

I recommend that if you have a lot pages in the scroll view and a lot of labels to do the following. Create a empty SKSpriteNode for each page in the scroll view and make each of them the size of the screen. Call them like page1Node, page2Node etc. You than add all the labels you want for example on the second page to page2Node. The benefit here is that you basically can position all your stuff as usual within page2Node and than just position page2Node in the scrollView.

Step 5: Make sure you scene registers for scroll view touch events, as in the buttons or labels added to the scrollView were pressed. So in all the touches methods you need/use you need to make sure that they basically looks like this.

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

I made some class func so if you need to disable your scrollView incase you overlay another menu ontop of the scrollView or if you pressed a button. Again you will probably have to play around here and see how the buttons interact with the scrollView.

```swift
CustomScrollView.enable()
CustomScrollView.disable()
```

- Step 6: Finally do not forget to remove the scroll view from your scene before transitioning to a new one. One of the pains when dealing with UIKit in spritekit.

```swift
scrollView.removeFromSuperView()
```

# Horizontal scrollView

/// set scrollView to first page (UIKit coordinates are different to SpriteKit)
        scrollView.setContentOffset(CGPoint(x: 0 + self.frame.size.width * 2, y: 0), animated: true)
        
        /// sprite (1st page on scrollView)
        let sprite = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 50, height: 50))
        sprite.position = CGPointMake(CGRectGetMidX(self.frame) - self.frame.size.width * 2, CGRectGetMidY(self.frame))
        moveableNode.addChild(sprite)
        
        /// sprite 2 (2nd page on scrollView)
        let sprite2 = SKSpriteNode(color: SKColor.blueColor(), size: CGSize(width: 50, height: 50))
        sprite2.position = CGPointMake(CGRectGetMidX(self.frame) - self.frame.size.width, CGRectGetMidY(self.frame))
        moveableNode.addChild(sprite2)
        
        /// label (last page)
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!"
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        moveableNode.addChild(myLabel)

If you are using the scrollView vertically, as in the example and sample project you dont need to do any flipping and reverse positioning.
For horizontal scrolling it is a bit more tricky.

- In the helper uncomment the 2 lines in the init method that flip the scroll view. Otherwise scrolling is in the opposite direction of your swipe
```swift
let verticalFlip = CGAffineTransformMakeScale(-1,-1)
self.transform = verticalFlip
```

- Still in the helper go to the delegate method at the bottom and switch x and y.
```swift
moveableNode!.position.x = scrollView.contentOffset.x
//moveableNode!.position.y = scrollView.contentOffset.y
```

- Now the biggest pain is that everything is in reverse when positioning stuff. So the scroll view goes from right to left. So the first step is to set up your scrollView for horizontal scrolling
```swift
scrollView.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height) // makes it 3times as wide as screen
```
and than add this line of code right after adding the scrollView to the scene/subview
```swift
scrollView.setContentOffset(CGPoint(x: 0 + self.frame.size.width * 2, y: 0), animated: true)
```
Here you resetting the contenOffSet of the scrollView, so it scrolls from left to right. 
In the example the scrollView is 3times as wide as screen therefore you need to offSet the scrollView by 2 screen widths.

So now when you add stuff to the scrollView, it will be positioned on the last page. So in the sample project the "HelloWorld label" is on the last page (3rd page) of the scrollView.
```swift
myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
```

If you want to add something to the 1st page of the scrollView you need to subtract the scrollView width. For example
```swift
sprite.position = CGPointMake(CGRectGetMidX(self.frame) - (self.frame.size.width * 2), CGRectGetMidY(self.frame))
```

If you want to add something on the 2nd page of the scrollView you need to subtract the scrollView width. For example

```swift
sprite2.position = CGPointMake(CGRectGetMidX(self.frame) - (self.frame.size.width), CGRectGetMidY(self.frame))
moveableNode.addChild(sprite2)
```

TIP:

- To make your life easier with positioning loads of different items you probably want to create empty spriteNodes that are the size your your screen for each scrollView page
```swift
let spritePage1 = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(self.frame.size.width, self.frame.size.height))
spritePage1.position = CGPointMake(CGRectGetMidX(self.frame) - (self.frame.size.width * 2), CGRectGetMidY(self.frame))
moveableNode.addChild(spritePage1)

let spritePage2 = SKSpriteNode(color: SKColor.clearColor(), size: CGSizeMake(self.frame.size.width, self.frame.size.height))
spritePage2.position = CGPointMake(CGRectGetMidX(self.frame) - (self.frame.size.width), CGRectGetMidY(self.frame))
moveableNode.addChild(spritePage2)
```
and now when you add your labels, sprites, buttons etc you add them to these sprites and position them within the sprite. Because the sprites are the size of the screen its as if you position them in your scene. For example to add sprites to page 1 of the scrollView you can now do this.

```swift
let sprite = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 50, height: 50))
sprite.position = CGPointMake(0, 0)
spritePage1.addChild(sprite)

let myLabel = SKLabelNode(fontNamed:"Chalkduster")
myLabel.text = "Hello, World!"
myLabel.fontSize = 45
myLabel.position = CGPointMake(0, 0)
spritePage2.addChild(myLabel)
```

# Release notes

- v1.0

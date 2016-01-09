# Swift-2-SpriteKit-UIScrollView

A simple helper to add a UIScrollView to your SpriteKit scenes

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

If you are using the scrollView vertically, as in the example and sample project you dont need to do any flipping and reverse positioning.
For horizontal scrolling it is a bit more tricky.

a) in the helper uncomment the 2 lines in the init method that flip the scroll view. Otherwise scrolling is in the opposite direction.

b) go to the delegate method at the bottom and switch x and y.

And now the biggest pain is that everything is in reverse when positioning stuff. So the scroll view goes from right to left. So you need to use the scrollView "contentOffset" method to reposition it and basically place all your labels in reverse order from right to left. Using SkNodes again makes this much easier once you understand whats happening.

# Release Notes

v1.0

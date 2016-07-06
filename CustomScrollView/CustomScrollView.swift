
//  Created by Dominik on 9/01/2016.

//    The MIT License (MIT)
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

//    v1.4

import SpriteKit

/// Scroll direction
enum ScrollDirection {
    case vertical // cases start with small letters as I am following swift 3 guidlines 
    case horizontal
}

/// Custom UIScrollView class
class CustomScrollView: UIScrollView {
    
    // MARK: - Static Properties

    /// Touches allowed
    static var disabledTouches = false
    
    /// Scroll view
    private static var scrollView: UIScrollView!
    
    // MARK: - Properties
    
    /// Nodes touched. This will forward touches to node subclasses.
    private var nodesTouched = [AnyObject]()
    
    /// Current scene
    private let currentScene: SKScene
    
    /// Moveable node
    private let moveableNode: SKNode
    
    /// Scroll direction
    private let scrollDirection: ScrollDirection
    
    // MARK: - Init
    init(frame: CGRect, scene: SKScene, moveableNode: SKNode, scrollDirection: ScrollDirection) {
        self.currentScene = scene
        self.moveableNode = moveableNode
        self.scrollDirection = scrollDirection
        super.init(frame: frame)
        
        CustomScrollView.scrollView = self
        self.frame = frame
        delegate = self
        indicatorStyle = .White
        scrollEnabled = true
        userInteractionEnabled = true
        //canCancelContentTouches = false
        //self.minimumZoomScale = 1
        //self.maximumZoomScale = 3
        
        if scrollDirection == .horizontal {
            transform = CGAffineTransformMakeScale(-1,-1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Touches
extension CustomScrollView {
    
    /// Began
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //super.touchesBegan(touches, withEvent: event)
        
        for touch in touches {
            let location = touch.locationInNode(currentScene)
        
            guard !CustomScrollView.disabledTouches else { return }
            
            /// Call touches began in current scene
            currentScene.touchesBegan(touches, withEvent: event)
            
            /// Call touches began in all touched nodes in the current scene
            nodesTouched = currentScene.nodesAtPoint(location)
            for node in nodesTouched {
                node.touchesBegan(touches, withEvent: event)
            }
        }
    }
    
    /// Moved
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //super.touchesMoved(touches, withEvent: event)
        
        for touch in touches {
            let location = touch.locationInNode(currentScene)
        
            guard !CustomScrollView.disabledTouches else { return }
            
            /// Call touches moved in current scene
            currentScene.touchesMoved(touches, withEvent: event)
            
            /// Call touches moved in all touched nodes in the current scene
            nodesTouched = currentScene.nodesAtPoint(location)
            for node in nodesTouched {
                node.touchesMoved(touches, withEvent: event)
            }
        }
    }
    
    /// Ended
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //super.touchesEnded(touches, withEvent: event)
        
        for touch in touches {
            let location = touch.locationInNode(currentScene)
            
            guard !CustomScrollView.disabledTouches else { return }
            
            /// Call touches ended in current scene
            currentScene.touchesEnded(touches, withEvent: event)
            
            /// Call touches ended in all touched nodes in the current scene
            nodesTouched = currentScene.nodesAtPoint(location)
            for node in nodesTouched {
                node.touchesEnded(touches, withEvent: event)
            }
        }
    }

    /// Cancelled
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        //super.touchesCancelled(touches, withEvent: event)
        
        for touch in touches! {
            let location = touch.locationInNode(currentScene)
        
            guard !CustomScrollView.disabledTouches else { return }
            
            /// Call touches cancelled in current scene
            currentScene.touchesCancelled(touches, withEvent: event)
            
            /// Call touches cancelled in all touched nodes in the current scene
            nodesTouched = currentScene.nodesAtPoint(location)
            for node in nodesTouched {
                node.touchesCancelled(touches, withEvent: event)
            }
        }
    }
}

// MARK: - Touch Controls
extension CustomScrollView {
    
    /// Disable
    class func disable() {
        CustomScrollView.scrollView?.userInteractionEnabled = false
        CustomScrollView.disabledTouches = true
    }
    
    /// Enable
    class func enable() {
        CustomScrollView.scrollView?.userInteractionEnabled = true
        CustomScrollView.disabledTouches = false
    }
}

// MARK: - Delegates
extension CustomScrollView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if scrollDirection == .horizontal {
            moveableNode.position.x = scrollView.contentOffset.x
        } else {
            moveableNode.position.y = scrollView.contentOffset.y
        }
    }
}

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

//    v1.4.2

import SpriteKit

/// Scroll direction
enum ScrollDirection {
    case vertical // cases start with small letters as I am following swift 3 guidlines 
    case horizontal
}

/// Custom UIScrollView class
class CustomScrollView: UIScrollView {
    
    // MARK: - Static Properties

    private static var disabledTouches = false
    private static var scrollView: UIScrollView?
    
    // MARK: - Properties
    
    private weak var currentScene: SKScene?
    private let moveableNode: SKNode
    private let scrollDirection: ScrollDirection
    private var nodesTouched = [AnyObject]() /// Nodes touched. This will forward touches to node subclasses.
    
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
        //minimumZoomScale = 1
        //maximumZoomScale = 3
        
        if scrollDirection == .horizontal {
            transform = CGAffineTransformMakeScale(-1,1) // set 2nd number to -1 if you want scroll indicator at top
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
        super.touchesBegan(touches, withEvent: event)
        
        guard let currentScene = currentScene else { return }
        
        for touch in touches {
            let location = touch.locationInNode(currentScene)
        
            guard !CustomScrollView.disabledTouches else { return }
            
            currentScene.touchesBegan(touches, withEvent: event)
            nodesTouched = currentScene.nodesAtPoint(location)
            for node in nodesTouched {
                node.touchesBegan(touches, withEvent: event)
            }
        }
    }
    
    /// Moved
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)
        
        guard let currentScene = currentScene else { return }
        
        for touch in touches {
            let location = touch.locationInNode(currentScene)
        
            guard !CustomScrollView.disabledTouches else { return }
            
            currentScene.touchesMoved(touches, withEvent: event)
            nodesTouched = currentScene.nodesAtPoint(location)
            for node in nodesTouched {
                node.touchesMoved(touches, withEvent: event)
            }
        }
    }
    
    /// Ended
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        
        guard let currentScene = currentScene else { return }
        
        for touch in touches {
            let location = touch.locationInNode(currentScene)
            
            guard !CustomScrollView.disabledTouches else { return }
            
            currentScene.touchesEnded(touches, withEvent: event)
            nodesTouched = currentScene.nodesAtPoint(location)
            for node in nodesTouched {
                node.touchesEnded(touches, withEvent: event)
            }
        }
    }

    /// Cancelled
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        super.touchesCancelled(touches, withEvent: event)
        
        guard let currentScene = currentScene else { return }
        
        for touch in touches! {
            let location = touch.locationInNode(currentScene)
        
            guard !CustomScrollView.disabledTouches else { return }
            
            currentScene.touchesCancelled(touches, withEvent: event)
            nodesTouched = currentScene.nodesAtPoint(location)
            for node in nodesTouched {
                node.touchesCancelled(touches, withEvent: event)
            }
        }
    }
}

// MARK: - Touch Controls

extension CustomScrollView {
    
    class func disable() {
        CustomScrollView.scrollView?.userInteractionEnabled = false
        CustomScrollView.disabledTouches = true
    }
    
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
        
        //print(scrollView.contentOffset)
    }
}
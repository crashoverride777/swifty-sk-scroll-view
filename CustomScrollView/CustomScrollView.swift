
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

//    v1.4.3

import SpriteKit

/// Scroll direction
enum ScrollDirection {
    case vertical
    case horizontal
}

/// Custom UIScrollView class
class CustomScrollView: UIScrollView {
    
    // MARK: - Static Properties

    fileprivate static var disabledTouches = false
    fileprivate static var scrollView: UIScrollView?
    
    // MARK: - Properties
    
    fileprivate weak var currentScene: SKScene?
    fileprivate let moveableNode: SKNode
    fileprivate let scrollDirection: ScrollDirection
    fileprivate var nodesTouched = [AnyObject]() /// Nodes touched. This will forward touches to node subclasses.
    
    // MARK: - Init
    
    init(frame: CGRect, moveableNode: SKNode, scrollDirection: ScrollDirection) {
        self.moveableNode = moveableNode
        self.scrollDirection = scrollDirection
        super.init(frame: frame)
        
        if let scene = moveableNode.scene {
            self.currentScene = scene
        }
        
        CustomScrollView.scrollView = self
        
        self.frame = frame
        delegate = self
        indicatorStyle = .white
        isScrollEnabled = true
        isUserInteractionEnabled = true
        //canCancelContentTouches = false
        //minimumZoomScale = 1
        //maximumZoomScale = 3
        
        if scrollDirection == .horizontal {
            transform = CGAffineTransform(scaleX: -1,y: 1) // set 2nd number to -1 if you want scroll indicator at top
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Touches

extension CustomScrollView {
    
    /// Began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let currentScene = currentScene else { return }
        
        for touch in touches {
            let location = touch.location(in: currentScene)
        
            guard !CustomScrollView.disabledTouches else { return }
            
            currentScene.touchesBegan(touches, with: event)
            nodesTouched = currentScene.nodes(at: location)
            for node in nodesTouched {
                node.touchesBegan(touches, with: event)
            }
        }
    }
    
    /// Moved
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        guard let currentScene = currentScene else { return }
        
        for touch in touches {
            let location = touch.location(in: currentScene)
        
            guard !CustomScrollView.disabledTouches else { return }
            
            currentScene.touchesMoved(touches, with: event)
            nodesTouched = currentScene.nodes(at: location)
            for node in nodesTouched {
                node.touchesMoved(touches, with: event)
            }
        }
    }
    
    /// Ended
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        guard let currentScene = currentScene else { return }
        
        for touch in touches {
            let location = touch.location(in: currentScene)
            
            guard !CustomScrollView.disabledTouches else { return }
            
            currentScene.touchesEnded(touches, with: event)
            nodesTouched = currentScene.nodes(at: location)
            for node in nodesTouched {
                node.touchesEnded(touches, with: event)
            }
        }
    }

    /// Cancelled
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        guard let currentScene = currentScene else { return }
        
        for touch in touches {
            let location = touch.location(in: currentScene)
        
            guard !CustomScrollView.disabledTouches else { return }
            
            currentScene.touchesCancelled(touches, with: event)
            nodesTouched = currentScene.nodes(at: location)
            for node in nodesTouched {
                node.touchesCancelled(touches, with: event)
            }
        }
    }
}

// MARK: - Touch Controls

extension CustomScrollView {
    
    class func disable() {
        CustomScrollView.scrollView?.isUserInteractionEnabled = false
        CustomScrollView.disabledTouches = true
    }
    
    class func enable() {
        CustomScrollView.scrollView?.isUserInteractionEnabled = true
        CustomScrollView.disabledTouches = false
    }
}

// MARK: - Delegates

extension CustomScrollView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollDirection == .horizontal {
            moveableNode.position.x = scrollView.contentOffset.x
        } else {
            moveableNode.position.y = scrollView.contentOffset.y
        }
        
        //print(scrollView.contentOffset)
    }
}

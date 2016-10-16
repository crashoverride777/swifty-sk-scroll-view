
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

//    v2.0

import SpriteKit

/**
 SwiftySKScrollView
 
 A custom subclass of UIScrollView to add to your SpriteKit scenes.
 */
public class SwiftySKScrollView: UIScrollView {
    
    // MARK: - Static Properties

    /// Disable status
    public static var isDisabled = false {
        didSet {
            SwiftySKScrollView.scrollView?.isUserInteractionEnabled = !isDisabled
        }
    }
    
    /// Scroll view reference
    fileprivate static var scrollView: UIScrollView?
    
    // MARK: - Properties
    
    /// Scroll direction
    public enum Direction {
        case vertical, horizontal
    }
    
    /// Moveable node
    fileprivate let moveableNode: SKNode
    
    /// Scroll direction
    fileprivate let direction: Direction
    
    /// Nodes touched. This will forward touches to node subclasses.
    private var nodesTouched = [AnyObject]()
    
    /// Current scene reference
    private weak var currentScene: SKScene?
    
    // MARK: - Init
    
    /// Init
    ///
    /// - parameter frame: The frame of the scroll view
    /// - parameter moveableNode: The moveable node that will contain all the sprites to be moved by the scrollview
    /// - parameter scrollDirection: The scroll direction of the scrollView.
    public init(frame: CGRect, moveableNode: SKNode, direction: Direction) {
        self.moveableNode = moveableNode
        self.direction = direction
        super.init(frame: frame)
        
        if let scene = moveableNode.scene {
            self.currentScene = scene
        }
        
        SwiftySKScrollView.scrollView = self
        SwiftySKScrollView.isDisabled = false // if a new instance is created reset to false, incase user forgot
        
        self.frame = frame
        delegate = self
        indicatorStyle = .white
        isScrollEnabled = true
        isUserInteractionEnabled = true
        //canCancelContentTouches = false
        //minimumZoomScale = 1
        //maximumZoomScale = 3
        
        guard direction == .horizontal else { return }
        transform = CGAffineTransform(scaleX: -1,y: 1) // set 2nd number to -1 if you want scroll indicator at top
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Touches

    /// Touches began
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let currentScene = currentScene else { return }
        
        for touch in touches {
            let location = touch.location(in: currentScene)
        
            guard !SwiftySKScrollView.isDisabled else { return }
            
            currentScene.touchesBegan(touches, with: event)
            nodesTouched = currentScene.nodes(at: location)
            for node in nodesTouched {
                node.touchesBegan(touches, with: event)
            }
        }
    }
    
    /// Touches moved
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        guard let currentScene = currentScene else { return }
        
        for touch in touches {
            let location = touch.location(in: currentScene)
        
            guard !SwiftySKScrollView.isDisabled else { return }
            
            currentScene.touchesMoved(touches, with: event)
            nodesTouched = currentScene.nodes(at: location)
            for node in nodesTouched {
                node.touchesMoved(touches, with: event)
            }
        }
    }
    
    /// Touches ended
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        guard let currentScene = currentScene else { return }
        
        for touch in touches {
            let location = touch.location(in: currentScene)
            
            guard !SwiftySKScrollView.isDisabled else { return }
            
            currentScene.touchesEnded(touches, with: event)
            nodesTouched = currentScene.nodes(at: location)
            for node in nodesTouched {
                node.touchesEnded(touches, with: event)
            }
        }
    }

    /// Touches cancelled
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        guard let currentScene = currentScene else { return }
        
        for touch in touches {
            let location = touch.location(in: currentScene)
        
            guard !SwiftySKScrollView.isDisabled else { return }
            
            currentScene.touchesCancelled(touches, with: event)
            nodesTouched = currentScene.nodes(at: location)
            for node in nodesTouched {
                node.touchesCancelled(touches, with: event)
            }
        }
    }
}

// MARK: - Delegates

/// UIScrollViewDelegate
extension SwiftySKScrollView: UIScrollViewDelegate {
    
    /// Scroll view did scroll
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if direction == .horizontal {
            moveableNode.position.x = scrollView.contentOffset.x
        } else {
            moveableNode.position.y = scrollView.contentOffset.y
        }
    }
}

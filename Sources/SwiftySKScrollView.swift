//    The MIT License (MIT)
//
//    Copyright (c) 2016-2022 Dominik Ringler
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

import UIKit
import SpriteKit

/**
 SwiftySKScrollView
 
 A custom subclass of UIScrollView to add to your SpriteKit scenes.
 */
public class SwiftySKScrollView: UIScrollView {
    
    // MARK: - Types
    
    public enum ScrollDirection {
        case vertical
        case horizontal
    }
    
    // MARK: - Properties
    
    public var isDisabled = false {
        didSet {
            isUserInteractionEnabled = !isDisabled
        }
    }
    
    private unowned let moveableNode: SKNode
    private let direction: ScrollDirection
    private var touchedNodes = [AnyObject]()
    
    // MARK: - Initialization
    
    /// Initialization
    ///
    /// - parameter frame: The frame of the UIScrollView.
    /// - parameter moveableNode: The moveable node that will contain all the sprites to be scrolled by the UIScrollView.
    /// - parameter direction: The scroll direction of the UIScrollView.
    public init(frame: CGRect, moveableNode: SKNode, direction: ScrollDirection) {
        self.moveableNode = moveableNode
        self.direction = direction
        super.init(frame: frame)

        delegate = self
        indicatorStyle = .white
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
        switch direction {
        case .vertical:
            break
        case .horizontal:
            transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Touches
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isDisabled else { return }
        super.touchesBegan(touches, with: event)
        
        guard let scene = moveableNode.scene else { return }
        
        for touch in touches {
            let location = touch.location(in: scene)
        
            scene.touchesBegan(touches, with: event)
            touchedNodes = scene.nodes(at: location)
            for node in touchedNodes {
                node.touchesBegan(touches, with: event)
            }
        }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isDisabled else { return }
        super.touchesMoved(touches, with: event)
        
        guard let scene = moveableNode.scene else { return }
        
        for touch in touches {
            let location = touch.location(in: scene)
        
            scene.touchesMoved(touches, with: event)
            touchedNodes = scene.nodes(at: location)
            for node in touchedNodes {
                node.touchesMoved(touches, with: event)
            }
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isDisabled else { return }
        super.touchesEnded(touches, with: event)
        
        guard let scene = moveableNode.scene else { return }
        
        for touch in touches {
            let location = touch.location(in: scene)
            
            scene.touchesEnded(touches, with: event)
            touchedNodes = scene.nodes(at: location)
            for node in touchedNodes {
                node.touchesEnded(touches, with: event)
            }
        }
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isDisabled else { return }
        super.touchesCancelled(touches, with: event)
        
        guard let scene = moveableNode.scene else { return }
        
        for touch in touches {
            let location = touch.location(in: scene)
        
            scene.touchesCancelled(touches, with: event)
            touchedNodes = scene.nodes(at: location)
            for node in touchedNodes {
                node.touchesCancelled(touches, with: event)
            }
        }
    }
}

// MARK: - UIScrollViewDelegate

extension SwiftySKScrollView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if direction == .horizontal {
            moveableNode.position.x = scrollView.contentOffset.x
        } else {
            moveableNode.position.y = scrollView.contentOffset.y
        }
    }
}

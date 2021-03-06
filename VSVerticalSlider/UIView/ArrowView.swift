//
//  PoleImageView.swift
//  VSVerticalSlider
//
//  Created by Vincent Smithers on 10/21/17.
//  Copyright © 2017 Vincent Smithers. All rights reserved.
//

import UIKit

public enum ArrowDirection {
    case up
    case down
}

public class ArrowView: UIView {
    
    public var propertyAnimator: UIViewPropertyAnimator!
    public var direction: ArrowDirection!
    public var color: UIColor!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(frame: CGRect, direction: ArrowDirection, color: UIColor) {
        self.init(frame: frame)
        self.direction = direction
        layer.borderWidth = 1.0
        backgroundColor = UIColor.getCompliment(color: color)!
        setAnimation()
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        let topPoint = direction == .up ? CGPoint(x: frame.width / 2, y: 12) : CGPoint(x: frame.width / 2, y: frame.height - 12)
        let bottomLeftPoint = direction == .up ? CGPoint(x: 10, y: frame.height - 10) : CGPoint(x: 10, y: 10)
        let bottomRightPoint = direction == .up ? CGPoint(x: frame.width - 10, y: frame.height - 10) : CGPoint(x: frame.width - 10, y:  10)
        let path = UIBezierPath()
        path.lineWidth = 3.0
        path.move(to: topPoint)
        path.addLine(to: bottomLeftPoint)
        path.addLine(to: bottomRightPoint)
        path.close()
        
        UIColor.white.setStroke()
        UIColor(red: 0, green: 0, blue: 0, alpha: 0.33).setFill()
        path.stroke()
        path.fill()
    }
}

extension ArrowView {
    
    public func setAnimation() {
        let offsetY: CGFloat = direction == .up ? 8 : -8
        propertyAnimator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
            self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.center.y -= offsetY
            self.layer.opacity = 0.3
        }
        
        propertyAnimator.addCompletion { _ in
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.center.y += offsetY
            self.layer.opacity = 1
            self.setAnimation()
        }
    }
}




//
//  UpvoteControl.swift
//  Raúl Riera
//
//  Created by Raúl Riera on 26/04/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

@IBDesignable
public class UpvoteControl: UIControl {
    /**
    The current count value
    
    The default value for this property is 0, don't assign to this value more than once. It will increment and decrement internally depending of the `selected` property
    */
    @IBInspectable public var count: Int = 0 {
        didSet {
            updateCountLabel()
        }
    }
    
    @IBInspectable public var borderRadius: CGFloat = 0 {
        didSet {
            updateLayer()
        }
    }
    @IBInspectable public var shadow: Bool = false {
        didSet {
            updateLayer()
        }
    }
    
    @IBInspectable public var vertical: Bool = true {
        didSet {
            updateCountLabel()
        }
    }
    
    /**
    The font of the text
    
    Until Xcode supports @IBInspectable for UIFonts, this is the only way to change the font of the inner label
    */
    @IBInspectable public var font: UIFont? {
        didSet {
            countLabel.font = font
        }
    }
    
    /**
    The color of text
    
    The default value for this property is a black color (set through the blackColor class method of UIColor).
    */
    @IBInspectable public var textColor: UIColor = UIColor.blackColor() {
        didSet {
            countLabel.textColor = textColor
        }
    }
    
    private var countLabel: UILabel = UILabel()

    override public var selected: Bool {
        didSet {
            if selected {
                countLabel.textColor = tintColor
            } else {
                countLabel.textColor = textColor
            }
        }
    }
    
    // MARK: Overrides
    
    public override func endTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) {
        super.endTrackingWithTouch(touch, withEvent:event)
        
        if touch.tapCount > 0 {
            if selected {
                count -= 1
            } else {
                count += 1
            }
            
            selected = !selected
            super.sendActionsForControlEvents(.ValueChanged)
        }
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    private func configureView() {
        updateLayer()
    
        countLabel = UILabel(frame: bounds)
        countLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        countLabel.numberOfLines = 0
        countLabel.lineBreakMode = .ByWordWrapping
        countLabel.textAlignment = .Center
        countLabel.userInteractionEnabled = false

        countLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(countLabel)
        
        addConstraint(NSLayoutConstraint(item: countLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: countLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
        
        countLabel.setNeedsDisplay()
    }
    
    private func updateLayer() {
        layer.cornerRadius = borderRadius
        
        if shadow {
            layer.shadowColor = UIColor.darkGrayColor().CGColor
            layer.shadowRadius = 0.5
            layer.shadowOffset = CGSize(width: 0, height: 1)
            layer.shadowOpacity = 0.5
        }
    }
    
    private func updateCountLabel() {
        if vertical {
            countLabel.text = "▲\n\(count)"
        } else {
            countLabel.text = "▲ \(count)"
        }
    }
}

//
//  TableViewCell.swift
//  SampleCode
//
//  Created by Takeshi Oogami on 2015/09/18.
//  Copyright © 2015年 jp.bigod. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var centerYConstraint:NSLayoutConstraint!
    @IBOutlet weak var arrowView: ArrowView!
    @IBOutlet weak var heartButton: HeartButton!
    @IBOutlet weak var bgImageView: UIImageView!
    var buttonTapped : (() -> Void)?
    
    var rateAlpha:(rate:CGFloat, alpha:CGFloat) = (0.0, 0.0) {
        didSet {
            kernWithLabel(titleLabel, rate: rateAlpha.rate, alpha:rateAlpha.alpha)
            kernWithLabel(subTitleLabel, rate: rateAlpha.rate, alpha:rateAlpha.alpha)
            arrowView.value = rateAlpha.rate
            heartButton.value = rateAlpha.rate
        }
    }

    private func kernWithLabel(label:UILabel, rate:CGFloat, alpha:CGFloat) {
        var attr = label.attributedText!.attributesAtIndex(0, effectiveRange: nil)
        attr[NSKernAttributeName] = (rate * 10.0)
        label.attributedText = NSAttributedString(string: label.attributedText!.string, attributes: attr)
        label.alpha = alpha
    }
    
    @IBAction func pressButton(sender: HeartButton) {
        sender.isFavorite = !sender.isFavorite
        sender.enabled = false
        
        UIView.animateKeyframesWithDuration(0.25, delay: 0.0, options: .CalculationModeLinear, animations: { () -> Void in
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.5, animations: { () -> Void in
                sender.transform = CGAffineTransformMakeScale(1.5, 1.5)
            })
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.5, animations: { () -> Void in
                sender.transform = CGAffineTransformMakeScale(1.0, 1.0)
            })
            }) { (finished) -> Void in
                sender.enabled = true
                self.buttonTapped?()
        }
    }
}

class ArrowView: UIView {
    var value:CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    override func drawRect(rect: CGRect) {
        SampleCodeStyleKit.drawArrow(value)
    }
}

class HeartButton:UIButton {
    var isFavorite:Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    var value:CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    override func drawRect(rect: CGRect) {
        SampleCodeStyleKit.drawHeart(value, isFavorite: isFavorite)
    }
}
//
//  TableView.swift
//  SampleCode
//
//  Created by Takeshi Oogami on 2015/09/18.
//  Copyright © 2015年 jp.bigod. All rights reserved.
//

import UIKit

class TableView: UITableView {
    
    let threshold:CGFloat = 64.0
    var tableBottom:CGFloat {
        return self.frame.size.height - 49.0
    }
    
    func typographicLabels() {
        for cell in visibleCells as! [TableViewCell] {
            let indexPath = self.indexPathForCell(cell)
            let rectInTableView = self.rectForRowAtIndexPath(indexPath!)
            let rect = self.convertRect(rectInTableView, toView: self.superview)
            let midY = rect.size.height * 0.5
            let verticalCenter = (rect.origin.y + midY)
            let upper = midY
            let lower = (tableBottom - midY)
            
            var rate:CGFloat     = 0.0
            var alpha:CGFloat    = 1.0
            var constant:CGFloat = 0.0
            
            if verticalCenter < upper {
                let centerY =  (rect.origin.y + rect.size.height) * 0.5
                
                constant = centerY - upper
                if constant < -threshold {
                    rate = 1.0 - (centerY / -constant)
                    alpha = centerY / -constant
                    constant = -threshold
                }
            } else if verticalCenter > lower {
                let centerY =  (tableBottom - rect.origin.y) * 0.5 + rect.origin.y
                
                constant = centerY - lower
                if constant > threshold {
                    let diff = -(centerY - lower - midY)
                    rate = 1.0 - (diff / constant)
                    alpha = diff / constant
                    constant = threshold
                }
            }
            cell.centerYConstraint.constant = -constant
            cell.rateAlpha = (rate, alpha)
        }
    }
}

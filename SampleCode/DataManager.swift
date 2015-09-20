//
//  DataManager.swift
//  SampleCode
//
//  Created by Takeshi Oogami on 2015/09/18.
//  Copyright © 2015年 jp.bigod. All rights reserved.
//

import UIKit

class DataManager {
    private var items = [Item]()
    private let cnt = 20
    
    init() {
        for i in 0..<cnt {
            let num = NSString(format: "%03d", i)
            let image = UIImage(named: "photo\(i % 5)")!
            items.append(Item(title: "Item title - \(num)", subTitle: "Item subtitle - \(num)", image:image))
        }
    }
    
    func getItems() -> [Item] {
        return items
    }
    func getItem(index:Int) -> Item? {
        return items[index]
    }
}
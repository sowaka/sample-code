//
//  Item.swift
//  SampleCode
//
//  Created by Takeshi Oogami on 2015/09/18.
//  Copyright © 2015年 jp.bigod. All rights reserved.
//

import UIKit

class Item {
    let title:String
    let subTitle:String
    let image:UIImage
    var isFavorite:Bool = false
    
    init(title:String, subTitle:String, image:UIImage) {
        self.title = title
        self.subTitle = subTitle
        self.image = image
    }
}
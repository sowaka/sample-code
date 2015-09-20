//
//  LibraryAPI.swift
//  SampleCode
//
//  Created by Takeshi Oogami on 2015/09/18.
//  Copyright © 2015年 jp.bigod. All rights reserved.
//

import Foundation

class LibraryAPI {
    static let sharedInstance = LibraryAPI()
    private let dataManager: DataManager

    init() {
        dataManager = DataManager()
    }
    
    func getItems() -> [Item] {
        return dataManager.getItems()
    }
    
    func getItem(index:Int) -> Item? {
        return dataManager.getItem(index)
    }
}
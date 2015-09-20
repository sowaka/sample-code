//
//  InfoViewController.swift
//  SampleCode
//
//  Created by Takeshi Oogami on 2015/09/18.
//  Copyright © 2015年 jp.bigod. All rights reserved.
//

import UIKit

protocol InfoViewControllerDelegate : NSObjectProtocol {
    func didPressClose(controller:InfoViewController) -> Void
}

class InfoViewController: UITableViewController {
    var delegate:InfoViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    @IBAction func pressClose(sender: UIBarButtonItem) {
        delegate?.didPressClose(self)
    }
}

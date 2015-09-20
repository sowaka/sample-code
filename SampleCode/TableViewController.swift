//
//  TableViewController.swift
//  SampleCode
//
//  Created by Takeshi Oogami on 2015/09/18.
//  Copyright © 2015年 jp.bigod. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func configureCell(cell:TableViewCell, indexPath:NSIndexPath) {
        guard let item = LibraryAPI.sharedInstance.getItem(indexPath.row) else {
            return
        }
        cell.titleLabel.text = item.title
        cell.subTitleLabel.text = item.subTitle
        cell.bgImageView.image = item.image
        cell.heartButton.isFavorite = item.isFavorite
        cell.buttonTapped = {
            item.isFavorite = !item.isFavorite
        }
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LibraryAPI.sharedInstance.getItems().count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell

        configureCell(cell, indexPath: indexPath)

        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    // MARK: - UIScrollViewDelegate
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        (self.tableView as! TableView).typographicLabels()
    }
    
    // MARK: - IBAction
    @IBAction func pressInfo(sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Info", bundle: NSBundle.mainBundle())
        let nc:UINavigationController! = sb.instantiateInitialViewController() as? UINavigationController
        nc.modalPresentationStyle = .Custom
        nc.transitioningDelegate = self
        let vc = nc.topViewController as! InfoViewController
        vc.delegate = self
        
        self.presentViewController(nc, animated: true, completion:nil)
    }
}

extension TableViewController : InfoViewControllerDelegate {
    func didPressClose(controller: InfoViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}
extension TableViewController : UIViewControllerTransitioningDelegate {
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return CustomPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomAnimatedTransitioning(isPresent: true)
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomAnimatedTransitioning(isPresent: false)
    }
}

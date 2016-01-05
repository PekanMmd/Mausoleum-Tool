//
//  itemTableViewController.swift
//  Mausoleum Tool
//
//  Created by The Steez on 03/11/2014.
//  Copyright (c) 2014 Steezy. All rights reserved.
//

import UIKit

class XGItemPopover: XGPopover {
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return kNumberOfItems
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = dequeueCell()
		
		cell.title = XGItems.Item(indexPath.row).name.string
		cell.background = UIImage(named: "Item Cell")!
		
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		delegate.selectedItem = XGItems.Item(indexPath.row) as Any
		delegate.popoverDidDismiss()
	}

}

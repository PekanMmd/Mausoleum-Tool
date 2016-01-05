//
//  levelTableViewController.swift
//  Mausoleum Tool
//
//  Created by The Steez on 03/11/2014.
//  Copyright (c) 2014 Steezy. All rights reserved.
//

import UIKit

class XGLevelPopover: XGPopover {

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 101
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = dequeueCell()
		
		cell.title = "Level " + String(indexPath.row)
		cell.background = UIImage(named: "Item Cell")!
		
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		delegate.selectedItem = indexPath.row as Any
		delegate.popoverDidDismiss()
	}

}









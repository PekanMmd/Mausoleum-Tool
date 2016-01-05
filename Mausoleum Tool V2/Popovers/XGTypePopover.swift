//
//  moveTypeTableViewController.swift
//  Mausoleum Stats Tool
//
//  Created by The Steez on 12/01/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGTypePopover: XGPopover {
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return kNumberOfTypes
	}
	
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = dequeueCell()
		
		let type = XGMoveTypes(rawValue: indexPath.row) ?? .Normal
		
		cell.title = type.name
		cell.background = type.image
		cell.textLabel?.textAlignment = .Center
		
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		delegate.selectedItem = XGMoveTypes(rawValue: indexPath.row) ?? XGMoveTypes.Normal as Any
		delegate.popoverDidDismiss()
	}
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 100
	}
	
}




















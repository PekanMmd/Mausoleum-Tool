//
//  natureTableViewController.swift
//  Mausoleum Tool
//
//  Created by The Steez on 25/01/2015.
//  Copyright (c) 2015 Steezy. All rights reserved.
//

import UIKit

let kNumberOfNatures = 25

class XGNaturePopover: XGPopover {
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return kNumberOfNatures
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = dequeueCell()
		
		let nature = XGNatures(rawValue: indexPath.row) ?? .Hardy
		
		cell.title = nature.string
		
		cell.background = UIImage(named: "Item Cell")!
		
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		delegate.selectedItem = XGNatures(rawValue: indexPath.row) ?? XGNatures.Hardy as Any
		delegate.popoverDidDismiss()
	}
	
}










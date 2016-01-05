//
//  XGTrainerClassPickerPopover.swift
//  XG Tool
//
//  Created by The Steez on 14/07/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGTrainerClassPickerPopover: XGPopover {

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return kNumberOfTrainerClasses
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = dequeueCell()
		
		let tc = XGTrainerClasses(rawValue: indexPath.row) ?? XGTrainerClasses.None1
		
		cell.title = tc.name.string
		cell.background = XGResources.PNG("Item Cell").image
		cell.textLabel?.textAlignment = .Center
		
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		delegate.selectedItem = XGTrainerClasses(rawValue: indexPath.row) ?? XGTrainerClasses.None1 as Any
		delegate.popoverDidDismiss()
	}
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 75
	}

}

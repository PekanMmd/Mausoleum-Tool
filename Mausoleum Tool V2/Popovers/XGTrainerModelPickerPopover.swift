//
//  XGTrainerModelPickerPopover.swift
//  XG Tool
//
//  Created by The Steez on 14/07/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGTrainerModelPickerPopover: XGPopover {

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return kNumberOfTrainerModels
	}
	
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = dequeueCell()
		
		let tm = XGTrainerModels(rawValue: indexPath.row) ?? XGTrainerModels.Wes
		
		cell.picture = tm.image
		cell.background = XGResources.PNG("Item Cell").image
		cell.textLabel?.textAlignment = .Center
		
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		delegate.selectedItem = XGTrainerModels(rawValue: indexPath.row) ?? XGTrainerModels.Wes as Any
		delegate.popoverDidDismiss()
	}
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 100
	}

}










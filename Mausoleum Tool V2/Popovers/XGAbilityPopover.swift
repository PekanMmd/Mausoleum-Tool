//
//  itemTableViewController.swift
//  Mausoleum Tool
//
//  Created by The Steez on 03/11/2014.
//  Copyright (c) 2014 Steezy. All rights reserved.
//

import UIKit

class XGAbilityPopover: XGPopover {
	
	var abilities = [XGAbilities]()
	
	override init() {
		super.init()
		
		for var i = 0; i < kNumberOfAbilities + 1; i++ {
			self.abilities.append( .Ability(i) )
		}
		
//		abilities.sort{ $0.1 < $1.1 }
	}

	required init!(coder aDecoder: NSCoder) {
	    super.init(coder: aDecoder)
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return kNumberOfAbilities + 1
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = dequeueCell()
		
		cell.title = abilities[indexPath.row].name.string
		cell.background = UIImage(named: "Item Cell")!
		
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		delegate.selectedItem = abilities[indexPath.row] as Any
		delegate.popoverDidDismiss()
	}
	

}

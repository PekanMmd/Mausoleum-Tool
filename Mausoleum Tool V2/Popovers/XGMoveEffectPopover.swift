//
//  MoveEffectTableViewController.swift
//  Mausoleum Move Tool
//
//  Created by The Steez on 28/12/2014.
//  Copyright (c) 2014 Ovation International. All rights reserved.
//

import UIKit

class XGMoveEffectPopover: XGPopover {

	var effectList = [String]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		effectList = XGFiles.NameAndFolder("Move Effects.json", .JSON).json as! [String]
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return effectList.count
	}
	
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = dequeueCell()
		
		cell.title = effectList[indexPath.row]
		cell.background = UIImage(named: "Item Cell")!
		
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		delegate.selectedItem = indexPath.row as Any
		delegate.popoverDidDismiss()
	}
	
}

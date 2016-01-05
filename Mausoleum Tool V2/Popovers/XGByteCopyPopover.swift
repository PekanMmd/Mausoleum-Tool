//
//  XGByteCopyPopover.swift
//  XG Tool
//
//  Created by The Steez on 24/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGByteCopyPopover: XGPopover {
	
	var byteCopier = XGByteCopier(copyFile: .NameAndFolder("",.Documents), copyOffset: 0, length: 0, targetFile: .NameAndFolder("",.Documents), targetOffset: 0)
	
	init(copier: XGByteCopier) {
		super.init()
		
		self.byteCopier = copier
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	required init!(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return byteCopier.bytes.count + 2
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = dequeueCell()
		
		let index = indexPath.row - 2
		
		if indexPath.row == 0 {
			cell.title = "Save"
		} else if indexPath.row == 1 {
			cell.title = "All"
		} else {
			cell.title =  String(format: "byte 0x%x : 0x%x (%d)", (index), byteCopier.bytes[index], byteCopier.bytes[index])
		}
		
		cell.background = UIImage(named: "Item Cell")!
		
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		if indexPath.row == 0 {
			self.byteCopier.save()
			self.delegate.popoverDidDismiss()
		} else if indexPath.row == 1 {
			self.byteCopier.copyAll()
		} else {
			byteCopier.copyByte(indexPath.row - 2)
		}
	}
}


































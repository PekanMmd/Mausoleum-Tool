//
//  XGStringCopierPopover.swift
//  XG Tool
//
//  Created by The Steez on 29/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGStringCopierPopover: XGPopover {

	var strings = [XGUnicodeCharacters]()
	
	required init!(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		// Custom initialization
	}
	
	override init() {
		super.init()
		
		var ch = XGSpecialCharacters.NewLine
		strings.append(ch.unicode)
		
		ch = .ClearWindow
		strings.append(ch.unicode)
		
		ch = .DialogueEnd
		strings.append(ch.unicode)
		
		ch = .Pause
		strings.append(ch.unicode)
		
		ch = .Player13
		strings.append(ch.unicode)
		
		ch = .PlayerInField
		strings.append(ch.unicode)
		
		ch = .SetSpeaker
		strings.append(ch.unicode)
		
		ch = .Speaker
		strings.append(ch.unicode)
		
		for var i = 0; i < kNumberOfPredefinedFontColours; i++ {
			let ft = XGFontColours(rawValue: i)!
			strings.append(ft.unicode)
		}
		
		for var i = 0; i < kNumberOfSpecifiedFontColours; i++ {
			let ft = XGRGBAFontColours(rawValue: i)!
			strings.append(ft.unicode)
		}
	
		tableView.reloadData()
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return strings.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = dequeueCell()
		
		cell.title = strings[indexPath.row].name
		cell.background = UIImage(named: "Item Cell")!
		
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		XGString(string: strings[indexPath.row].string, file: nil, sid: nil).copyString()
		delegate.popoverDidDismiss()
	}

}
















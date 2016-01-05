//
//  XGPopoverButton.swift
//  XG Tool
//
//  Created by The Steez on 05/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGPopoverButton: XGButton {
	
	var popover = UIPopoverController(contentViewController: UIViewController())
	
	init(title: String, colour: UIColor, textColour: UIColor, popover: XGPopover, viewController: XGViewController) {
		super.init(title: title, colour: colour, textColour: textColour, action: {})
		self.action = { viewController.openPopover(self) }
		
		let popoverView = popover
		popoverView.delegate = viewController
		
		self.popover = UIPopoverController(contentViewController: popoverView)
		self.popover.setPopoverContentSize(CGSizeMake(350, 600), animated: false)
		
	}
	
	override init() {
		super.init()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	func showPopover() {
		self.popover.presentPopoverFromRect(self.frame, inView: self.superview!, permittedArrowDirections: .Any, animated: true)
	}
	
}













//
//  XGPopoverField.swift
//  XG Tool
//
//  Created by The Steez on 23/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGPopoverField: UIView {
	
	var title = UILabel()
	var field = XGPopoverButton()
	
	var text : String {
		get {
			return self.field.titleLabel?.text ?? ""
		}
		
		set {
			self.field.titleLabel?.text = newValue
		}
	}
	
	init() {
		super.init(frame: CGRectZero)
	}

	init(title: String, colour: UIColor, textColour: UIColor, height: CGFloat, width: CGFloat, popover: XGPopover, viewController: XGViewController) {
		super.init(frame: CGRectZero)
		
		self.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundColor = UIColor.clearColor()
		self.field = XGPopoverButton(title: title, colour: colour, textColour: textColour, popover: popover, viewController: viewController)
		
		self.title.textColor = UIColor.blackColor()
		self.title.textAlignment = .Center
		self.title.adjustsFontSizeToFitWidth = true
		self.title.translatesAutoresizingMaskIntoConstraints = false
		self.title.text = title
		
		self.addSubview(field)
		self.addSubview(self.title)
		let views = ["f" : field, "t" : self.title]
		
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[t(30)][f]|", options: [.AlignAllLeft, .AlignAllRight], metrics: nil, views: views))
		
		let metrics = ["w" : width, "h" : height]
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[t(w)]|", options: [], metrics: metrics, views: views))
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[f(h)]", options: [], metrics: metrics, views: views))
		
	}

	required init?(coder aDecoder: NSCoder) {
	    super.init(coder: aDecoder)
	}

}









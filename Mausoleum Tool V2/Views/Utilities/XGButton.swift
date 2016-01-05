//
//  XGButton.swift
//  XG Tool
//
//  Created by The Steez on 12/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGButton: UIButton {
	
	var textLabel = UILabel()
	
	override var titleLabel : UILabel? {
		get {
			return textLabel
		}
	}
	
	var action : (() -> Void)!

	init() {
		super.init(frame: CGRectZero)
	}
	
	required init?(coder aDecoder: NSCoder) {
	    super.init(coder: aDecoder)
	}
	
	init(title: String, colour: UIColor, textColour: UIColor, action: (() -> Void)) {
		super.init(frame: CGRectZero)
		
		self.translatesAutoresizingMaskIntoConstraints = false
		
		self.titleLabel?.textAlignment = .Center
		self.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(titleLabel!)
		let view = ["tl" : titleLabel!]
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(2)-[tl]-(2)-|", options: [], metrics: nil, views: view))
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(2)-[tl]-(2)-|", options: [], metrics: nil, views: view))
		
		self.clipsToBounds = false
		self.layer.shadowOpacity = 0.9
		self.layer.shadowOffset = CGSizeMake(5, 5)
		self.layer.shadowColor = UIColor.blackColor().CGColor
		self.layer.shadowRadius = 5
		
		self.layer.cornerRadius = 10
		
		self.titleLabel?.text = title
		self.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
		self.titleLabel?.adjustsFontSizeToFitWidth = true
		
		self.action = action
		self.addTarget(self, action: "tapped", forControlEvents: .TouchUpInside)
		self.backgroundColor = colour
		self.titleLabel?.textColor = textColour
		
	}
	
	func tapped() {
		self.action()
	}

}
















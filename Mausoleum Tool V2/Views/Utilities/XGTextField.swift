//
//  XGTextField.swift
//  XG Tool
//
//  Created by The Steez on 22/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGTextField: UIView, UITextFieldDelegate {
	
	var title = UILabel()
	var field = UITextField()
	
	var action : ( () -> Void  )!
	
	var text : String {
		get {
			return self.field.text!
		}
		
		set {
			self.field.text = newValue
		}
	}
	
	init() {
		super.init(frame: CGRectZero)
		
		self.backgroundColor = UIColor.clearColor()
		self.translatesAutoresizingMaskIntoConstraints = false
		
		self.field.clipsToBounds = false
		self.field.layer.shadowOpacity = 0.9
		self.field.layer.shadowOffset = CGSizeMake(5, 5)
		self.field.layer.shadowColor = UIColor.blackColor().CGColor
		self.field.layer.shadowRadius = 5
		
		self.title.textColor = UIColor.blackColor()
		self.title.textAlignment = .Center
		self.title.adjustsFontSizeToFitWidth = true
		self.title.translatesAutoresizingMaskIntoConstraints = false
		
		self.field.backgroundColor = UIColor.blackColor()
		self.field.textColor = UIColor.orangeColor()
		self.field.delegate = self
		self.field.adjustsFontSizeToFitWidth = true
		self.field.textAlignment = .Center
		self.field.layer.cornerRadius = 10
		self.field.translatesAutoresizingMaskIntoConstraints = false
		
		self.title.text = "Text"
		self.field.text = "-"
		
		self.addSubview(field)
		self.addSubview(title)
		let views = ["f" : field, "t" : title]
		
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[t(30)][f]|", options: [.AlignAllLeft, .AlignAllRight], metrics: nil, views: views))
		
	}
	
	convenience init(title: String, height: CGFloat, width: CGFloat, action: (() -> Void)) {
		self.init(title: title, text: "", height: height, width: width, action: action)
	}
	
	convenience init(title: String, text: String, height: CGFloat, width: CGFloat, action: (() -> Void)) {
		self.init()
		
		let views = ["t" : self.title, "f" : self.field]
		let metrics = ["w" : width, "h" : height]
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[t(w)]|", options: [], metrics: metrics, views: views))
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[f(h)]", options: [], metrics: metrics, views: views))
		
		self.title.text = title
		self.field.text = text
		self.action = action
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	func textFieldDidEndEditing(textField: UITextField) {
		
		self.action()
		
	}
	
}

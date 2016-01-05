//
//  ISAlertView.swift
//  iSpy
//
//  Created by The Steez on 30/04/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGAlertView: UIView {

	var buttonAction : ((buttonIndex: Int) -> Void)!
	var doneButton = XGButton()
	
	var backView = UIView()
	
	var views   = [String : UIView ]()
	var metrics = [String : CGFloat]()
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	class func show(title title: String!, message: String, doneButtonTitle: String!, otherButtonTitles: [String]!, buttonAction: ((buttonIndex: Int) -> Void)! ) {
		
		let alert = XGAlertView(title: title, message: message, doneButtonTitle: doneButtonTitle, otherButtonTitles: otherButtonTitles, buttonAction: buttonAction)
		alert.show()
	}
	
	convenience init(title: String!, message: String, doneButtonTitle: String!, otherButtonTitles: [String]!, buttonAction: ((buttonIndex: Int) -> Void)! ) {
		self.init()
		
		// alert main
		self.backgroundColor = UIColor.orangeColor()
		self.layer.cornerRadius = 10
		self.layer.borderColor = UIColor.blackColor().CGColor
		self.layer.borderWidth = 2.0
		self.clipsToBounds = true
		self.translatesAutoresizingMaskIntoConstraints = false
		self.clipsToBounds = false
		self.layer.shadowOpacity = 0.9
		self.layer.shadowOffset = CGSizeMake(5, 5)
		self.layer.shadowColor = UIColor.blackColor().CGColor
		self.layer.shadowRadius = 5
		
		let viewWidth = UIScreen.mainScreen().bounds.width
		views["self"] = self
		metrics["viewWidth"] = viewWidth * 0.6
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("[self(viewWidth)]", options: [], metrics: metrics, views: views))
		
		
		
		// background
		self.backView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
		self.backView.translatesAutoresizingMaskIntoConstraints = false
		
		// title
		let titleLabel = UILabel()
		titleLabel.text = title ?? "XG Tool"
		titleLabel.textAlignment = .Center
		titleLabel.font = UIFont(name: "Helvetica", size: 30)
		titleLabel.adjustsFontSizeToFitWidth = true
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.userInteractionEnabled = false
		self.addSubview(titleLabel)
		views["title"] = titleLabel
		
		self.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 0.9, constant: 0))
		self.addConstraint(NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: titleLabel, attribute: .CenterX, multiplier: 1, constant: 0))
		
		// message
		let messageView = UITextView()
		messageView.font = UIFont(name: "Helvetica", size: 20)
		messageView.text = message
		messageView.backgroundColor = UIColor.clearColor()
		messageView.textAlignment = .Center
		messageView.userInteractionEnabled = false
		messageView.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(messageView)
		views["message"] = messageView
		self.addConstraint(NSLayoutConstraint(item: messageView, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 0.9, constant: 0))
		messageView.sizeToFit()
		metrics["messageHeight"] = 50
		
		
		// Buttons
		var buttons = [XGButton]()
		let buttonTitles = otherButtonTitles ?? []
		
		for var i = 0; i <= buttonTitles.count; i++ {
			
			var button = XGButton()
			var buttonIdentifier = ""
			
			if i < buttonTitles.count {
				button = newButton(buttonTitles[i], tag: i)
				buttonIdentifier = "button" + String(i)
				buttons.append(button)
			} else if (i >= buttonTitles.count) && (doneButtonTitle != nil) {
				self.doneButton = newButton(doneButtonTitle, tag: i)
				button = doneButton
				buttonIdentifier = "doneButton"
			}
			
			button.translatesAutoresizingMaskIntoConstraints = false
			
			self.addSubview(button)
			views[buttonIdentifier] = button
			
			self.addConstraint(NSLayoutConstraint(item: button, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 0.3, constant: 0))
			self.addConstraint(NSLayoutConstraint(item: button, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1, constant: 75))
		}
		
		
		// Layout
		
		var formatString = "V:|-(10)-[title(60)]-(20)-[message(messageHeight)]-(30)-"
		
		for var i = 0; i < buttons.count; i++ {
			let buttonName = "button" + String(i)
			formatString = formatString.stringByAppendingString("[")
			formatString = formatString.stringByAppendingString(buttonName)
			formatString = formatString.stringByAppendingString("]-(10)-")
		}
		
		if doneButtonTitle != nil {
			formatString = formatString.stringByAppendingString("[doneButton]-(20)-")
		}
		
		formatString = formatString.stringByAppendingString("|")
		
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(formatString, options: .AlignAllCenterX, metrics: metrics, views: views))
		
		// button action
		self.buttonAction = buttonAction
		
	}
	
	func show() {
		
		let views = ["self" : self, "back" : backView]
		
		let window = UIApplication.sharedApplication().keyWindow
		window?.addSubview(backView)
		window?.addSubview(self)
		window?.addConstraint(NSLayoutConstraint(item: window!, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
		window?.addConstraint(NSLayoutConstraint(item: window!, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
		window?.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[back]|", options: [], metrics: nil, views: views))
		window?.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[back]|", options: [], metrics: nil, views: views))
		
	}
	
	func dismiss() {
		
		UIView.animateWithDuration(0.25, animations: {
			
			self.alpha = 0
			self.backView.alpha = 0
			
		}, completion: { (Bool) -> Void in
			self.removeFromSuperview()
			self.backView.removeFromSuperview()
		})
		
	}

	func buttonTapped(sender: XGButton) {
		if sender == self.doneButton {
			self.dismiss()
			return
		} else {
			if self.buttonAction != nil {
				self.buttonAction(buttonIndex: sender.tag)
			}
			self.dismiss()
		}
	}
	
	func newButton(title: String, tag: Int) -> XGButton {
		
		let button = XGButton()
		button.backgroundColor = UIColor.blueColor()
		button.layer.borderColor = UIColor.whiteColor().CGColor
		button.layer.borderWidth = 2.0
		button.layer.cornerRadius = 10.0
		button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		button.setTitle(title, forState: .Normal)
		button.addTarget(self, action: "buttonTapped:", forControlEvents: .TouchUpInside)
		button.tag = tag
		
		button.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
		button.titleLabel?.adjustsFontSizeToFitWidth = true
		
		button.translatesAutoresizingMaskIntoConstraints = false
		
		return button
	}
	
	
}















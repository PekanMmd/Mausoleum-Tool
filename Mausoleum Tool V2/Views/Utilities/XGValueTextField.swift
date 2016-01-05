//
//  XGTextField.swift
//  XG Tool
//
//  Created by The Steez on 21/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGValueTextField: XGTextField {

	var min : Int!
	var max	: Int!
	
	var value : Int {
		get {
			return Int(self.text) ?? 0
		}
		
		set {
			self.text = String(newValue)
		}
	}
	
	override init() {
		super.init()
	}

	required init?(coder aDecoder: NSCoder) {
	    super.init(coder: aDecoder)
	}
	
	convenience init(title: String, min: Int?, max: Int?, height: CGFloat, width: CGFloat, action: ( () -> Void) ) {
		self.init(title: title, value: (min ?? 0), min: min, max: max, height: height, width: width, action: action )
	}
	
	convenience init(title: String, value: Int, min: Int?, max: Int?, height: CGFloat, width: CGFloat, action: ( () -> Void) ) {
		self.init(title: title, text: String(min ?? 0), height: height, width: width, action: action)
		
		self.field.keyboardType = .NumbersAndPunctuation
		self.min = min
		self.max = max
		self.value = value
		
	}

	override func textFieldDidEndEditing(textField: UITextField) {
		
		var value = Int(field.text!)
		
		if value == nil {
			field.text = "0"
		}
		
		if min != nil {
			if value < min {
				field.text = String(min)
			}
		}
		
		if max != nil {
			if value > max {
				field.text = String(max)
			}
		}
		
		self.action()
	}
	
}























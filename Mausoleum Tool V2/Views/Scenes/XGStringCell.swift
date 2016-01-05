//
//  XGStringCell.swift
//  XG Tool
//
//  Created by The Steez on 26/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGStringCell: XGTableViewCell {

	var textView = UILabel()
	var string = XGString(string: "", file: .Common_rel, sid: 0) {
		didSet {
			self.textView.text = string.stringPlusIDAndFile
		}
	}

	init(string: XGString, reuseIdentifier: String?) {
		super.init(style: .Default, reuseIdentifier: reuseIdentifier)
		
		self.string = string
		self.textView.translatesAutoresizingMaskIntoConstraints = false
		textView.text = string.stringPlusIDAndFile
		textView.font = UIFont(name: "Helvetica", size: 20)
		self.textView.backgroundColor = UIColor.clearColor()
		self.textView.userInteractionEnabled = false
		self.textView.numberOfLines = 0
		
		let views = ["t" : textView]
		self.addSubview(textView)
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(10)-[t]-(10)-|", options: [], metrics: nil, views: views))
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(50)-[t]-(50)-|", options: [], metrics: nil, views: views))
		
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
}





























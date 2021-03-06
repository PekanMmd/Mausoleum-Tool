//
//  XGRootTableViewCell.swift
//  XG Tool
//
//  Created by The Steez on 26/05/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGRootTableViewCell: UITableViewCell {
	
	var background = UIImageView()
	var title = UILabel()
	
	override var textLabel : UILabel {
		
		get {
			return self.title
		}
		
	}
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		self.addSubview(background)
		self.addSubview(title)
		self.background.translatesAutoresizingMaskIntoConstraints = false
		self.title.translatesAutoresizingMaskIntoConstraints = false
		
		self.title.font = UIFont(name: "Helvetica", size: 50)
		self.title.adjustsFontSizeToFitWidth = true
		self.title.textAlignment = .Center
		
		let views = ["title" : self.title, "back" : self.background]
		
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[title]|", options: [], metrics: nil, views: views))
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[back]|", options: [], metrics: nil, views: views))
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[title]|", options: [], metrics: nil, views: views))
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[back]|", options: [], metrics: nil, views: views))
		
		self.selectedBackgroundView = UIImageView(image: UIImage(named: "Selected Cell"))
		
	}

	convenience init(title: String, background : UIImage, reuseIdentifier: String) {
		self.init(style: .Default, reuseIdentifier: reuseIdentifier)
		
		self.title.text  = title
		self.background.image = background
		
		self.selectedBackgroundView = UIImageView(image: UIImage(named: "Selected Cell"))
		
	}

	required init?(coder aDecoder: NSCoder) {
	    super.init(coder: aDecoder)
	}

}

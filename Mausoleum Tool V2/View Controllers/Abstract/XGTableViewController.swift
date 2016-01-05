//
//  XGTableViewController.swift
//  XG Tool
//
//  Created by The Steez on 12/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGTableViewController: XGViewController, UITableViewDataSource, UITableViewDelegate {
	
	var tableContentView = UIView()
	var table = UITableView()
	var currentIndexPath = NSIndexPath(forItem: 0, inSection: 0)
	
	override var contentView : UIView! {
		get {
			return tableContentView
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.contentView.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(contentView)
		self.views["content"] = contentView
		
		self.table.dataSource = self
		self.table.delegate = self
		self.table.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(table)
		self.views["table"] = table
		
		self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[table(300)][content]|", options: [.AlignAllTop, .AlignAllBottom], metrics: nil, views: views))
		self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[table]|", options: [], metrics: nil, views: views))
		
		self.addShadowToView(view: table, radius: 5, xOffset: 5, yOffset: 0)
		
		table.backgroundColor = UIColor.blackColor()
		table.separatorStyle = .None
    }
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		return
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 75
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 0
	}

}


















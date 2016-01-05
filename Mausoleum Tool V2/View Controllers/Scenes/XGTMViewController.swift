//
//  XGTMViewController.swift
//  XG Tool
//
//  Created by The Steez on 07/08/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGTMViewController: XGTableViewController {
	
	var currentMove = XGTMs.TM(1).move
	
	var name = XGTextField()
	var location = XGTextField()
	var move = XGPopoverButton()
	
	var saveButton = XGButton()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.name = XGTextField(title: "", text: "", height: 100, width: 200, action: {  })
		self.name.userInteractionEnabled = false
		self.addSubview(name, name: "name")
		
		self.location = XGTextField(title: "", text: "", height: 100, width: 200, action: {  })
		self.location.userInteractionEnabled = false
		self.addSubview(location, name: "loc")
		
		self.move = XGPopoverButton(title: "", colour: UIColor.clearColor(), textColour: UIColor.blackColor(), popover: XGMovePopover(), viewController: self)
		self.addSubview(move, name: "move")
		self.addConstraintSize(view: self.move, height: 100, width: 200)
		
		self.saveButton = XGButton(title: "Save", colour: UIColor.blueColor(), textColour: UIColor.whiteColor(), action: { self.save() })
		self.addSubview(saveButton, name: "save")
		self.addConstraintSize(view: self.saveButton, height: 100, width: 200)
		
		self.createDummyViewsEqualWidths(3, baseName: "h")
		self.createDummyViewsEqualHeights(4, baseName: "v")
		
		self.addConstraints(visualFormat: "H:|[h1][name][h2][loc][h3]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "V:|[v1][h2][v2][move][v3][save][v4]|", layoutFormat: .AlignAllCenterX)
		
		
		self.update()
	}
	
	func update() {
		self.showActivityView { (Bool) -> Void in
			
			let tm = XGTMs.TM(self.currentIndexPath.row + 1)
			
			self.location.text = tm.location
			self.move.textLabel.text = self.currentMove.name.string
			self.move.setBackgroundImage(self.currentMove.type.image, forState: .Normal)
			
			self.hideActivityView()
		}
		
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! XGTableViewCell!
		if cell == nil {
			cell = XGTableViewCell(style: .Subtitle, reuseIdentifier: "cell")
		}
		
		let tm = XGTMs.TM(indexPath.row + 1)
		
		cell.title = tm.move.name.string
		cell.subtitle = tm.location
		cell.background = tm.move.type.image
		
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		self.currentIndexPath = indexPath
		self.currentMove = XGTMs.TM(indexPath.row + 1).move
		self.update()
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return kNumberOfTMs
	}
	
	override func popoverDidDismiss() {
		if self.popoverPresenter == self.move {
			self.currentMove = self.selectedItem as! XGMoves
			self.move.popover.dismissPopoverAnimated(true)
			self.update()
		}
	}
	
	func save() {
		self.showActivityView { (Bool) -> Void in
			
			XGTMs.TM(self.currentIndexPath.row + 1).replaceWithMove(self.currentMove)
			
			self.table.reloadRowsAtIndexPaths([self.currentIndexPath], withRowAnimation: .Fade)
			self.table.selectRowAtIndexPath(self.currentIndexPath, animated: false, scrollPosition: .None)
			
			self.hideActivityView()
		}
	}
	

}





















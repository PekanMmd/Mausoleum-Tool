//
//  XGTypeViewController.swift
//  XG Tool
//
//  Created by The Steez on 30/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGTypeViewController: XGTableViewController {
	
	var type = XGType(index: 0)
	
	var nameField = XGTextField()
	var categoryField = XGButtonField()
	var effectivenessButtons = [XGButtonField](count: kNumberOfTypes, repeatedValue: XGButtonField())

    override func viewDidLoad() {
        super.viewDidLoad()
		
        self.setUpUI()
		self.updateUI()
    }
	
	func setUpUI() {
		
		self.title = "Type Editor"
		
		nameField = XGTextField(title: "Name", text: "", height: 60, width: 300, action: {
			XGString(string: self.nameField.text, file: .Common_rel, sid: self.type.nameID).replace(true)
			self.updateUI()
		})
		nameField.field.backgroundColor = UIColor.redColor()
		nameField.field.textColor = UIColor.blackColor()
		self.addSubview(nameField, name: "name")
		
		categoryField = XGButtonField(title: "Category", text: type.category.string, height: 60, width: 300, action: {
			self.type.category = self.type.category.cycle()
			self.updateUI()
		})
		self.categoryField.field.backgroundColor = UIColor.blueColor()
		categoryField.field.textColor = UIColor.blackColor()
		self.addSubview(categoryField, name: "cat")
		
		for var i = 0; i < kNumberOfTypes; i++ {
			
			let inx = i
			
			effectivenessButtons[inx] = XGButtonField(title: XGMoveTypes(rawValue: i)!.name, text: self.type.effectivenessTable[i].string, height: 50, width: 90, action: {
				self.type.effectivenessTable[inx] = self.type.effectivenessTable[inx].cycle()
				self.updateUI()
			})
			effectivenessButtons[i].field.backgroundColor = UIColor.yellowColor()
			effectivenessButtons[i].field.textColor = UIColor.blackColor()
			self.addSubview(effectivenessButtons[i], name: "eb\(i + 1)")
		}
		
		let save = XGButton(title: "Save", colour: UIColor.greenColor(), textColour: UIColor.blackColor(), action: {
			self.saveData()
		})
		self.addSubview(save, name: "save")
		self.addConstraintSize(view: save, height: 60, width: 300)
		
		self.createDummyViewsEqualWidths(7 , baseName: "a")
		self.createDummyViewsEqualWidths(7 , baseName: "b")
		self.createDummyViewsEqualWidths(7 , baseName: "c")
		self.createDummyViewsEqualHeights(6, baseName: "y")
		
		self.addConstraintAlignCenterX(view1: self.contentView, view2: nameField)
		self.addConstraints(visualFormat: "H:|[a1][eb1][a2][eb2][a3][eb3][a4][eb4][a5][eb5][a6][eb6][a7]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[b1][eb7][b2][eb8][b3][eb9][b4][eb10][b5][eb11][b6][eb12][b7]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[c1][eb13][c2][eb14][c3][eb15][c4][eb16][c5][eb17][c6][eb18][c7]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		
		self.addConstraints(visualFormat: "V:|-(20)-[name][y1][cat][y2][a4][y3][b4][y4][c4][y5][save][y6]|", layoutFormat: .AlignAllCenterX)
		
	}
	
	func updateUI() {
		self.showActivityView { (Bool) -> Void in
		
			self.nameField.text = self.type.type.name
			self.categoryField.text = self.type.category.string
			
			for var i = 0; i < self.effectivenessButtons.count; i++ {
				
				self.effectivenessButtons[i].text = self.type.effectivenessTable[i].string
				
			}
			
			self.hideActivityView()
		}
		
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return kNumberOfTypes
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		self.currentIndexPath = indexPath
		self.type = XGType(index: indexPath.row)
		self.updateUI()
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! XGTableViewCell!
		if cell == nil {
			cell = XGTableViewCell(style: .Subtitle, reuseIdentifier: "cell")
		}
		
		let type = XGMoveTypes(rawValue: indexPath.row) ?? .Normal
		
		cell.title = type.name
		cell.background = type.image
		
		return cell
	}
	
	func saveData() {
		self.showActivityView { (Bool) -> Void in
			self.type.save()
			
			self.table.reloadRowsAtIndexPaths([self.currentIndexPath], withRowAnimation: .Fade)
			self.table.selectRowAtIndexPath(self.currentIndexPath, animated: false, scrollPosition: .None)
			
			self.hideActivityView()
		}
	}

}




















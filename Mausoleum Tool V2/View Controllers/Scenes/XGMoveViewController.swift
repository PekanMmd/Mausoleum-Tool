//
//  XGMoveViewController.swift
//  XG Tool
//
//  Created by The Steez on 20/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGMoveViewController: XGTableViewController {
	
//	var animations = [Int]()
	
	var moveNames = [String]()
	var moveTypes = [XGMoveTypes]()

	var move = XGMove(index: 0)
	
	var startField		= XGTextField()
	var indexField		= XGTextField()
	
	var nameField		= XGTextField()
	var descField		= XGTextField()
	
	var priorityField	= XGValueTextField()
	var ppTextField		= XGValueTextField()
	var accuracyField	= XGValueTextField()
	var powerField		= XGValueTextField()
	var effectAccuracyField	= XGValueTextField()
	
//	var animationButton	= XGPopoverButton()
	var typeButton		= XGPopoverButton()
	var effectButton	= XGPopoverButton()
	var targetsButton	= XGButtonField()
	var categoryButton	= XGButtonField()
	
	var contactButton	= XGButton()
	var protectButton	= XGButton()
	var magicButton		= XGButton()
	var snatchButton	= XGButton()
	var mirrorButton	= XGButton()
	var kingsButton		= XGButton()
	var soundButton		= XGButton()
	var hmButton		= XGButton()
	
	var originalCopyButton	= XGPopoverButton()
	var modifiedCopyButton	= XGPopoverButton()
	
	var saveButton		= XGButton()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.title = "Move Editor"
		
		self.showActivityView{ (Bool) -> Void in
			
//			for var i = 0; i < kNumberOfMoves; i++ {
//				self.animations.append(XGMoves.Move(i).animation)
//			}
			
			self.loadTableData()
			self.table.reloadData()
			self.setUpUI()
			self.updateView()
			
			self.hideActivityView()
		}
		
	}
	
	func loadTableData() {
		
		moveNames = []
		moveTypes = []
		
		for var i = 0; i < kNumberOfMoves; i++ {
			let move = XGMoves.Move(i)
			
			moveNames.append(move.name.string)
			moveTypes.append(move.type)
		}
	}
	
	func setUpUI() {
		
		startField = XGTextField(title: "Start Offset", height: 50, width: 150, action: {})
		startField.userInteractionEnabled = false
		self.addSubview(startField, name: "start")
		
		indexField = XGTextField(title: "Index", height: 50, width: 150, action: {})
		indexField.userInteractionEnabled = false
		self.addSubview(indexField, name: "index")
		
		nameField = XGTextField(title: "Name", height: 50, width: 200, action: { var str = self.move.nameString.duplicateWithString(self.nameField.text).replace(true); self.updateView() })
		self.addSubview(nameField, name: "name")
		
		descField = XGTextField(title: "Description", height: 50, width: 600, action: { self.move.descriptionString.duplicateWithString(self.descField.text).replace(true); self.updateView() })
		self.addSubview(descField, name: "desc")
		
		priorityField = XGValueTextField(title: "Priority", min: -126, max: 126, height: 50, width: 100, action: {self.move.priority = self.priorityField.value >= 0 ? self.priorityField.value : (256 - self.priorityField.value)})
		self.addSubview(priorityField, name: "priority")
		
		ppTextField = XGValueTextField(title: "PP", min: 0, max: 255, height: 50, width: 100, action: {self.move.pp = self.ppTextField.value; self.updateView()})
		self.addSubview(ppTextField, name: "pp")
		
		accuracyField = XGValueTextField(title: "accuracy", min: 0, max: 255, height: 50, width: 100, action: {self.move.accuracy = self.accuracyField.value; self.updateView()})
		self.addSubview(accuracyField, name: "accuracy")
		
		powerField = XGValueTextField(title: "Power", min: 0, max: 255, height: 50, width: 100, action: {self.move.basePower = self.powerField.value; self.updateView()})
		self.addSubview(powerField, name: "power")
		
		effectAccuracyField = XGValueTextField(title: "Effect Accuracy", min: 0, max: 255, height: 50, width: 100, action: {self.move.effectAccuracy = self.effectAccuracyField.value; self.updateView()})
		self.addSubview(effectAccuracyField, name: "effectAccuracy")
		
		effectButton = XGPopoverButton(title: "Effect", colour: UIColor.blackColor(), textColour: UIColor.orangeColor(), popover: XGMoveEffectPopover(), viewController: self)
		self.addSubview(effectButton, name: "effect")
		self.addConstraintSize(view: effectButton, height: 50, width: 600)
		
		typeButton = XGPopoverButton(title: "Type", colour: UIColor.whiteColor(), textColour: UIColor.blackColor(), popover: XGTypePopover(), viewController: self)
		self.addSubview(typeButton, name: "type")
		self.addConstraintWidth(view: typeButton, width: 200)
		
		categoryButton = XGButtonField(title: "Category", text: "", colour: UIColor.yellowColor(), height: 40, width: 175, action: {self.move.category = self.move.category.cycle(); self.updateView()})
		self.addSubview(categoryButton, name: "category")
		
		targetsButton = XGButtonField(title: "Targets", text: "", colour: UIColor.yellowColor(), height: 40, width: 175, action: {self.move.target = self.move.target.cycle(); self.updateView()})
		self.addSubview(targetsButton, name: "targets")
		
		contactButton = XGButton(title: "Contact", colour: UIColor.redColor(), textColour: UIColor.blackColor(), action: {self.move.contactFlag = !self.move.contactFlag; self.updateView()})
		self.addSubview(contactButton, name: "contact")
		self.addConstraintSize(view: contactButton, height: 40, width: 100)
		protectButton = XGButton(title: "Protect", colour: UIColor.redColor(), textColour: UIColor.blackColor(), action: {self.move.protectFlag = !self.move.protectFlag; self.updateView()})
		self.addSubview(protectButton, name: "protect")
		self.addConstraintSize(view: protectButton, height: 40, width: 100)
		magicButton = XGButton(title: "Magic Coat", colour: UIColor.redColor(), textColour: UIColor.blackColor(), action: {self.move.magicCoatFlag = !self.move.magicCoatFlag; self.updateView()})
		self.addSubview(magicButton, name: "magic")
		self.addConstraintSize(view: magicButton, height: 40, width: 100)
		snatchButton = XGButton(title: "Snatch", colour: UIColor.redColor(), textColour: UIColor.blackColor(), action: {self.move.snatchFlag = !self.move.snatchFlag; self.updateView()})
		self.addSubview(snatchButton, name: "snatch")
		self.addConstraintSize(view: snatchButton, height: 40, width: 100)
		mirrorButton = XGButton(title: "Mirror Move", colour: UIColor.redColor(), textColour: UIColor.blackColor(), action: {self.move.mirrorMoveFlag = !self.move.mirrorMoveFlag; self.updateView()})
		self.addSubview(mirrorButton, name: "mirror")
		self.addConstraintSize(view: mirrorButton, height: 40, width: 100)
		kingsButton = XGButton(title: "King's Rock", colour: UIColor.redColor(), textColour: UIColor.blackColor(), action: {self.move.kingsRockFlag = !self.move.kingsRockFlag; self.updateView()})
		self.addSubview(kingsButton, name: "kings")
		self.addConstraintSize(view: kingsButton, height: 40, width: 100)
		soundButton = XGButton(title: "Sound Based", colour: UIColor.redColor(), textColour: UIColor.blackColor(), action: {self.move.soundBasedFlag = !self.move.soundBasedFlag; self.updateView()})
		self.addSubview(soundButton, name: "sound")
		self.addConstraintSize(view: soundButton, height: 40, width: 100)
		hmButton = XGButton(title: "HM", colour: UIColor.redColor(), textColour: UIColor.blackColor(), action: {self.move.HMFlag = !self.move.HMFlag; self.updateView()})
		self.addSubview(hmButton, name: "hm")
		self.addConstraintSize(view: hmButton, height: 40, width: 100)
		
//		animationButton = XGPopoverButton(title: "", colour: UIColor.orangeColor(), textColour: UIColor.blackColor(), popover: XGMovePopover(), viewController: self)
//		self.addSubview(animationButton, name: "anim")
//		self.addConstraintSize(view: animationButton, height: 40, width: 200)
		
		originalCopyButton = XGPopoverButton(title: "Original Moves", colour: UIColor.purpleColor(), textColour: UIColor.blackColor(), popover: XGMovePopover(), viewController: self)
		self.addSubview(originalCopyButton, name: "OCB")
		self.addConstraintSize(view: originalCopyButton, height: 50, width: 200)
		modifiedCopyButton = XGPopoverButton(title: "Modified Moves", colour: UIColor.purpleColor(), textColour: UIColor.blackColor(), popover: XGMovePopover(), viewController: self)
		self.addSubview(modifiedCopyButton, name: "MCB")
		self.addConstraintSize(view: modifiedCopyButton, height: 50, width: 200)
		
		saveButton = XGButton(title: "Save", colour: UIColor.blueColor(), textColour: UIColor.blackColor(), action: {self.save()})
		self.addSubview(saveButton, name: "save")
		self.addConstraintSize(view: saveButton, height: 50, width: 200)
		
		self.createDummyViewsEqualWidths(6, baseName: "d")
		self.createDummyViewsEqualWidths(4, baseName: "e")
		self.createDummyViewsEqualWidths(5, baseName: "f")
		self.createDummyViewsEqualWidths(5, baseName: "g")
		self.createDummyViewsEqualWidths(4, baseName: "h")
		self.createDummyViewsEqualHeights(6, baseName: "v")
		
		self.addConstraintAlignTopAndBottomEdges(view1: startField, view2: indexField)
		self.addConstraintAlignTopAndBottomEdges(view1: startField, view2: nameField)
		self.addConstraints(visualFormat: "H:|-(>=0)-[index]-(50)-[name]-(50)-[start]-(>=0)-|", layoutFormat: [])
		self.addConstraints(visualFormat: "H:|[d1][priority][d2][pp][d3][power][d4][accuracy][d5][effectAccuracy][d6]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[e1][category][e2][type][e3][targets][e4]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[f1][contact][f2][protect][f3][magic][f4][snatch][f5]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[g1][mirror][g2][kings][g3][sound][g4][hm][g5]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[h1][OCB][h2][save][h3][MCB][h4]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "V:|-(5)-[name]-(5)-[desc]-(5)-[power][v1][effect][v2][type][v3][f3][v4][g3][v5][save][v6]|", layoutFormat: .AlignAllCenterX)
		self.addConstraintAlignCenterX(view1: self.contentView, view2: nameField)
		
	}
	
	func updateView() {
		
		self.showActivityView{ (Bool) -> Void in
			
			self.startField.text = String(format: "\(self.move.startOffset) : 0x%x", self.move.startOffset)
			self.indexField.text = String(format: "\(self.move.moveIndex) : 0x%x", self.move.moveIndex)
			self.nameField.text  = self.move.nameString.string
			self.descField.text  = self.move.descriptionString.string
			self.ppTextField.value = self.move.pp
			self.powerField.value = self.move.basePower
			self.accuracyField.value = self.move.accuracy
			self.effectAccuracyField.value = self.move.effectAccuracy
			self.effectButton.titleLabel?.text = XGMoveEffectPopover().effectList[self.move.effect]
			self.priorityField.value = self.move.priority <= 127 ? self.move.priority : (self.move.priority - 256)
			self.typeButton.setBackgroundImage(self.move.type.image, forState: .Normal)
			self.typeButton.titleLabel?.text = self.move.type.name
			self.categoryButton.text = self.move.category.string
			self.targetsButton.text = self.move.target.string
			self.contactButton.backgroundColor = self.move.contactFlag ? UIColor.greenColor() : UIColor.redColor()
			self.protectButton.backgroundColor = self.move.protectFlag ? UIColor.greenColor() : UIColor.redColor()
			self.magicButton.backgroundColor = self.move.magicCoatFlag ? UIColor.greenColor() : UIColor.redColor()
			self.snatchButton.backgroundColor = self.move.snatchFlag ? UIColor.greenColor() : UIColor.redColor()
			self.mirrorButton.backgroundColor = self.move.mirrorMoveFlag ? UIColor.greenColor() : UIColor.redColor()
			self.kingsButton.backgroundColor = self.move.kingsRockFlag ? UIColor.greenColor() : UIColor.redColor()
			self.soundButton.backgroundColor = self.move.soundBasedFlag ? UIColor.greenColor() : UIColor.redColor()
			self.hmButton.backgroundColor = self.move.HMFlag ? UIColor.greenColor() : UIColor.redColor()
			
//			for var i = 0; i < self.animations.count; i++ {
//				if self.move.moveAnimation == self.animations[i] {
//					var omove = XGMoves.Move(i)
//					self.animationButton.setBackgroundImage(omove.type.image, forState: .Normal)
//					self.animationButton.titleLabel?.text = omove.name.string
//				}
//				
//			}
			
			self.hideActivityView()
		}
		
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! XGTableViewCell!
		if cell == nil {
			cell = XGTableViewCell(style: .Subtitle, reuseIdentifier: "cell")
		}
		
		if moveNames.count == 0 {
			cell.backgroundColor = UIColor.blackColor()
			return cell!
		}
		
		let row = indexPath.row
		
		cell.title = moveNames[row]
		cell.subtitle = String(format: "\(row) : 0x%x", row)
		cell.background = moveTypes[row].image
		
		if moveTypes[row] == XGMoveTypes.Dark {
			cell.textLabel?.textColor = UIColor.whiteColor()
			cell.detailTextLabel?.textColor = UIColor.whiteColor()
		} else {
			cell.textLabel?.textColor = UIColor.blackColor()
			cell.detailTextLabel?.textColor = UIColor.blackColor()
		}
		
		cell.textLabel?.backgroundColor = UIColor.clearColor()
		cell.detailTextLabel?.backgroundColor = UIColor.clearColor()
		
		if XGMoves.Move(row).isShadowMove {
			cell.background = XGFiles.NameAndFolder("shadow.png", .Types).image
		}
		
		return cell!
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		self.currentIndexPath = indexPath
		self.move = XGMove(index: indexPath.row)
		self.updateView()
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return kNumberOfMoves
	}
	
	override func popoverDidDismiss() {
		
		popoverPresenter.popover.dismissPopoverAnimated(true)
		
		if popoverPresenter == effectButton {
			
			self.move.effect = selectedItem as! Int
			
		} else if popoverPresenter == typeButton {
			
			self.move.type = selectedItem as! XGMoveTypes
			
		} else if popoverPresenter == originalCopyButton {
			
			let move = selectedItem as! XGMoves
			let byteCopier = XGByteCopier(copyFile: .Common_rel, copyOffset: move.startOffset, length: kSizeOfMoveData, targetFile: .Common_rel, targetOffset: self.move.startOffset)
			let popover = XGByteCopyPopover(copier: byteCopier)
			let popButton = XGPopoverButton(title: "", colour: UIColor.clearColor(), textColour: UIColor.clearColor(), popover: popover, viewController: self)
			popButton.alpha = 0
			self.addSubview(popButton, name: "OPB")
			self.addConstraintAlignAllEdges(view1: self.modifiedCopyButton, view2: popButton)
			popButton.action()
			self.move.save()
			
		} else if popoverPresenter == views["OPB"] {
			
			popoverPresenter.removeFromSuperview()
			self.move = XGMove(index: self.move.moveIndex)
			
		} else if popoverPresenter == modifiedCopyButton {
			
			let move = selectedItem as! XGMoves
			let byteCopier = XGByteCopier(copyFile: .Common_rel, copyOffset: move.startOffset, length: kSizeOfMoveData, targetFile: .Common_rel, targetOffset: self.move.startOffset)
			let popover = XGByteCopyPopover(copier: byteCopier)
			let popButton = XGPopoverButton(title: "", colour: UIColor.clearColor(), textColour: UIColor.clearColor(), popover: popover, viewController: self)
			popButton.alpha = 0
			self.addSubview(popButton, name: "MPB")
			self.addConstraintAlignAllEdges(view1: self.modifiedCopyButton, view2: popButton)
			popButton.action()
			self.move.save()
			
		} else if popoverPresenter == views["MPB"] {
			
			popoverPresenter.removeFromSuperview()
			self.move = XGMove(index: self.move.moveIndex)
			
		}
		
		self.updateView()
	}
	
	func save() {
		self.showActivityView{ (Bool) -> Void in
			self.move.save()
			
			self.moveTypes[self.move.moveIndex] = self.move.type
			self.moveNames[self.move.moveIndex] = self.move.nameString.string
			
			self.table.reloadRowsAtIndexPaths([self.currentIndexPath], withRowAnimation: .Fade)
			self.table.selectRowAtIndexPath(self.currentIndexPath, animated: false, scrollPosition: .None)
			
			self.hideActivityView()
		}
	}

}






















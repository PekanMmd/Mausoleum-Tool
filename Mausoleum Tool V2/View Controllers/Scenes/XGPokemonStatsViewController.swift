//
//  XGPokemonStatsViewController.swift
//  XG Tool
//
//  Created by The Steez on 02/07/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGPokemonStatsViewController: XGTableViewController {
	
	var pokemon = XGPokemonStats(index: 0)
	
	var startField		= XGTextField()
	
	var nameField		= XGTextField()
	var speciesField	= XGTextField()
	
//	var cryField		= XGValueTextField()
//	var modelField		= XGValueTextField()
//	var faceField		= XGValueTextField()
	
	var levelUpRate		= XGButtonField()
	var genderRatio		= XGButtonField()
	
	var catchRate		= XGValueTextField()
	var baseExp			= XGValueTextField()
	var baseHappiness	= XGValueTextField()
	
	var ability1		= XGPopoverButton()
	var ability2		= XGPopoverButton()
	
	var type1			= XGPopoverButton()
	var type2			= XGPopoverButton()
	
	var item1			= XGPopoverButton()
	var item2			= XGPopoverButton()
	
	var hp				= XGValueTextField()
	var speed			= XGValueTextField()
	var attack			= XGValueTextField()
	var defense			= XGValueTextField()
	var specialAttack	= XGValueTextField()
	var specialDefense	= XGValueTextField()
	
	var nameID			= XGTextField()
	
	var levelUpButton	= XGButton()
	var levelUpVC		= XGLevelUpMovesPopover()
	var levelUpPopover  = UIPopoverController(contentViewController: XGViewController())
	
	var tmsTable		= UITableView()
	var tutorTable		= UITableView()
	var evolutionsTable	= UITableView()
	
	var originalCopyButton	= XGPopoverButton()
	var modifiedCopyButton	= XGPopoverButton()
	
	var saveButton		= XGButton()

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.setUpPopovers()
		
		self.showActivityView { (Bool) -> Void in
			self.setUpUI()
			self.updateView()
		}
		
	}
	
	func setUpPopovers() {
		self.levelUpPopover = UIPopoverController(contentViewController: levelUpVC)
		levelUpVC.popover = self.levelUpPopover
		levelUpPopover.setPopoverContentSize(CGSizeMake(600, 600), animated: false)
	}

	func setUpUI() {
		
		startField = XGTextField(title: "Start Offset", height: 50, width: 200, action: {})
		startField.userInteractionEnabled = false
		self.addSubview(startField, name: "start")
		
		speciesField = XGTextField(title: "Species", height: 50, width: 200, action: { self.pokemon.species.duplicateWithString(self.speciesField.text).replace(true); self.updateView() })
		self.addSubview(speciesField, name: "species")
		
		nameField = XGTextField(title: "Name", height: 50, width: 200, action: { self.pokemon.name.duplicateWithString(self.nameField.text).replace(true); self.updateView() })
		self.addSubview(nameField, name: "name")
		
		nameID = XGTextField(title: "Name ID", text: "", height: 50, width: 200, action: { self.pokemon.nameID = Int(strtoul(self.nameID.text, nil, 16)); self.updateView() })
		self.addSubview(nameID, name: "id")
		
		levelUpRate = XGButtonField(title: "Level Up Rate", text: "", colour: UIColor.yellowColor(), height: 40, width: 100, action: { self.pokemon.levelUpRate = self.pokemon.levelUpRate.cycle(); self.updateView() })
		self.addSubview(levelUpRate, name: "levelRate")
		
		genderRatio = XGButtonField(title: "Gender Ratio", text: "", colour: UIColor.yellowColor(), height: 40, width: 100, action: { self.pokemon.genderRatio = self.pokemon.genderRatio.cycle(); self.updateView() })
		self.addSubview(genderRatio, name: "gender")
		
		catchRate = XGValueTextField(title: "Catch Rate", value: 0, min: 0, max: 0xFF, height: 40, width: 100, action: { self.pokemon.catchRate = self.catchRate.value; self.updateView() })
		self.addSubview(catchRate, name: "catch")
		
		baseExp = XGValueTextField(title: "Base EXP", value: 0, min: 0, max: 0xFF, height: 40, width: 100, action: { self.pokemon.baseExp = self.baseExp.value; self.updateView() })
		self.addSubview(baseExp, name: "exp")
		
		baseHappiness = XGValueTextField(title: "Base Happiness", value: 0, min: 0, max: 0xFF, height: 40, width: 100, action: { self.pokemon.baseHappiness = self.baseHappiness.value; self.updateView() })
		self.addSubview(baseHappiness, name: "happiness")
		
		ability1 = XGPopoverButton(title: "", colour: UIColor.blueColor(), textColour: UIColor.blackColor(), popover: XGAbilityPopover(), viewController: self)
		self.addSubview(ability1, name: "ab1")
		
		ability2 = XGPopoverButton(title: "", colour: UIColor.blueColor(), textColour: UIColor.blackColor(), popover: XGAbilityPopover(), viewController: self)
		self.addSubview(ability2, name: "ab2")
		
		type1 = XGPopoverButton(title: "", colour: UIColor.blueColor(), textColour: UIColor.blackColor(), popover: XGTypePopover(), viewController: self)
		self.addSubview(type1, name: "type1")
		
		type2 = XGPopoverButton(title: "", colour: UIColor.blueColor(), textColour: UIColor.blackColor(), popover: XGTypePopover(), viewController: self)
		self.addSubview(type2, name: "type2")
		
		hp = XGValueTextField(title: "HP", value: 0, min: 0, max: 0xFF, height: 40, width: 60, action: { self.pokemon.hp = self.hp.value; self.updateView() })
		self.addSubview(hp, name: "hp")
		
		attack = XGValueTextField(title: "Attack", value: 0, min: 0, max: 0xFF, height: 40, width: 60, action: { self.pokemon.attack = self.attack.value; self.updateView() })
		self.addSubview(attack, name: "atk")
		
		defense = XGValueTextField(title: "Defense", value: 0, min: 0, max: 0xFF, height: 40, width: 60, action: { self.pokemon.defense = self.defense.value; self.updateView() })
		self.addSubview(defense, name: "def")
		
		speed = XGValueTextField(title: "Speed", value: 0, min: 0, max: 0xFF, height: 40, width: 60, action: { self.pokemon.speed = self.speed.value; self.updateView() })
		self.addSubview(speed, name: "spe")
		
		specialAttack = XGValueTextField(title: "Special Attack", value: 0, min: 0, max: 0xFF, height: 40, width: 60, action: { self.pokemon.specialAttack = self.specialAttack.value; self.updateView() })
		self.addSubview(specialAttack, name: "spa")
		
		specialDefense = XGValueTextField(title: "Special Defense", value: 0, min: 0, max: 0xFF, height: 40, width: 60, action: { self.pokemon.specialDefense = self.specialDefense.value; self.updateView() })
		self.addSubview(specialDefense, name: "spd")
		
		levelUpButton = XGButton(title: "Level Up Moves", colour: UIColor.blueColor(), textColour: UIColor.blackColor(), action: {
			self.levelUpPopover.presentPopoverFromRect(self.levelUpButton.frame, inView: self.contentView, permittedArrowDirections: .Any, animated: true)
		})
		self.addSubview(self.levelUpButton, name: "LUB")
		self.addConstraintSize(view: self.levelUpButton, height: 50, width: 150)
		
		self.item1 = XGPopoverButton()
		self.addSubview(item1, name: "it1")
		self.item1.userInteractionEnabled = false
		
		self.item2 = XGPopoverButton()
		self.addSubview(item2, name: "it2")
		self.item2.userInteractionEnabled = false
		
		
		
		originalCopyButton = XGPopoverButton(title: "Original Pokemon", colour: UIColor.purpleColor(), textColour: UIColor.blackColor(), popover: XGOriginalPokemonPopover(), viewController: self)
		self.addSubview(originalCopyButton, name: "OCB")
		self.addConstraintSize(view: originalCopyButton, height: 50, width: 200)
		
		modifiedCopyButton = XGPopoverButton(title: "Modified Pokemon", colour: UIColor.purpleColor(), textColour: UIColor.blackColor(), popover: XGPokemonPopover(), viewController: self)
		self.addSubview(modifiedCopyButton, name: "MCB")
		self.addConstraintSize(view: modifiedCopyButton, height: 50, width: 200)
		
		saveButton = XGButton(title: "Save", colour: UIColor.blueColor(), textColour: UIColor.blackColor(), action: { self.save() })
		self.addSubview(saveButton, name: "save")
		self.addConstraintSize(view: saveButton, height: 50, width: 200)
		
		self.createDummyViewsEqualWidths(4, baseName: "a")
		self.createDummyViewsEqualWidths(7, baseName: "b")
		self.createDummyViewsEqualWidths(6, baseName: "c")
		self.createDummyViewsEqualWidths(4, baseName: "d")
		self.createDummyViewsEqualWidths(4, baseName: "e")
		self.createDummyViewsEqualWidths(4, baseName: "f")
		self.createDummyViewsEqualWidths(2, baseName: "g")
		
		self.createDummyViewsEqualHeights(5, baseName: "z")
		
		self.addConstraintAlignCenterX(view1: nameID, view2: self.contentView)
		self.addConstraints(visualFormat: "H:|[a1][start][a2][name][a3][species][a4]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[b1][hp][b2][atk][b3][def][b4][spa][b5][spd][b6][spe][b7]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[c1][levelRate][c2][gender][c3][catch][c4][exp][c5][happiness][c6]|", layoutFormat: .AlignAllCenterY)
		self.addConstraints(visualFormat: "H:|[d1][type1(200)][d2][ab1(200)][d3][it1(200)][d4]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[e1][type2(200)][e2][ab2(200)][e3][it2(200)][e4]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[f1][OCB][f2][save][f3][MCB][f4]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[g1][LUB][g2]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		
		self.addConstraints(visualFormat: "V:|-(15)-[name]-(10)-[id]-(10)-[b4][z1][catch][z2][ab1(50)][z3][ab2(50)][z4][save][z5][LUB]-(15)-|", layoutFormat: .AlignAllCenterX)
		self.addConstraintAlignCenterX(view1: self.contentView, view2: self.nameField)
		
//		for var i = 0; i < kNumberOfPokemon; i++ {
//			
//			let stats = XGPokemonStats(index: i)
//			
//			for var j = 0; j < kNumberOfEvolutions; j++ {
//				if (stats.evolutions[j].evolutionMethod == XGEvolutionMethods.Trade) || (stats.evolutions[j].evolutionMethod == XGEvolutionMethods.TradeWithItem) {
//					stats.evolutions[j].evolutionMethod = .LevelUp
//					stats.evolutions[j].condition = 40
//					stats.save()
//				}
//			}
//			
//		}
		
	}
	
	func updateView() {
		self.showActivityView { (Bool) -> Void in
			
			self.startField.text = String(format: "\(self.pokemon.startOffset) : 0x%x", self.pokemon.startOffset)
			self.nameField.text = self.pokemon.name.string
			self.speciesField.text = self.pokemon.species.string
			self.levelUpRate.text = self.pokemon.levelUpRate.string
			self.genderRatio.text = self.pokemon.genderRatio.string
			self.catchRate.value = self.pokemon.catchRate
			self.baseExp.value = self.pokemon.baseExp
			self.baseHappiness.value = self.pokemon.baseHappiness
			self.ability1.textLabel.text = self.pokemon.ability1.name.string
			self.ability2.textLabel.text = self.pokemon.ability2.name.string
			self.type1.textLabel.text = self.pokemon.type1.name
			self.type2.textLabel.text = self.pokemon.type2.name
			self.type1.setBackgroundImage(self.pokemon.type1.image, forState: .Normal)
			self.type2.setBackgroundImage(self.pokemon.type2.image, forState: .Normal)
			self.hp.value = self.pokemon.hp
			self.attack.value = self.pokemon.attack
			self.defense.value = self.pokemon.defense
			self.speed.value = self.pokemon.speed
			self.specialAttack.value = self.pokemon.specialAttack
			self.specialDefense.value = self.pokemon.specialDefense
			self.nameID.text = String(format: "0x%x", self.pokemon.nameID)
			
			self.hideActivityView()
		}
	}
	
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell = table.dequeueReusableCellWithIdentifier("cell") as! XGTableViewCell!
		if cell == nil {
			cell = XGTableViewCell(style: .Subtitle, reuseIdentifier: "cell")
		}
		
		let poke = XGPokemon.Pokemon(indexPath.row)
		
		cell.picture = poke.face
		cell.title = poke.name.string
		
		let type = poke.type1
		cell.background = type.image
		
		cell.subtitle = String(format: "\(indexPath.row) : 0x%x", indexPath.row)
		
		if type == XGMoveTypes.Dark {
			cell.textLabel?.textColor = UIColor.whiteColor()
			cell.detailTextLabel?.textColor = UIColor.whiteColor()
		} else {
			cell.textLabel?.textColor = UIColor.blackColor()
			cell.detailTextLabel?.textColor = UIColor.blackColor()
		}
		
		return cell!
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		self.currentIndexPath = indexPath
		self.pokemon = XGPokemonStats(index: indexPath.row)
		self.updateView()
		self.levelUpVC.stats = self.pokemon
		self.levelUpVC.table.reloadData()
		self.levelUpVC.update()
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return kNumberOfPokemon
	}
	
	override func popoverDidDismiss() {
		popoverPresenter.popover.dismissPopoverAnimated(true)
		
		if popoverPresenter == self.type1 {
			
			self.pokemon.type1 = self.selectedItem as! XGMoveTypes
			
		} else if popoverPresenter == self.type2 {
			
			self.pokemon.type2 = self.selectedItem as! XGMoveTypes
			
		} else if popoverPresenter == self.ability1 {
			
			self.pokemon.ability1 = self.selectedItem as! XGAbilities
			
		} else if popoverPresenter == self.ability2 {
			
			self.pokemon.ability2 = self.selectedItem as! XGAbilities
			
		} else if popoverPresenter == originalCopyButton {
			
			let poke = selectedItem as! XGOriginalPokemon
			let byteCopier = XGByteCopier(copyFile: .Resources(.FDAT("common_rel")), copyOffset: poke.startOffset, length: kSizeOfPokemonStats, targetFile: .Common_rel, targetOffset: self.pokemon.startOffset)
			let popover = XGByteCopyPopover(copier: byteCopier)
			let popButton = XGPopoverButton(title: "", colour: UIColor.clearColor(), textColour: UIColor.clearColor(), popover: popover, viewController: self)
			popButton.alpha = 0
			self.addSubview(popButton, name: "OPB")
			self.addConstraintAlignAllEdges(view1: self.originalCopyButton, view2: popButton)
			popButton.action()
			self.pokemon.save()
			
		} else if popoverPresenter == views["OPB"] {
			
			popoverPresenter.removeFromSuperview()
			self.pokemon = XGPokemonStats(index: self.pokemon.index)
			
		} else if popoverPresenter == modifiedCopyButton {
			
			let poke = selectedItem as! XGPokemon
			let byteCopier = XGByteCopier(copyFile: .Common_rel, copyOffset: poke.startOffset, length: kSizeOfPokemonStats, targetFile: .Common_rel, targetOffset: self.pokemon.startOffset)
			let popover = XGByteCopyPopover(copier: byteCopier)
			let popButton = XGPopoverButton(title: "", colour: UIColor.clearColor(), textColour: UIColor.clearColor(), popover: popover, viewController: self)
			popButton.alpha = 0
			self.addSubview(popButton, name: "MPB")
			self.addConstraintAlignAllEdges(view1: self.modifiedCopyButton, view2: popButton)
			popButton.action()
			self.pokemon.save()
			
		} else if popoverPresenter == views["MPB"] {
			
			popoverPresenter.removeFromSuperview()
			self.pokemon = XGPokemonStats(index: self.pokemon.index)
		}
		
		self.popoverPresenter.popover.dismissPopoverAnimated(true)
		self.updateView()
	}

	func save() {
		self.showActivityView { (Bool) -> Void in
			self.pokemon.save()
			
			self.table.reloadRowsAtIndexPaths([self.currentIndexPath], withRowAnimation: .Fade)
			self.table.selectRowAtIndexPath(self.currentIndexPath, animated: false, scrollPosition: .None)
			
			self.hideActivityView()
		}
	}


}




























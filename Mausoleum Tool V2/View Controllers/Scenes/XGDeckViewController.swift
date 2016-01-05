//
//  XGDeckViewController.swift
//  XG Tool
//
//  Created by The Steez on 13/07/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGDeckViewController: XGTableViewController {
	
	// Trainer
	
	var trainer = XGTrainer(index: 0) {
		didSet {
			self.setPokemon(1)
		}
	}
	
	var currentRow = 0
	var currentMon = 0

	var trainerClass = XGTextField()
	var trainerFace	 = XGTextField()
	var trainerName  = XGTextField()
	
	var trainerPreText  = XGTextField()
	var trainerWinText  = XGTextField()
	var trainerLossText = XGTextField()
	
	var payout = XGValueTextField()
	
	var p1 = XGButton()
	var p2 = XGButton()
	var p3 = XGButton()
	var p4 = XGButton()
	var p5 = XGButton()
	var p6 = XGButton()
	
	// Pokemon
	
	var pokemonData = XGTrainerPokemon(index: 0)
	var currentPokemonIndex = 0
	
	var name	= XGButton()
	var species	= XGPopoverButton()
	var nature  = XGPopoverButton()
	var item	= XGPopoverButton()
	var ability = XGButton()
	var gender  = XGButton()
	var level	= XGValueTextField()
	var move1	= XGPopoverButton()
	var move2	= XGPopoverButton()
	var move3	= XGPopoverButton()
	var move4	= XGPopoverButton()
	var happy	= XGValueTextField()
	var ivs		= XGValueTextField()
	var hp		= XGValueTextField()
	var attack	= XGValueTextField()
	var defense	= XGValueTextField()
	var spatk	= XGValueTextField()
	var spdef	= XGValueTextField()
	var speed	= XGValueTextField()
	
	var purgeBattleModeButton = XGButton()
	var purgeButton = XGButton()
	var saveButton = XGButton()
	
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Trainers"
		
		self.showActivityView { (Bool) -> Void in
			self.table.reloadData()
			self.setUpUI()
			self.updateUI()
		}
    }
	
	
	
	func setUpUI() {
		
		self.contentView.backgroundColor = UIColor.whiteColor()
		let trainerView = UIView()
		trainerView.backgroundColor = UIColor.redColor()
		self.addSubview(trainerView, name: "trBack")
		trainerView.translatesAutoresizingMaskIntoConstraints = false
		self.addConstraintAlignTopEdges(view1: trainerView, view2: self.contentView)
		self.addConstraintAlignLeftAndRightEdges(view1: trainerView, view2: self.contentView)
		self.addConstraintHeight(view: trainerView, height: 120)
		
		p1 = XGButton(title: "", colour: UIColor.clearColor(), textColour: UIColor.clearColor(), action: { self.setPokemon(1) })
		self.addSubview(p1, name: "p1")
		self.addConstraintSize(view: p1, height: 50, width: 50)
		
		p2 = XGButton(title: "", colour: UIColor.clearColor(), textColour: UIColor.clearColor(), action: { self.setPokemon(2) })
		self.addSubview(p2, name: "p2")
		self.addConstraintSize(view: p2, height: 50, width: 50)
		
		p3 = XGButton(title: "", colour: UIColor.clearColor(), textColour: UIColor.clearColor(), action: { self.setPokemon(3) })
		self.addSubview(p3, name: "p3")
		self.addConstraintSize(view: p3, height: 50, width: 50)
		
		p4 = XGButton(title: "", colour: UIColor.clearColor(), textColour: UIColor.clearColor(), action: { self.setPokemon(4) })
		self.addSubview(p4, name: "p4")
		self.addConstraintSize(view: p4, height: 50, width: 50)
		
		p5 = XGButton(title: "", colour: UIColor.clearColor(), textColour: UIColor.clearColor(), action: { self.setPokemon(5) })
		self.addSubview(p5, name: "p5")
		self.addConstraintSize(view: p5, height: 50, width: 50)
		
		p6 = XGButton(title: "", colour: UIColor.clearColor(), textColour: UIColor.clearColor(), action: { self.setPokemon(6) })
		self.addSubview(p6, name: "p6")
		self.addConstraintSize(view: p6, height: 50, width: 50)
		
		name	= XGButton(title: "", colour: UIColor.redColor(), textColour: UIColor.blackColor(), action: {})
		self.addSubview(name, name: "name")
		self.addConstraintSize(view: name, height: 60, width: 150)
		
		species	= XGPopoverButton(title: "", colour: UIColor.clearColor(), textColour: UIColor.clearColor(), popover: XGPokemonPopover(), viewController: self)
		self.addSubview(species, name: "spec")
		self.addConstraintSize(view: species, height: 60, width: 60)
		
		nature  = XGPopoverButton(title: "", colour: UIColor.greenColor(), textColour: UIColor.blackColor(), popover: XGNaturePopover(), viewController: self)
		self.addSubview(nature, name: "nature")
		self.addConstraintSize(view: nature, height: 50, width: 80)
		
		item	= XGPopoverButton(title: "", colour: UIColor.yellowColor(), textColour: UIColor.blackColor(), popover: XGItemPopover(), viewController: self)
		self.addSubview(item, name: "item")
		self.addConstraintSize(view: item, height: 50, width: 80)
		
		ability = XGButton(title: "", colour: UIColor.blueColor(), textColour: UIColor.blackColor(), action: { self.pokemonData.ability = 1 - self.pokemonData.ability; self.updateUI() })
		self.addSubview(ability, name: "ability")
		self.addConstraintSize(view: ability, height: 50, width: 80)
		
		gender  = XGButton(title: "", colour: UIColor.purpleColor(), textColour: UIColor.blackColor(), action: { self.pokemonData.gender = self.pokemonData.gender.cycle(); self.updateUI() })
		self.addSubview(gender, name: "gender")
		self.addConstraintSize(view: gender, height: 50, width: 80)
		
		level	= XGValueTextField(title: "Level", value: 100, min: 1, max: 100, height: 30, width: 150, action: { self.pokemonData.level = self.level.value; self.updateUI() })
		level.field.backgroundColor = UIColor.orangeColor()
		level.field.textColor = UIColor.blackColor()
		self.addSubview(level, name: "level")
		
		move1	= XGPopoverButton(title: "", colour: UIColor.clearColor(), textColour: UIColor.blackColor(), popover: XGMovePopover(), viewController: self)
		self.addSubview(move1, name: "m1")
		self.addConstraintSize(view: move1, height: 40, width: 100)
		
		move2	= XGPopoverButton(title: "", colour: UIColor.clearColor(), textColour: UIColor.blackColor(), popover: XGMovePopover(), viewController: self)
		self.addSubview(move2, name: "m2")
		self.addConstraintSize(view: move2, height: 40, width: 100)
		
		move3	= XGPopoverButton(title: "", colour: UIColor.clearColor(), textColour: UIColor.blackColor(), popover: XGMovePopover(), viewController: self)
		self.addSubview(move3, name: "m3")
		self.addConstraintSize(view: move3, height: 40, width: 100)
		
		move4	= XGPopoverButton(title: "", colour: UIColor.clearColor(), textColour: UIColor.blackColor(), popover: XGMovePopover(), viewController: self)
		self.addSubview(move4, name: "m4")
		self.addConstraintSize(view: move4, height: 40, width: 100)
		
		happy = XGValueTextField(title: "Happiness", value: 0, min: 0, max: 0xFF, height: 20, width: 80, action: { self.pokemonData.happiness = self.happy.value; self.updateUI() })
		self.addSubview(happy, name: "happy")
		happy.field.backgroundColor = UIColor.orangeColor()
		happy.field.textColor = UIColor.blackColor()
		happy.title.textColor = UIColor.blackColor()
		
		ivs = XGValueTextField(title: "IVs", value: 0, min: 0, max: 31, height: 30, width: 60, action: { self.pokemonData.IVs = self.ivs.value; self.updateUI() })
		self.addSubview(ivs, name: "iv")
		ivs.field.backgroundColor = UIColor.orangeColor()
		ivs.field.textColor = UIColor.blackColor()
		ivs.title.textColor = UIColor.blackColor()
		
		hp = XGValueTextField(title: "HP EVs", value: 0, min: 0, max: 0xFF, height: 30, width: 60, action: { self.pokemonData.EVs[0] = self.hp.value; self.updateUI() })
		self.addSubview(hp, name: "hp")
		hp.field.backgroundColor = UIColor.yellowColor()
		hp.field.textColor = UIColor.blackColor()
		hp.title.textColor = UIColor.blackColor()
		
		attack = XGValueTextField(title: "Attack EVs", value: 0, min: 0, max: 0xFF, height: 30, width: 60, action: { self.pokemonData.EVs[1] = self.attack.value; self.updateUI() })
		self.addSubview(attack, name: "atk")
		attack.field.backgroundColor = UIColor.yellowColor()
		attack.field.textColor = UIColor.blackColor()
		attack.title.textColor = UIColor.blackColor()
		
		defense = XGValueTextField(title: "Defense EVs", value: 0, min: 0, max: 0xFF, height: 30, width: 60, action: { self.pokemonData.EVs[2] = self.defense.value; self.updateUI() })
		self.addSubview(defense, name: "def")
		defense.field.backgroundColor = UIColor.yellowColor()
		defense.field.textColor = UIColor.blackColor()
		defense.title.textColor = UIColor.blackColor()
		
		spatk = XGValueTextField(title: "Sp.Atk EVs", value: 0, min: 0, max: 0xFF, height: 30, width: 60, action: { self.pokemonData.EVs[3] = self.spatk.value; self.updateUI() })
		self.addSubview(spatk, name: "spatk")
		spatk.field.backgroundColor = UIColor.yellowColor()
		spatk.field.textColor = UIColor.blackColor()
		spatk.title.textColor = UIColor.blackColor()
		
		spdef = XGValueTextField(title: "Sp.Def EVs", value: 0, min: 0, max: 0xFF, height: 30, width: 60, action: { self.pokemonData.EVs[4] = self.spdef.value; self.updateUI() })
		self.addSubview(spdef, name: "spdef")
		spdef.field.backgroundColor = UIColor.yellowColor()
		spdef.field.textColor = UIColor.blackColor()
		spdef.title.textColor = UIColor.blackColor()
		
		speed = XGValueTextField(title: "Speed EVs", value: 0, min: 0, max: 0xFF, height: 30, width: 60, action: { self.pokemonData.EVs[5] = self.speed.value; self.updateUI() })
		self.addSubview(speed, name: "speed")
		speed.field.backgroundColor = UIColor.yellowColor()
		speed.field.textColor = UIColor.blackColor()
		speed.title.textColor = UIColor.blackColor()
		
		purgeBattleModeButton = XGButton(title: "Purge Battle Mode", colour: UIColor.redColor(), textColour: UIColor.whiteColor(), action: {self.purgeBattleMode()})
		self.addSubview(purgeBattleModeButton, name: "PBM")
		self.addConstraintSize(view: purgeBattleModeButton, height: 40, width: 200)
		
		purgeButton = XGButton(title: "Purge", colour: UIColor.redColor(), textColour: UIColor.whiteColor(), action: { self.pokemonData.purge(); self.updateUI() })
		self.addSubview(purgeButton, name: "purge")
		self.addConstraintSize(view: purgeButton, height: 40, width: 200)
		
		saveButton = XGButton(title: "Save", colour: UIColor.blueColor(), textColour: UIColor.whiteColor(), action: { self.save() })
		self.addSubview(saveButton, name: "save")
		self.addConstraintSize(view: saveButton, height: 40, width: 200)
		
		
		self.createDummyViewsEqualWidths(7, baseName: "a")
		self.createDummyViewsEqualWidths(3, baseName: "b")
		self.createDummyViewsEqualWidths(2, baseName: "c")
		self.createDummyViewsEqualWidths(6, baseName: "d")
		self.createDummyViewsEqualWidths(5, baseName: "e")
		self.createDummyViewsEqualWidths(8, baseName: "f")
		self.createDummyViewsEqualWidths(5, baseName: "g")
		self.createDummyViewsEqualWidths(3, baseName: "h")
		self.createDummyViewsEqualWidths(4, baseName: "i")
		
		self.createDummyViewsEqualHeights(7, baseName: "v")
		
		self.addConstraints(visualFormat: "H:|[a1][p1][a2][p2][a3][p3][a4][p4][a5][p5][a6][p6][a7]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[b1][name][b2][level][b3]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[c1][spec][c2]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[d1][item][d2][nature][d3][ability][d4][gender][d5][happy][d6]|", layoutFormat: .AlignAllCenterY)
		self.addConstraints(visualFormat: "H:|[e1][m1][e2][m2][e3][m3][e4][m4][e5]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[f1][iv][f2][hp][f3][atk][f4][def][f5][spatk][f6][spdef][f7][speed][f8]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[i1][PBM][i2][save][i3][purge][i4]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		
		self.addConstraints(visualFormat: "V:[trBack]-(5)-[a4][v1][level][v2][def][v3][ability][v4][spec][v5][e3][v6][save][v7]|", layoutFormat: .AlignAllCenterX)
		
	}
	
	func updateUI() {
		
		self.showActivityView { (Bool) -> Void in
			
			self.p1.setBackgroundImage(self.trainer.pokemon[0].species.face , forState: .Normal)
			self.p2.setBackgroundImage(self.trainer.pokemon[1].species.face , forState: .Normal)
			self.p3.setBackgroundImage(self.trainer.pokemon[2].species.face , forState: .Normal)
			self.p4.setBackgroundImage(self.trainer.pokemon[3].species.face , forState: .Normal)
			self.p5.setBackgroundImage(self.trainer.pokemon[4].species.face , forState: .Normal)
			self.p6.setBackgroundImage(self.trainer.pokemon[5].species.face , forState: .Normal)
			
			let pd = self.pokemonData
			
			self.name.textLabel.text = pd.species.name.string
			self.species.setBackgroundImage(pd.species.body, forState: .Normal)
			self.nature.textLabel.text = pd.nature.string
			self.ability.textLabel.text = pd.ability == 0 ? pd.species.ability1 : pd.species.ability2
			self.gender.textLabel.text = pd.gender.string
			self.item.textLabel.text = pd.item.name.string
			self.level.value = pd.level
			self.happy.value = pd.happiness
			self.ivs.value = pd.IVs
			self.hp.value = pd.EVs[0]
			self.attack.value = pd.EVs[1]
			self.defense.value = pd.EVs[2]
			self.spatk.value = pd.EVs[3]
			self.spdef.value = pd.EVs[4]
			self.speed.value = pd.EVs[5]
			self.move1.textLabel.text = pd.moves[0].name.string
			self.move1.setBackgroundImage( XGFiles.TypeImage(pd.moves[0].type.rawValue).image , forState: .Normal)
			self.move2.textLabel.text = pd.moves[1].name.string
			self.move2.setBackgroundImage( XGFiles.TypeImage(pd.moves[1].type.rawValue).image , forState: .Normal)
			self.move3.textLabel.text = pd.moves[2].name.string
			self.move3.setBackgroundImage( XGFiles.TypeImage(pd.moves[2].type.rawValue).image , forState: .Normal)
			self.move4.textLabel.text = pd.moves[3].name.string
			self.move4.setBackgroundImage( XGFiles.TypeImage(pd.moves[3].type.rawValue).image , forState: .Normal)
			
			self.p1.layer.shadowColor = self.trainer.pokemon[0].isShadow ? UIColor.purpleColor().CGColor : UIColor.blackColor().CGColor
			self.p2.layer.shadowColor = self.trainer.pokemon[1].isShadow ? UIColor.purpleColor().CGColor : UIColor.blackColor().CGColor
			self.p3.layer.shadowColor = self.trainer.pokemon[2].isShadow ? UIColor.purpleColor().CGColor : UIColor.blackColor().CGColor
			self.p4.layer.shadowColor = self.trainer.pokemon[3].isShadow ? UIColor.purpleColor().CGColor : UIColor.blackColor().CGColor
			self.p5.layer.shadowColor = self.trainer.pokemon[4].isShadow ? UIColor.purpleColor().CGColor : UIColor.blackColor().CGColor
			self.p6.layer.shadowColor = self.trainer.pokemon[5].isShadow ? UIColor.purpleColor().CGColor : UIColor.blackColor().CGColor
			
			self.species.layer.shadowColor = self.pokemonData.isShadow ? UIColor.purpleColor().CGColor : UIColor.blackColor().CGColor
			
			self.hideActivityView()
		}
	}
	
	func setPokemon(index: Int) {
		self.pokemonData = XGTrainerPokemon(index: self.trainer.pokemon[index - 1].index)
		self.currentPokemonIndex = index - 1
		self.updateUI()
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! XGTableViewCell!
		if cell == nil {
			cell = XGTableViewCell(style: .Subtitle, reuseIdentifier: "cell")
		}
		
		let trainer = XGTrainer(index: indexPath.row)
		
		let name = trainer.trainerClass.name
		if name.length > 1 {
			switch name.chars[0] {
				case .Special(let s, let i) : name.chars[0...1] = [name.chars[1]]
				default: let k = 0
			}
		}
		
		cell.title = "\(name) \(trainer.name)"
		
		cell.picture = trainer.trainerModel.image
		cell.background = UIImage(named: "Item Cell")!
		
		cell.textLabel?.textColor = UIColor.blueColor()
//		cell.detailTextLabel?.textColor = UIColor.greenColor()
		
		if trainer.hasShadow {
			cell.background = XGFiles.NameAndFolder("shadow.png", .Types).image
		}
		
		return cell!
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		self.currentIndexPath = indexPath
		self.trainer = XGTrainer(index: indexPath.row)
		self.currentRow = indexPath.row
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return kNumberOfTrainerEntries
	}
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 75
	}
	
	override func popoverDidDismiss() {
		
		if popoverPresenter == species {
			self.pokemonData.species = selectedItem as! XGPokemon
		} else if popoverPresenter == move1 {
			self.pokemonData.moves[0] = selectedItem as! XGMoves
		} else if popoverPresenter == move2 {
			self.pokemonData.moves[1] = selectedItem as! XGMoves
		} else if popoverPresenter == move3 {
			self.pokemonData.moves[2] = selectedItem as! XGMoves
		} else if popoverPresenter == move4 {
			self.pokemonData.moves[3] = selectedItem as! XGMoves
		} else if popoverPresenter == nature {
			self.pokemonData.nature = selectedItem as! XGNatures
		} else if popoverPresenter == self.item {
			self.pokemonData.item = selectedItem as! XGItems
		}
		
		self.popoverPresenter.popover.dismissPopoverAnimated(true)
		self.updateUI()
	}
	
	func purgeBattleMode() {
		self.showActivityView { (Bool) -> Void in
			for var i = 479; i <= 777; i++ {
				XGTrainer(index: i).purge(autoSave: true)
			}
			self.hideActivityView()
		}
		
	}

	func save() {
		
		self.showActivityView { (Bool) -> Void in
			
			self.trainer.save()
			self.pokemonData.save()
			
			self.table.reloadRowsAtIndexPaths([self.currentIndexPath], withRowAnimation: .Fade)
			self.table.selectRowAtIndexPath(self.currentIndexPath, animated: false, scrollPosition: .None)
			
			self.hideActivityView()
			
			self.updateUI()
		
		}
	}
	
}


















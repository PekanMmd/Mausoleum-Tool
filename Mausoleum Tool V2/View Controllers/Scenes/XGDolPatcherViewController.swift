//
//  XGDolPatcherViewController.swift
//  XG Tool
//
//  Created by The Steez on 11/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGDolPatcherViewController: XGViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.title = "Randomiser"
		
		let applyButton = XGButton(title: "Randomise Pokemon", colour: UIColor.redColor(), textColour: UIColor.whiteColor(), action: {
			self.showActivityView { (Bool) -> Void in
				
				self.randomisePokemon()
				
			}
		})
		self.addSubview(applyButton, name: "randp")
		self.addConstraintSize(view: applyButton, height: 200, width: 350)
		
		let applyButton2 = XGButton(title: "Randomise Moves", colour: UIColor.blueColor(), textColour: UIColor.whiteColor(), action: {
			self.showActivityView { (Bool) -> Void in
				
				self.randomiseMoves()
				
			}
		})
		self.addSubview(applyButton2, name: "randm")
		self.addConstraintSize(view: applyButton2, height: 200, width: 350)
		
		self.addConstraintAlignCenterY(view1: self.contentView, view2: applyButton)
		self.createDummyViewsEqualWidths(3, baseName: "H")
		self.addConstraints(visualFormat: "H:|[H1][randp][H2][randm][H3]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		
		
	}
	
	func randomisePokemon() {
		self.showActivityView { (Bool) -> Void in
			
			var shadowDictionary : [Int : (XGPokemon,XGMoves,XGMoves,XGMoves,XGMoves) ] = [Int : (XGPokemon,XGMoves,XGMoves,XGMoves,XGMoves)]()
			
			for var i = 0; i < kNumberOfTrainerPokemonEntries; i++ {
				let pokemon = XGTrainerPokemon(index: i)
				if (pokemon.isShadow) && (shadowDictionary[pokemon.shadowID] != nil) {
					
					let data = shadowDictionary[pokemon.shadowID]!
					
					pokemon.species  = data.0
					pokemon.moves[0] = data.1
					pokemon.moves[1] = data.2
					pokemon.moves[2] = data.3
					pokemon.moves[3] = data.4
					
				} else if pokemon.species.index > 0 {
					
					pokemon.species  = XGPokemon.rand()
					pokemon.moves = pokemon.species.movesForLevel(pokemon.level)
					
					if pokemon.isShadow {
						shadowDictionary[pokemon.shadowID] = (pokemon.species,pokemon.moves[0],pokemon.moves[1],pokemon.moves[2],pokemon.moves[3])
					}
					
				}
				
				pokemon.pokeball = 4
				pokemon.nature = .Random
				pokemon.item = XGItems.Item(0)
				pokemon.IVs = pokemon.isShadow ? 0xFF : 0
				pokemon.EVs = [Int](count: 6, repeatedValue: 0)
				pokemon.ability = 0xFF
				pokemon.happiness = 0
				
				pokemon.save()
				
			}
			
			for var i = 0; i < 2; i++ {
				let pokemon = XGStarterPokemon(index: i)
				pokemon.species = XGPokemon.rand()
				let lumoves = pokemon.species.movesForLevel(pokemon.level)
				pokemon.move1 = lumoves[0]
				pokemon.move2 = lumoves[1]
				pokemon.move3 = lumoves[2]
				pokemon.move4 = lumoves[3]
				
				pokemon.save()
			}
			
			for var i = 0; i < kNumberOfDistroPokemon; i++ {
				let pokemon = XGDistroPokemon(index: i)
				pokemon.species = XGPokemon.rand()
				
				pokemon.save()
			}
			
			
		
			XGLZSS.Input(.Common_rel).compress()
			if XGFsys.Fsys(.FSYS("common.fsys")).replaceFileWithIndex(0, withFile: .LZSS("common_rel.lzss")) {
				XGAlertView.show(title: "Randomised Pokemon", message: "Pokemon Randomisation complete", doneButtonTitle: "Sweet", otherButtonTitles: nil, buttonAction: nil)
				self.hideActivityView()
			} else {
				self.hideActivityView()
			}
		}
	}
	
	func randomiseMoves() {
		self.showActivityView { (Bool) -> Void in
		
			for var i = 0; i < kNumberOfPokemon; i++ {
				let stats = XGPokemonStats(index: i)
				
				if stats.speciesNameID > 0 {
					
					for var i = 0; i < kNumberOfLevelUpMoves; i++ {
						if stats.levelUpMoves[i].move.index > 0 {
							stats.levelUpMoves[i].move = XGMoves.rand()
						}
					}
					
					stats.save()
				}
				
				var shadowDictionary : [Int : (XGPokemon,XGMoves,XGMoves,XGMoves,XGMoves) ] = [Int : (XGPokemon,XGMoves,XGMoves,XGMoves,XGMoves)]()
				
				for var i = 0; i < kNumberOfTrainerPokemonEntries; i++ {
					let pokemon = XGTrainerPokemon(index: i)
					if (pokemon.isShadow) && (shadowDictionary[pokemon.shadowID] != nil) {
						
						let data = shadowDictionary[pokemon.shadowID]!
						
						pokemon.moves[0] = data.1
						pokemon.moves[1] = data.2
						pokemon.moves[2] = data.3
						pokemon.moves[3] = data.4
						
					} else if pokemon.species.index > 0 {
						
						pokemon.moves[0] = XGMoves.rand()
						pokemon.moves[1] = XGMoves.rand()
						pokemon.moves[2] = XGMoves.rand()
						pokemon.moves[3] = XGMoves.rand()
						
						if pokemon.isShadow {
							shadowDictionary[pokemon.shadowID] = (pokemon.species,pokemon.moves[0],pokemon.moves[1],pokemon.moves[2],pokemon.moves[3])
						}
						
					}
					
					pokemon.save()
					
				}
				
				for var i = 0; i < 2; i++ {
					let pokemon = XGStarterPokemon(index: i)
					pokemon.move1 = XGMoves.rand()
					pokemon.move2 = XGMoves.rand()
					pokemon.move3 = XGMoves.rand()
					pokemon.move4 = XGMoves.rand()
					
					pokemon.save()
				}
				
			}
			
			
			XGLZSS.Input(.Common_rel).compress()
			if XGFsys.Fsys(.FSYS("common.fsys")).replaceFileWithIndex(0, withFile: .LZSS("common_rel.lzss")) {
				XGAlertView.show(title: "Randomised Moves", message: "Moves Randomisation complete", doneButtonTitle: "Sweet", otherButtonTitles: nil, buttonAction: nil)
				self.hideActivityView()
			} else {
				self.hideActivityView()
			}
		}
	}
	
	
	
	
}










//
//  Trainer.swift
//  Mausoleum Tool
//
//  Created by The Steez on 25/09/2014.
//  Copyright (c) 2014 Steezy. All rights reserved.
//

import UIKit

let kFirstTrainerOffset				= 0x92ED0
let kSizeOfTrainerData				= 0x34
let kNumberOfTrainerPokemon			= 0x06
let kNumberOfTrainerEntries			= 819

let kTrainerGenderOffset			= 0x00
let kTrainerClassOffset				= 0x03
let kTrainerFirstPokemonOffset		= 0x04
let kTrainerAIOffset				= 0x06
let kTrainerNameIDOffset			= 0x0A
let kTrainerBattleTransitionOffset	= 0x0C
let kTrainerClassModelOffset		= 0x13
let kTrainerPreBattleTextIDOffset	= 0x26
let kTrainerVictoryTextIDOffset		= 0x2A
let kTrainerDefeatTextIDOffset		= 0x2E
let kFirstTrainerLoseText2Offset	= 0x32
let kTrainerFirstItemOffset			= 0x14

class XGTrainer: NSObject {

	var index				= 0x0
	
	var ai					= 0x0
	
	var nameID				= 0x0
	var preBattleTextID		= 0x0
	var victoryTextID		= 0x0
	var DefeatTextID		= 0x0
	var shadowMask			= 0x0
	var pokemon				= [XGTrainerPokemon]()
	var trainerClass		= XGTrainerClasses.None1
	var trainerModel		= XGTrainerModels.Wes
	
	var startOffset : Int {
		get {
			return kFirstTrainerOffset + (index * kSizeOfTrainerData)
		}
	}
	
	var name : XGString {
		get {
			return XGStringTable.common_rel().stringSafelyWithID(self.nameID)
		}
	}
	
	var prizeMoney : Int {
		get {
			var maxLevel = 0
			
			for poke in self.pokemon {
				maxLevel = poke.level > maxLevel ? poke.level : maxLevel
			}
			
			return self.trainerClass.payout * 2 * maxLevel
		}
	}
	
	var hasShadow : Bool {
		get {
			for poke in self.pokemon {
				if poke.isShadow {
					return true
				}
			}
			return false
		}
	}
	
	init(index: Int) {
		super.init()
		
		self.index = index
		let start = startOffset
		
		let deck = XGFiles.Common_rel.data
		
		self.nameID =  deck.get2BytesAtOffset(start + kTrainerNameIDOffset)
		self.preBattleTextID = deck.get2BytesAtOffset(start + kTrainerPreBattleTextIDOffset)
		self.victoryTextID = deck.get2BytesAtOffset(start + kTrainerVictoryTextIDOffset)
		self.DefeatTextID = deck.get2BytesAtOffset(start + kTrainerDefeatTextIDOffset)
		self.ai = deck.get2BytesAtOffset(start + kTrainerAIOffset)
		
		let tClass = deck.getByteAtOffset(start + kTrainerClassOffset)
		let tModel = deck.getByteAtOffset(start + kTrainerClassModelOffset)
		
		self.trainerClass = XGTrainerClasses(rawValue: tClass) ?? .None1
		self.trainerModel = XGTrainerModels(rawValue: tModel)  ?? .Wes
		
		let first = deck.get2BytesAtOffset(start + kTrainerFirstPokemonOffset)
		for var i = 0; i < kNumberOfTrainerPokemon; i++ {
			self.pokemon.append(XGTrainerPokemon(index: (first + i)))
		}
		
	}
	
	func save() {
		
		let start = startOffset
		let deck = XGFiles.Common_rel.data
		
//		deck.replace2BytesAtOffset(start + kTrainerNameIDOffset, withBytes: self.nameID)
//		deck.replace2BytesAtOffset(start + kTrainerPreBattleTextIDOffset, withBytes: self.preBattleTextID)
//		deck.replace2BytesAtOffset(start + kTrainerVictoryTextIDOffset, withBytes: self.victoryTextID)
//		deck.replace2BytesAtOffset(start + kTrainerDefeatTextIDOffset, withBytes: self.DefeatTextID)
		
		deck.replace2BytesAtOffset(start + kTrainerAIOffset, withBytes: self.ai)
		deck.replaceByteAtOffset(start + kTrainerClassOffset , withByte: self.trainerClass.rawValue)
		deck.replaceByteAtOffset(start + kTrainerClassModelOffset, withByte: self.trainerModel.rawValue)
		
		deck.save()
	}
	
	func purge(autoSave autoSave: Bool) {
	
		for poke in self.pokemon {
			poke.purge()
			if autoSave {
				poke.save()
			}
		}
	
	}
   
}





























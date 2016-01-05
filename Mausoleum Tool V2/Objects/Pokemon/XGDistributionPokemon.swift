//
//  XGTradePokemon.swift
//  XG Tool
//
//  Created by The Steez on 11/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

let kPlusleOffset			= 0x12D9C8
let kHoohOffset				= 0x12D8E4
let kCelebiOffset			= 0x12D6B4
let kPikachuOffset			= 0x12D7C4

let kTradePokemonSpeciesOffset		=  0x02
let kTradePokemonLevelOffset		=  0x07

let kNumberOfDistroPokemon = 4

class XGDistroPokemon: NSObject, XGGiftPokemon {
	
	var index			= 0
	
	var level			= 0x0
	var species			= XGPokemon.Pokemon(0)
	var move1			= XGMoves.Move(0)
	var move2			= XGMoves.Move(0)
	var move3			= XGMoves.Move(0)
	var move4			= XGMoves.Move(0)
	
	var giftType		= ""
	
	// unused
	var exp				= -1
	var shinyValue		= XGShinyValues.Random
	
	var startOffset : Int {
		get {
			switch index {
				case 0 : return kPlusleOffset
				case 1 : return kHoohOffset
				case 2 : return kCelebiOffset
				default: return kPikachuOffset
			}
		}
	}
	
	init(index: Int) {
		super.init()
		
		let dol			= XGFiles.Dol.data
		self.index		= index
		
		let start = startOffset
		
		let species = dol.get2BytesAtOffset(start + kTradePokemonSpeciesOffset)
		self.species = .Pokemon(species)
		
		level = dol.getByteAtOffset(start + kTradePokemonLevelOffset)
		
		switch index {
			case 0  : self.giftType = "Duking's Plusle"
			case 1  : self.giftType = "Mt.Battle Ho-oh"
			case 2  : self.giftType = "Agate Celebi"
			default : self.giftType = "Agate Pikachu"
		}
		
	}
	
	func save() {
		
		let dol = XGFiles.Dol.data
		let start = startOffset
		
		dol.replaceByteAtOffset(start + kTradePokemonLevelOffset, withByte: level)
		dol.replace2BytesAtOffset(start + kTradePokemonSpeciesOffset, withBytes: species.index)
		
		
		dol.save()
	}
	
}



















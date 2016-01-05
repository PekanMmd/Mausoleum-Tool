//
//  XGPokemon.swift
//  XG Tool
//
//  Created by The Steez on 01/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

enum XGPokemon {
	
	case Pokemon(Int)
	
	var index : Int {
		get {
			switch self {
			case .Pokemon(let i): return i
			}
		}
	}
	
	var startOffset : Int {
		get{
			return kFirstPokemonOffset + (index * kSizeOfPokemonStats)
		}
	}
	
	var nameID : Int {
		get {
			return XGFiles.Common_rel.data.get2BytesAtOffset(startOffset + kNameIDOffset)
		}
	}
	
	var name : XGString {
		get {
			let table = XGStringTable.common_rel()
			return table.stringSafelyWithID(nameID)
		}
	}
	
	var face : UIImage {
		get {
			return XGFiles.PokeFace(self.index).image
		}
	}
	
	var body : UIImage {
		get {
			return XGFiles.PokeBody(self.index).image
		}
	}
	
	var ability1 : String {
		get {
			let a1 = XGFiles.Common_rel.data.getByteAtOffset(startOffset + kAbility1Offset)
			return XGAbilities.Ability(a1).name.string
		}
	}
	var ability2 : String {
		get {
			let a2 = XGFiles.Common_rel.data.getByteAtOffset(startOffset + kAbility2Offset)
			return XGAbilities.Ability(a2).name.string
		}
	}
	
	var type1 : XGMoveTypes {
		get {
			let type = XGFiles.Common_rel.data.getByteAtOffset(startOffset + kType1Offset)
			return XGMoveTypes(rawValue: type) ?? XGMoveTypes.Normal
		}
	}
	
	var type2 : XGMoveTypes {
		get {
			let type = XGFiles.Common_rel.data.getByteAtOffset(startOffset + kType2Offset)
			return XGMoveTypes(rawValue: type) ?? XGMoveTypes.Normal
		}
	}
	
	var catchRate : Int {
		get {
			return XGFiles.Common_rel.data.getByteAtOffset(startOffset + kCatchRateOffset)
		}
	}
	
	var expRate : XGExpRate {
		get {
			let rate = XGFiles.Common_rel.data.getByteAtOffset(startOffset + kEXPRateOffset)
			return XGExpRate(rawValue: rate) ?? .Slow
		}
	}
	
	func movesForLevel(pokeLevel: Int) -> [XGMoves] {
		// Returns the last 4 moves a pokemon would have learned at a level. Gives automatic move sets like in the GBA games.
		
		var moves = [XGMoves](count: 4, repeatedValue: XGMoves.Move(0))
		
		let levelUpMoves = XGPokemonStats(index: self.index).levelUpMoves
		
		var moveSlot = 0
		for move in levelUpMoves {
			if (move.level < pokeLevel) && (move.move.index > 0) {
				
				moves[(moveSlot % 4)] = move.move
				
			} else {
				return moves
			}
			moveSlot++
		}
		
		return moves
	}
	
	static func rand() -> XGPokemon {
		var rand = 0
		while (rand == 0) || ((rand > 251) && (rand < 277)) {
			rand = Int(arc4random_uniform(UInt32(kNumberOfPokemon - 1))) + 1
		}
		return XGPokemon.Pokemon(rand)
	}
	
}


enum XGOriginalPokemon {
	
	case Pokemon(Int)
	
	var index : Int {
		get {
			switch self {
				case .Pokemon(let i): return i
			}
		}
	}
	
	var startOffset : Int {
		get{
			return kFirstPokemonOffset + (index * kSizeOfPokemonStats)
		}
	}
	
	var nameID : Int {
		get {
			return XGResources.FDAT("common_rel").data.get2BytesAtOffset(startOffset + kNameIDOffset)
		}
	}
	
	var name : String {
		get {
			let table = XGStringTable.common_relOriginal()
			return table.stringSafelyWithID(nameID).string
		}
	}
	
	var type1 : XGMoveTypes {
		get {
			let type = XGResources.FDAT("common_rel").data.getByteAtOffset(startOffset + kType1Offset)
			return XGMoveTypes(rawValue: type) ?? XGMoveTypes.Normal
		}
	}
	
	var type2 : XGMoveTypes {
		get {
			let type = XGResources.FDAT("common_rel").data.getByteAtOffset(startOffset + kType2Offset)
			return XGMoveTypes(rawValue: type) ?? XGMoveTypes.Normal
		}
	}
	
}















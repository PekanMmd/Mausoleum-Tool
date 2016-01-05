//
//  Pokemon.swift
//  Mausoleum Tool
//
//  Created by The Steez on 03/10/2014.
//  Copyright (c) 2014 Steezy. All rights reserved.
//

import Foundation

let kFirstPokemonEntryOffset = 0x9FE28
let kNumberOfTrainerPokemonEntries = 5510

let kSizeOfPokemonData		= 0x50
let kNumberOfPokemonMoves	= 0x04
let kNumberOfEVs			= 0x06
let kNumberOfIVs			= 0x06

let kPokemonAbilityOffset	= 0x00
let kPokemonGenderOffset	= 0x01
let kPokemonNatureOffset	= 0x02
let kPokemonShadowIDOffset	= 0x03
let kPokemonLevelOffset		= 0x04
let kPokemonPriorityOffset	= 0x05
let kPokemonHappinessOffset	= 0x08
let kPokemonSpeciesOffset	= 0x0A
let kPokemonPokeballOffset	= 0x0D
let kPokemonItemOffset		= 0x12
let kPokemonNameIDOffset	= 0x16
let kFirstPokemonIVOffset	= 0x1C
let kFirstPokemonEVOffset	= 0x23

let kPokemonMove1Offset		= 0x36
let kPokemonMove2Offset		= 0x3E
let kPokemonMove3Offset		= 0x46
let kPokemonMove4Offset		= 0x4E

let kFFOffsets				= [0,1,2,8,9,0x10,0x11,0x12,0x13,0x1C,0x1D,0x1E,0x1F,0x20,0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D]

class XGTrainerPokemon : NSObject {
	
	var shadowID	= 0
	var index		= 0
	
	var species		= XGPokemon.Pokemon(0) {
		didSet {
			self.nameID = self.species.nameID
		}
	}
	var nameID		= 0
	var pokeball	= 0
	var level		= 0
	var happiness	= 0
	var ability		= 0
	var item		= XGItems.Item(0)
	var nature		= XGNatures.Hardy
	var gender		= XGGenders.Male
	var IVs			= 0x0 // All IVs will be the same. Not much point in varying them.
	var EVs			= [Int]()
	var moves		= [XGMoves](count: kNumberOfPokemonMoves, repeatedValue: XGMoves.Move(0))
	
	var startOffset : Int {
		get {
			return kFirstPokemonEntryOffset + (index * kSizeOfPokemonData)
		}
	}
	
	var isShadow : Bool {
		get {
			return self.shadowID > 0
		}
	}
	
	var isSet : Bool {
		get {
			return self.pokeball > 0
		}
	}
	
	init(index: Int) {
		super.init()
		
		self.index = index
		
		let data = XGFiles.Common_rel.data
		let start = self.startOffset
		
		let spec		= data.get2BytesAtOffset(start + kPokemonSpeciesOffset)
		species			= XGPokemon.Pokemon(spec)
		level			= data.getByteAtOffset(start + kPokemonLevelOffset)
		nameID			= data.get2BytesAtOffset(start + kPokemonNameIDOffset)
		
		shadowID		= data.getByteAtOffset(start + kPokemonShadowIDOffset)
		
		happiness		= data.getByteAtOffset(start + kPokemonHappinessOffset)
		let it			= data.get2BytesAtOffset(start + kPokemonItemOffset)
		item			= XGItems.Item(it)
		IVs				= data.getByteAtOffset(start + kFirstPokemonIVOffset)
		
		ability		= data.getByteAtOffset(start + kPokemonAbilityOffset)
		
		let gender	= data.getByteAtOffset(start + kPokemonGenderOffset)
		self.gender = XGGenders(rawValue: gender) ?? .Female
		
		let nature	= data.getByteAtOffset(start + kPokemonNatureOffset)
		self.nature	= XGNatures(rawValue: nature) ?? .Hardy
		
		for var i = 0; i < kNumberOfEVs; i++ {
			self.EVs.append(data.getByteAtOffset(start + kFirstPokemonEVOffset + (2 * i)))
		}
		
		moves[0] = XGMoves.Move(data.get2BytesAtOffset(start + kPokemonMove1Offset))
		moves[1] = XGMoves.Move(data.get2BytesAtOffset(start + kPokemonMove2Offset))
		moves[2] = XGMoves.Move(data.get2BytesAtOffset(start + kPokemonMove3Offset))
		moves[3] = XGMoves.Move(data.get2BytesAtOffset(start + kPokemonMove4Offset))
		
	}
	
	
	func save() {
		
		let data = XGFiles.Common_rel.data
		let start = startOffset
		
		if self.species.index > 0 {
			data.replaceByteAtOffset(start + kPokemonPokeballOffset, withByte: 0x4)
			for offset in kFFOffsets {
				data.replaceByteAtOffset(start + offset, withByte: 0xFF)
			}
		} else {
			data.replaceByteAtOffset(start + kPokemonPokeballOffset, withByte: 0x0)
			for offset in kFFOffsets {
				data.replaceByteAtOffset(start + offset, withByte: 0x00)
			}
			self.purge()
		}
		
		data.replace2BytesAtOffset(start + kPokemonSpeciesOffset, withBytes: species.index)
		data.replace2BytesAtOffset(start + kPokemonNameIDOffset, withBytes: species.nameID)
		data.replace2BytesAtOffset(start + kPokemonItemOffset, withBytes: item.index)
		data.replaceByteAtOffset(start + kPokemonHappinessOffset, withByte: happiness)
		data.replaceByteAtOffset(start + kPokemonLevelOffset, withByte: level)
		
		data.replaceByteAtOffset(start + kPokemonAbilityOffset, withByte: ability)
		data.replaceByteAtOffset(start + kPokemonNatureOffset, withByte: nature.rawValue)
		data.replaceByteAtOffset(start + kPokemonGenderOffset, withByte: gender.rawValue)
		
		let IVs = [Int](count: kNumberOfIVs, repeatedValue: self.IVs)
		data.replaceBytesFromOffset(start + kFirstPokemonIVOffset, withByteStream: IVs)
		
		for var i = 0; i < kNumberOfEVs; i++ {
			data.replaceByteAtOffset(start + kFirstPokemonEVOffset + (2 * i), withByte: EVs[i])
		}
		
		data.replaceBytesFromOffset(start + kFirstPokemonEVOffset, withByteStream: self.EVs)
		
		data.replace2BytesAtOffset(start + kPokemonMove1Offset, withBytes: moves[0].index)
		data.replace2BytesAtOffset(start + kPokemonMove2Offset, withBytes: moves[1].index)
		data.replace2BytesAtOffset(start + kPokemonMove3Offset, withBytes: moves[2].index)
		data.replace2BytesAtOffset(start + kPokemonMove4Offset, withBytes: moves[3].index)
		
		
		
		data.save()
	}
	
	func purge() {
		
		species		= XGPokemon.Pokemon(0)
		nameID		= 0
		pokeball	= 0
		level		= 1
		happiness	= 0
		ability		= 0
		item		= XGItems.Item(0)
		nature		= XGNatures.Hardy
		gender		= XGGenders.Male
		IVs			= 0
		EVs			= [Int](count: 6, repeatedValue: 0)
		moves		= [XGMoves](count: kNumberOfPokemonMoves, repeatedValue: XGMoves.Move(0))
	}


}






















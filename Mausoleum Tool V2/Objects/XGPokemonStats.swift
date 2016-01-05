//
//  Pokemon.swift
//  Mausoleum Stats Tool
//
//  Created by The Steez on 26/12/2014.
//  Copyright (c) 2014 Ovation International. All rights reserved.
// 475c4 4e258 cc77-56d cc85-56e cd1d-14d8

import UIKit

let kNumberOfPokemon		= 0x19C
let kSizeOfPokemonStats		= 0x11C
let kFirstPokemonOffset		= 0x123250

let kEXPRateOffset			= 0x00
let kCatchRateOffset		= 0x01
let kGenderRatioOffset		= 0x02
let kBaseEXPOffset			= 0x07
let kBaseHappinessOffset	= 0x09

let kType1Offset			= 0x30
let kType2Offset			= 0x31

let kAbility1Offset			= 0x32
let kAbility2Offset			= 0x33

let kFirstTMOffset			= 0x34
let kFirstEVYieldOffset		= 0x90 // 1 byte between each one.
let kFirstEvolutionOffset	= 0x9C
let kFirstLevelUpMoveOffset	= 0xBA

let kHeldItem1Offset		= 0x70
let kHeldItem2Offset		= 0x72

let kHPOffset				= 0x85
let kAttackOffset			= 0x87
let kDefenseOffset			= 0x89
let kSpecialAttackOffset	= 0x8B
let kSpecialDefenseOffset	= 0x8D
let kSpeedOffset			= 0x8F

let kNameIDOffset			= 0x1A
let kPokemonCryIndexOffset	= 0x0E
let kSpeciesNameIDOffset	= 0x1E

let kPokemonModelIndexOffset = 0x2E // Same as pokemon's index
let kPokemonFaceIndexOffset	 = 0x10E // Same as Pokemon's national dex index

class XGPokemonStats: NSObject {
	
	var index			= 0x0
	var startOffset		= 0x0
	
	var nameID			= 0x0
	var speciesNameID	= 0x0
	var cryIndex		= 0x0
	var modelIndex		= 0x0
	var faceIndex		= 0x0
	
	var levelUpRate		= XGExpRate.Standard
	var genderRatio     = XGGenderRatios.MaleOnly
	
	var catchRate		= 0x0
	var baseExp			= 0x0
	var baseHappiness	= 0x0
	
	var type1			= XGMoveTypes.Normal
	var type2			= XGMoveTypes.Normal
	
	var ability1		= XGAbilities.Ability(0)
	var ability2		= XGAbilities.Ability(0)
	
	var heldItem1		= 0
	var heldItem2		= 0
	
	var hp				= 0x0
	var speed			= 0x0
	var attack			= 0x0
	var defense			= 0x0
	var specialAttack	= 0x0
	var specialDefense	= 0x0
	
	var levelUpMoves	= [XGLevelUpMove]()
	var learnableTMs	= [Bool]()
	var tutorMoves		= [Bool]()
	var evolutions		= [XGEvolution]()
	
	var name : XGString {
		get {
			return XGStringTable.common_rel().stringSafelyWithID(self.nameID)
		}
	}
	
	var species : XGString {
		get {
			let file = XGFiles.NameAndFolder("pda_menu.fdat", .StringTables)
			return XGStringTable(file: file, startOffset: 0, fileSize: file.fileSize).stringSafelyWithID(self.speciesNameID)
		}
	}
	
	var numberOfTMs : Int {
		get {
			return learnableTMs.filter{ $0 }.count
		}
	}
	
	var numberOfLevelUpMoves : Int {
		get {
			return levelUpMoves.filter{ $0.isSet() }.count
		}
	}
	
	var numberOfEvolutions : Int {
		get {
			return evolutions.filter{ $0.isSet() }.count
		}
	}
	
	init(index : Int!) {
		super.init()
		
		let rel = XGFiles.Common_rel.data
		
		self.startOffset	= kFirstPokemonOffset + ( kSizeOfPokemonStats * index )
		self.index			= index
		
		self.nameID			= rel.get2BytesAtOffset(startOffset + kNameIDOffset)
		self.speciesNameID  = rel.get2BytesAtOffset(startOffset + kSpeciesNameIDOffset)
		self.cryIndex		= rel.get2BytesAtOffset(startOffset + kPokemonCryIndexOffset)
		self.modelIndex		= rel.get2BytesAtOffset(startOffset + kPokemonModelIndexOffset)
		self.faceIndex		= rel.get2BytesAtOffset(startOffset + kPokemonFaceIndexOffset)
		
		self.levelUpRate	= XGExpRate(rawValue: rel.getByteAtOffset(startOffset + kEXPRateOffset))!
		self.genderRatio	= XGGenderRatios(rawValue: rel.getByteAtOffset(startOffset + kGenderRatioOffset))!
		
		self.catchRate		= rel.getByteAtOffset(startOffset + kCatchRateOffset)
		self.baseExp		= rel.getByteAtOffset(startOffset + kBaseEXPOffset)
		self.baseHappiness	= rel.getByteAtOffset(startOffset + kBaseHappinessOffset)
		
		self.type1			= XGMoveTypes(rawValue: rel.getByteAtOffset(startOffset + kType1Offset))!
		self.type2			= XGMoveTypes(rawValue: rel.getByteAtOffset(startOffset + kType2Offset))!
		
		let a1				= rel.getByteAtOffset(startOffset + kAbility1Offset)
		let a2				= rel.getByteAtOffset(startOffset + kAbility2Offset)
		self.ability1		= .Ability(a1)
		self.ability2		= .Ability(a2)
		
		let i1				= rel.get2BytesAtOffset(startOffset + kHeldItem1Offset)
		let i2				= rel.get2BytesAtOffset(startOffset + kHeldItem2Offset)
		self.heldItem1		= i1
		self.heldItem2		= i2
		
		self.hp				= rel.getByteAtOffset(startOffset + kHPOffset)
		self.attack			= rel.getByteAtOffset(startOffset + kAttackOffset)
		self.defense		= rel.getByteAtOffset(startOffset + kDefenseOffset)
		self.specialAttack	= rel.getByteAtOffset(startOffset + kSpecialAttackOffset)
		self.specialDefense	= rel.getByteAtOffset(startOffset + kSpecialDefenseOffset)
		self.speed			= rel.getByteAtOffset(startOffset + kSpeedOffset)
		
		var currentOffset = startOffset + kFirstTMOffset
		
		for var i = 0; i < kNumberOfTMs ; i++ {
			
			self.learnableTMs.append(rel.getByteAtOffset(startOffset + kFirstTMOffset + i) == 1)
			
		}
		
		for var i = 0; i < kNumberOfLevelUpMoves; i++ {
			
			let currentOffset = startOffset + kFirstLevelUpMoveOffset + (i * kSizeOfLevelUpData)
			
			let level = rel.getByteAtOffset(currentOffset + kLevelUpMoveLevelOffset)
			let move  = rel.get2BytesAtOffset(currentOffset + kLevelUpMoveIndexOffset)
			
			self.levelUpMoves.append(XGLevelUpMove(level: level, move: move))
		}
		
		for var i = 0; i < kNumberOfEvolutions; i++ {
			
			let currentOffset = startOffset + kFirstEvolutionOffset + (i * kSizeOfEvolutionData)
			
			let method		= rel.getByteAtOffset(currentOffset + kEvolutionMethodOffset)
			let condition	= rel.get2BytesAtOffset(currentOffset + kEvolutionConditionOffset)
			let evolution	= rel.get2BytesAtOffset(currentOffset + kEvolvedFormOffset)
			
			self.evolutions.append(XGEvolution(evolutionMethod: method, condition: condition, evolvedForm: evolution))
		}
		
	}
	
	func save() {
		
		let rel	= XGFiles.Common_rel.data

		rel.replace2BytesAtOffset(startOffset + kNameIDOffset, withBytes: nameID)
		rel.replace2BytesAtOffset(startOffset + kSpeciesNameIDOffset, withBytes: speciesNameID)
		rel.replace2BytesAtOffset(startOffset + kPokemonCryIndexOffset, withBytes: cryIndex)
		rel.replace2BytesAtOffset(startOffset + kPokemonModelIndexOffset, withBytes: modelIndex)
		rel.replace2BytesAtOffset(startOffset + kPokemonFaceIndexOffset, withBytes: faceIndex)
		
		rel.replaceByteAtOffset(startOffset + kEXPRateOffset, withByte: levelUpRate.rawValue)
		rel.replaceByteAtOffset(startOffset + kGenderRatioOffset, withByte: genderRatio.rawValue)
		
		rel.replaceByteAtOffset(startOffset + kCatchRateOffset, withByte: catchRate)
		rel.replaceByteAtOffset(startOffset + kBaseEXPOffset, withByte: baseExp)
		rel.replaceByteAtOffset(startOffset + kBaseHappinessOffset, withByte: baseHappiness)
		
		rel.replaceByteAtOffset(startOffset + kType1Offset, withByte: type1.rawValue)
		rel.replaceByteAtOffset(startOffset + kType2Offset, withByte: type2.rawValue)
		
		rel.replaceByteAtOffset(startOffset + kAbility1Offset, withByte: ability1.index)
		rel.replaceByteAtOffset(startOffset + kAbility2Offset, withByte: ability2.index)
		
		rel.replace2BytesAtOffset(startOffset + kHeldItem1Offset, withBytes: heldItem1)
		rel.replace2BytesAtOffset(startOffset + kHeldItem2Offset, withBytes: heldItem2)
		
		rel.replaceByteAtOffset(startOffset + kHPOffset, withByte: hp)
		rel.replaceByteAtOffset(startOffset + kAttackOffset, withByte: attack)
		rel.replaceByteAtOffset(startOffset + kDefenseOffset, withByte: defense)
		rel.replaceByteAtOffset(startOffset + kSpecialAttackOffset, withByte: specialAttack)
		rel.replaceByteAtOffset(startOffset + kSpecialDefenseOffset, withByte: specialDefense)
		rel.replaceByteAtOffset(startOffset + kSpeedOffset, withByte: speed)
		
		
		let currentOffset = startOffset + kFirstTMOffset
		
		for var i = 0; i < kNumberOfTMs ; i++ {
			
			rel.replaceByteAtOffset(currentOffset + i, withByte: learnableTMs[i] ? 1 : 0)
			
		}
		
		for var i = 0; i < kNumberOfLevelUpMoves; i++ {
			
			let currentOffset = startOffset + kFirstLevelUpMoveOffset + (i * kSizeOfLevelUpData)
			let (lev, mov) = levelUpMoves[i].toInts()
			
			rel.replaceByteAtOffset(currentOffset + kLevelUpMoveLevelOffset, withByte: lev)
			rel.replace2BytesAtOffset(currentOffset + kLevelUpMoveIndexOffset, withBytes: mov)
		}
		
		for var i = 0; i < kNumberOfEvolutions; i++ {
			
			let currentOffset = startOffset + kFirstEvolutionOffset + (i * kSizeOfEvolutionData)
			let (method, condition, evolution) = evolutions[i].toInts()
			
			rel.replaceByteAtOffset(currentOffset + kEvolutionMethodOffset, withByte: method)
			rel.replace2BytesAtOffset(currentOffset + kEvolutionConditionOffset, withBytes: condition)
			rel.replace2BytesAtOffset(currentOffset + kEvolvedFormOffset, withBytes: evolution)
		}
		
		rel.save()
		
	}
}



















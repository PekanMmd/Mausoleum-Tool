//
//  XGStarterPokemon.swift
//  XG Tool
//
//  Created by The Steez on 09/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

let kEspeonStartOffset = 0x12DAC8
let kUmbreonStartOffset	 = 0x12DBF0

let kDemoStarterSpeciesOffset		= 0x02
let kDemoStarterLevelOffset			= 0x07
let kDemoStarterMove1Offset			= 0x16
let kDemoStarterMove2Offset			= 0x26
let kDemoStarterMove3Offset			= 0x36
let kDemoStarterMove4Offset			= 0x46
let kDemoStarterShinyValueOffset	= 0x5E
let kDemoStarterExpValueOffset		= 0x92

class XGStarterPokemon: NSObject, XGGiftPokemon {
	
	var index			= 0
	
	var level			= 0
	var species			= XGPokemon.Pokemon(0)
	var move1			= XGMoves.Move(0)
	var move2			= XGMoves.Move(0)
	var move3			= XGMoves.Move(0)
	var move4			= XGMoves.Move(0)
	
	var giftType		= "Demo Starter Pokemon"
	
	var startOffset : Int {
		get {
			return index == 0 ? kEspeonStartOffset : kUmbreonStartOffset
		}
	}
	
	init(index: Int) {
		super.init()
		
		let dol			= XGFiles.Dol.data
		self.index		= index
		
		let start = startOffset
		
		level = dol.getByteAtOffset(start + kDemoStarterLevelOffset)
		
		let species = dol.get2BytesAtOffset(start + kDemoStarterSpeciesOffset)
		self.species = .Pokemon(species)
		
		var moveIndex = dol.get2BytesAtOffset(start + kDemoStarterMove1Offset)
		move1 = .Move(moveIndex)
		moveIndex = dol.get2BytesAtOffset(start + kDemoStarterMove2Offset)
		move2 = .Move(moveIndex)
		moveIndex = dol.get2BytesAtOffset(start + kDemoStarterMove3Offset)
		move3 = .Move(moveIndex)
		moveIndex = dol.get2BytesAtOffset(start + kDemoStarterMove4Offset)
		move4 = .Move(moveIndex)
		
	}
	
	func save() {
		
		let dol = XGFiles.Dol.data
		let start = startOffset
		
		dol.replaceByteAtOffset(start + kDemoStarterLevelOffset, withByte: level)
		dol.replace2BytesAtOffset(start + kDemoStarterSpeciesOffset, withBytes: species.index)
		dol.replace2BytesAtOffset(start + kDemoStarterMove1Offset, withBytes: move1.index)
		dol.replace2BytesAtOffset(start + kDemoStarterMove2Offset, withBytes: move2.index)
		dol.replace2BytesAtOffset(start + kDemoStarterMove3Offset, withBytes: move3.index)
		dol.replace2BytesAtOffset(start + kDemoStarterMove4Offset, withBytes: move4.index)
		
		dol.save()
	}
	
}


















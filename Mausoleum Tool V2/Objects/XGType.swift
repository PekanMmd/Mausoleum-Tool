//
//  XGTypeData.swift
//  XG Tool
//
//  Created by The Steez on 19/05/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

let kFirstTypeOffset = 0x358500
let kCategoryOffset = 0x0
let kTypeIconIDOffset = 0x03
let kTypeNameIDOffset = 0x6
let kFirstEffectivenessOffset = 0x9
let kSizeOfTypeData = 0x2C

let kNumberOfTypes = 0x12

class XGType: NSObject {
	// The type data is in Start.Dol in colosseum
	
	var index				 = 0
	var nameID				 = 0
	var category			 = XGMoveCategories.None
	var effectivenessTable	 = [XGEffectivenessValues]()
	var type				 = XGMoveTypes.Normal
	
	var startOffset = 0
	
	init(index: Int) {
		super.init()
		
		let dol			= XGFiles.Dol.data
		self.index		= index
		startOffset		= kFirstTypeOffset + (index * kSizeOfTypeData)
		
		
		self.type		= XGMoveTypes(rawValue: index)!
		self.nameID		= dol.get2BytesAtOffset(startOffset + kTypeNameIDOffset)
		self.category	= XGMoveCategories(rawValue: dol.getByteAtOffset(startOffset + kCategoryOffset))!
		
		var offset = startOffset + kFirstEffectivenessOffset
		
		for var i = 0; i < kNumberOfTypes; i++ {
			
			let value = dol.getByteAtOffset(offset)
			let effectiveness = XGEffectivenessValues(rawValue: value)!
			effectivenessTable.append(effectiveness)
			
			offset += 2
			
		}
		
	}
	
	func save() {
		
		let dol = XGFiles.Dol.data
		
		dol.replaceByteAtOffset(startOffset + kCategoryOffset, withByte: self.category.rawValue)
		
		for var i = 0; i < self.effectivenessTable.count; i++ {
			
			let value = effectivenessTable[i].rawValue
			dol.replaceByteAtOffset(startOffset + kFirstEffectivenessOffset + (i * 2), withByte: value)
			// i*2 because each value is 2 bytes apart
			
		}
		
		dol.save()
	}
	
	
}












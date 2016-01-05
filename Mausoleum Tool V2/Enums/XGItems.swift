//
//  XGPokemon.swift
//  XG Tool
//
//  Created by The Steez on 01/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import Foundation

let kNumberOfItems				= 0x18D
let kFirstItemOffset			= 0x360CE8
let kSizeOfItemData				= 0x28
//let kNumberOfFriendShipEffects	= 0x03

let kBagSlotOffset				 = 0x00
//let kItemCantBeHeldOffset		 = 0x01
//let kInBattleUseItemIDOffset	 = 0x04 // Items that can be used on your pokemon in battle
let kItemPriceOffset			 = 0x06
let kItemCouponCostOffset		 = 0x08
//let kItemBattleHoldItemIDOffset  = 0x0B
let kItemNameIDOffset			 = 0x12
let kItemDescriptionIDOffset	 = 0x16
let kItemParameterOffset		 = 0x1B
//let kFirstFriendshipEffectOffset = 0x24 // Signed Int

enum XGItems {
	
	case Item(Int)
	
	var index : Int {
		get {
			switch self {
				case .Item(let i): return i
			}
		}
	}
	
	var startOffset : Int {
		get{
			return kFirstItemOffset + (index * kSizeOfItemData)
		}
	}
	
	var nameID : Int {
		get {
			let data  = XGFiles.Dol.data
			return data.get2BytesAtOffset(startOffset + kItemNameIDOffset)
		}
	}
	
	var descriptionID : Int {
		get {
			let data  = XGFiles.Dol.data
			return data.get2BytesAtOffset(startOffset + kItemDescriptionIDOffset)
		}
	}
	
	var name : XGString {
		get {
			if index > kNumberOfItems {
				return XGString(string: "Random", file: .NameAndFolder("",.Documents), sid: 0)
			}
			
			let table = XGStringTable.common_rel()
			return table.stringSafelyWithID(nameID)
		}
	}
	
	var descriptionString : XGString {
		get {
			let table = XGFiles.StringTable("pocket_menu.fdat").stringTable
			return table.stringSafelyWithID(descriptionID)
		}
	}
	
}

enum XGOriginalItems {
	
	case Item(Int)
	
	var index : Int {
		get {
			switch self {
			case .Item(let i): return i
			}
		}
	}
	
	var startOffset : Int {
		get{
			return kFirstItemOffset + (index * kSizeOfItemData)
		}
	}
	
	var nameID : Int {
		get {
			let data  = XGResources.FDAT("common_rel").data
			return data.get2BytesAtOffset(startOffset + kItemNameIDOffset)
		}
	}
	
	var name : XGString {
		get {
			let table = XGStringTable.common_relOriginal()
			return table.stringSafelyWithID(nameID)
		}
	}
	
}












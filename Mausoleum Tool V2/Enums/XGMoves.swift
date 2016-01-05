//
//  XGMoves.swift
//  XG Tool
//
//  Created by The Steez on 01/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import Foundation

let kFirstShadowMoveIndex	= 0x164
let kLastShadowMoveIndex	= 0x164

enum XGMoves {
	
	case Move(Int)
	
	var index : Int {
		get {
			switch self {
				case .Move(let i): return i
			}
		}
	}
	
	var startOffset : Int {
		get {
			if index > kNumberOfMoves {
				return kFirstMoveOffset
			}
			return kFirstMoveOffset + (index * kSizeOfMoveData)
		}
	}
	
	var nameID : Int {
		get {
			return XGFiles.Common_rel.data.get2BytesAtOffset(startOffset + kMoveNameIDOffset)
		}
	}
	
	var name : XGString {
		get {
			return XGStringTable.common_rel().stringSafelyWithID(nameID)
		}
	}
	
	var descriptionID : Int {
		get {
			return XGFiles.Common_rel.data.get2BytesAtOffset(startOffset + kMoveDescriptionIDOffset)
		}
	}
	
	var description : XGString {
		get {
			return XGStringTable.dol().stringSafelyWithID(descriptionID)
		}
	}
	
	var type : XGMoveTypes {
		get {
			let index = XGFiles.Common_rel.data.getByteAtOffset(startOffset + kMoveTypeOffset)
			return XGMoveTypes(rawValue: index) ?? .Normal
		}
	}
	
	var animation : Int {
		get {
			return XGFiles.Common_rel.data.getByteAtOffset(startOffset + kAnimationIndexOffset)
		}
	}
	
	var isShadowMove : Bool {
		get {
			return self.index == 0x164
		}
	}
	
	static func rand() -> XGMoves {
		var rand = 0
		while (rand == 0) || (rand == 0x163) {
			rand = Int(arc4random_uniform(UInt32(kNumberOfMoves - 1))) + 1
		}
		return XGMoves.Move(rand)
	}
	
}

enum XGOriginalMoves {
	
	case Move(Int)
	
	var index : Int {
		get {
			switch self {
			case .Move(let i): return i
			}
		}
	}
	
	var startOffset : Int {
		get {
			return XGMoves.Move(index).startOffset
		}
	}
	
	var nameID : Int {
		get {
			return XGResources.FDAT("common_rel").data.get2BytesAtOffset(startOffset + kMoveNameIDOffset)
		}
	}
	
	var name : XGString {
		get {
			let table = XGStringTable.common_relOriginal()
			return table.stringSafelyWithID(nameID)
		}
	}
	
	var type : XGMoveTypes {
		get {
			let index = XGResources.FDAT("common_rel").data.getByteAtOffset(startOffset + kMoveTypeOffset)
			return XGMoveTypes(rawValue: index) ?? .Normal
		}
	}
	
	var animation : Int {
		get {
			return XGResources.FDAT("common_rel").data.get2BytesAtOffset(startOffset + kAnimationIndexOffset)
		}
	}
	
	var isShadowMove : Bool {
		get {
			return (self.index >= kFirstShadowMoveIndex) && (self.index <= kLastShadowMoveIndex)
		}
	}
	
}

































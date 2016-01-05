//
//  XGTrainerClass.swift
//  XG Tool
//
//  Created by The Steez on 16/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

let kFirstTrainerClassDataOffset	= 0x90F70
let kSizeOfTrainerClassEntry		= 0x0C
let kNumberOfTrainerClasses			= 42

// Prize money is payout * max pokemon level * 2
let kTrainerClassPayoutOffset		= 0x00
let kTrainerClassNameIDOffset		= 0x06

class XGTrainerClass: NSObject {
	
	var payout = 0
	var nameID = 0
	
	var tClass = XGTrainerClasses.None1
	
	var name : XGString {
		get {
			return XGStringTable.common_rel().stringSafelyWithID(self.nameID)
		}
	}
	
	var startOffset : Int {
		get {
			return kFirstTrainerClassDataOffset + (self.tClass.rawValue * kSizeOfTrainerClassEntry)
		}
	}
	
	init(tClass : XGTrainerClasses) {
		super.init()
		
		self.tClass = tClass
		
		let rel = XGFiles.Common_rel.data
		let start = self.startOffset
		
		self.payout = rel.get2BytesAtOffset(start + kTrainerClassPayoutOffset)
		self.nameID = rel.get2BytesAtOffset(start + kTrainerClassNameIDOffset)
		
	}
	
	func save() {
		
		let rel = XGFiles.Common_rel.data
		let start = self.startOffset
		
		rel.replace2BytesAtOffset(start + kTrainerClassNameIDOffset, withBytes: self.nameID)
		rel.replace2BytesAtOffset(start + kTrainerClassPayoutOffset, withBytes: self.payout)
		rel.save()
	}
   
}




















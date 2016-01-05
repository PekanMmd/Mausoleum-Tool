//
//  XGString.swift
//  XG Tool
//
//  Created by The Steez on 25/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGString: NSObject {
	
	var chars = [XGUnicodeCharacters]()
	
	var table = XGFiles.NameAndFolder("", .Documents)
	var id	  = 0
	
	var length : Int {
		get {
			var count = 0
			for char in chars {
				count += char.length
			}
			return count
		}
	}
	
	override var description : String {
		get {
			return string
		}
	}
	
	var string : String {
		get {
			var str = ""
			for char in chars {
				str = str + char.string
			}
			return str
		}
	}
	
	var stringPlusIDAndFile : String {
		get {
			return String(format: "ID  : 0x%x \nFile: \(table.fileName)\n\n\(string)", id)
		}
	}
	
	var byteStream : [UInt8] {
		get {
			var stream = [UInt8]()
			for char in chars {
				stream = stream + char.byteStream
			}
			return stream
		}
	}
	
	override func isEqual(object: AnyObject?) -> Bool {
		
		if object == nil {
			return false
		}
		
		if !(object!.isKindOfClass(XGString)) {
			return false
		}
		
		let cmpstr = object! as! XGString
		
		return self.string == cmpstr.string
		
	}
	
	func copyString() {
		let pb = UIPasteboard.generalPasteboard()
		pb.string = self.string
	}
	
	func append(char: XGUnicodeCharacters) {
		self.chars.append(char)
	}
	
	init(string: String, file: XGFiles?, sid: Int?) {
		super.init()
		
		self.table = file ?? XGFiles.NameAndFolder("", .Documents)
		self.id = sid ?? 0
		
		var chars = [XGUnicodeCharacters]()
		
		var current   = string.startIndex
		let end		  = string.endIndex
		
		while current != end {
			
			var char = string.substringWithRange(Range<String.Index>(start: current,end: current.advancedBy(1)))
			current = current.advancedBy(1)
			
			if char == "[" {
				var midString = ""
				
				char = string.substringWithRange(Range<String.Index>(start: current,end: current.advancedBy(1)))
				current = current.advancedBy(1)
				
				while char != "]" {
					midString = midString + char
					
					char = string.substringWithRange(Range<String.Index>(start: current,end: current.advancedBy(1)))
					current = current.advancedBy(1)
				}
				
				let sp = XGSpecialCharacters.fromString(midString)
				var extraBytes = [Int]()
				
				if sp.extraBytes > 0 {
					current = current.advancedBy(1)
					
					for var i = 0; i < sp.extraBytes; i++ {
						
						var byte = ""
						char = string.substringWithRange(Range<String.Index>(start: current,end: current.advancedBy(1)))
						current = current.advancedBy(1)
						byte = byte + char
						
						char = string.substringWithRange(Range<String.Index>(start: current,end: current.advancedBy(1)))
						current = current.advancedBy(1)
						byte = byte + char
						
						extraBytes.append(XGUnicodeCharacters.hexStringToInt(byte))
						
					}
					current = current.advancedBy(1)
				}
				
				let ch = XGUnicodeCharacters.Special(sp, extraBytes)
				chars.append(ch)
				
			} else {
				
				let charScalar = String(char).unicodeScalars
				let charValue  = Int(charScalar[charScalar.startIndex].value)
				
				let ch = XGUnicodeCharacters.Unicode(charValue)
				chars.append(ch)
				
			}
			
		}
		
		self.chars = chars
	}
	
	func replace(alert: Bool) -> Bool {
		if self.id == 0 {
			return false
		}
		return self.table.stringTable.replaceString(self, alert: alert)
	}
	
	func containsSubstring(sub: String) -> Bool {
		return self.string.rangeOfString(sub, options: .CaseInsensitiveSearch, range: nil, locale: nil) != nil
	}
	
	func replaceSubstring(sub: String, withString new: String, verbose: Bool) {
		let str = self.string.stringByReplacingOccurrencesOfString(sub, withString: new, options: [], range: nil)
		self.duplicateWithString(str).replace(verbose)
	}
	
	func duplicateWithString(str: String) -> XGString {
		return XGString(string: str, file: self.table, sid: self.id)
	}
   
}


















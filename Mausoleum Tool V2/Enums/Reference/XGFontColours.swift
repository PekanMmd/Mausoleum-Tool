//
//  XGFontColours.swift
//  XG Tool
//
//  Created by The Steez on 10/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import Foundation

let kNumberOfPredefinedFontColours =  6
let kNumberOfSpecifiedFontColours  = 12

enum XGFontColours : Int {
	
	case White		= 0x00
	case Yellow		= 0x01
	case Green		= 0x02
	case DarkBlue	= 0x03
	case Orange		= 0x04
	case Black		= 0x05
	
	var name : String {
		get {
			var str = ""
			switch self {
				case .White			: str = "White"
				case .Yellow		: str = "Yellow"
				case .Green			: str = "Green"
				case .DarkBlue		: str = "Dark Blue"
				case .Orange		: str = "Orange"
				case .Black			: str = "Black"
			}
			return "Predefined " + str
		}
	}
	
	var unicode : XGUnicodeCharacters {
		get {
			return .PredefinedFontColour(self)
		}
	}
	
	var specialUnicode : XGUnicodeCharacters {
		get {
			return .Special(.ChangeColourPredefined, self.bytes)
		}
	}
	
	var string : XGString {
		get {
			return XGString(string: specialUnicode.string, file: nil, sid: nil)
		}
	}
	
	var bytes : [Int] {
		get {
			return [self.rawValue]
		}
	}
	
}

enum XGRGBAFontColours : Int {
	
	case Red		= 0
	case Green
	case Blue
	case Yellow
	case Cyan
	case Magenta
	case LightGreen
	case Orange
	case Purple
	case Grey
	case White
	case Black
	
	var name : String {
		get {
			var str = ""
			switch self {
				case .Red			: str =  "Red"
				case .Green			: str =  "Green"
				case .Blue			: str =  "Blue"
				case .Yellow		: str =  "Yellow"
				case .Cyan			: str =  "Cyan"
				case .Magenta		: str =  "Magenta"
				case .LightGreen	: str =  "Light Green"
				case .Orange		: str =  "Orange"
				case .Purple		: str =  "Purple"
				case .Grey			: str =  "Grey"
				case .White			: str =  "White"
				case .Black			: str =  "Black"
			}
			return "Specified " + str
		}
	}
	
	var unicode : XGUnicodeCharacters {
		get {
			return XGUnicodeCharacters.SpecifiedFontColour(self)
		}
	}
	
	var specialUnicode : XGUnicodeCharacters {
		get {
			return .Special(.ChangeColourSpecified, self.bytes)
		}
	}
	
	var string : XGString {
		get {
			return XGString(string: specialUnicode.string, file: nil, sid: nil)
		}
	}
	
	var bytes : [Int] {
		get {
			var bytes = [Int]()
			switch self {
			case .Red			: bytes = [0xFF,0x00,0x00,0xFF]
			case .Green			: bytes = [0x00,0xFF,0x00,0xFF]
			case .Blue			: bytes = [0x00,0x00,0xFF,0xFF]
			case .Yellow		: bytes = [0xFF,0xFF,0x00,0xFF]
			case .Cyan			: bytes = [0x00,0xFF,0xFF,0xFF]
			case .Magenta		: bytes = [0xFF,0x00,0xFF,0xFF]
			case .LightGreen	: bytes = [0xC8,0xFF,0x00,0xFF]
			case .Purple		: bytes = [0xC8,0x00,0xC8,0xFF]
			case .Orange		: bytes = [0xFF,0xB0,0x00,0xFF]
			case .Grey			: bytes = [0xC8,0xC8,0xC8,0xFF]
			case .White			: bytes = [0xFF,0xFF,0xFF,0xFF]
			case .Black			: bytes = [0x00,0x00,0x00,0xFF]
			}
			return bytes
		}
	}
	
}








































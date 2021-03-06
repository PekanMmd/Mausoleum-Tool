//
//  XGUnicodeCharacters.swift
//  XG Tool
//
//  Created by The Steez on 10/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import Foundation

enum XGUnicodeCharacters {
	
	case Unicode(Int)
	case Special(XGSpecialCharacters, [Int])
	case PredefinedFontColour(XGFontColours)
	case SpecifiedFontColour(XGRGBAFontColours)
	
	var byteStream : [UInt8] {
		get {
			switch self {
				case .Unicode(let val)				: return [UInt8(val / 0x100), UInt8(val % 0x100)]
				case .PredefinedFontColour(let p)	: return p.specialUnicode.byteStream
				case .SpecifiedFontColour(let s)	: return s.specialUnicode.byteStream
				case .Special(let sp, let vals)		: var spec = sp.byteStream; for var i = 0; i < vals.count; i++ {
													  spec.append(UInt8(vals[i]))
												  }; return spec
			}
		}
	}
	
	var length : Int {
		get {
			return self.byteStream.count
		}
	}
	
	var extraBytes : Int {
		get {
			switch self {
				case .Unicode(let _)				: return 0
				case .PredefinedFontColour(let p)	: return 1
				case .SpecifiedFontColour(let s)	: return 4
				case .Special(let _, let e)			: return e.count
			}
		}
	}
	
	var string : String {
		get {
			var string = ""
			switch self {
				case .Unicode(let i)				: let u = UnicodeScalar(i); string = String(u)
				case .PredefinedFontColour(let p)	: return p.specialUnicode.string
				case .SpecifiedFontColour(let s)	: return s.specialUnicode.string
				case .Special(let s, let b)		: var str = s.string
													if b.count > 0 {
														str = str + "{"
														for hex in b {
															str = str + String(format: "%02x", hex)
														}
														str = str + "}";
													}
													string = str
			}
			return string
		}
	}
	
	var name : String {
		get {
			switch self {
				case .Unicode(let i)				: return self.string
				case .PredefinedFontColour(let p)	: return p.name
				case .SpecifiedFontColour(let s)	: return s.name
				case .Special(let s, let b)			: return self.string
			}
		}
	}
	
	static func hexStringToInt(hex: String) -> Int {
		
		return Int(strtoul(hex, nil, 16)) // converts hex string to uint and then cast as Int
		
	}
	
}















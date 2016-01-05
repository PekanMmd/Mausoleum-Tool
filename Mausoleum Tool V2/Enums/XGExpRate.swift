//
//  ExpIndex.swift
//  Mausoleum Stats Tool
//
//  Created by The Steez on 09/01/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import Foundation
import Darwin

infix operator ^^ { }
func ^^ (radix: Int, power: Int) -> Int {
	return Int(pow(Double(radix), Double(power)))
}

enum XGExpRate: Int {
	
	case Standard			= 0x0
	case VeryFast			= 0x1
	case Slowest			= 0x2
	case Slow				= 0x3
	case Fast				= 0x4
	case VerySlow			= 0x5
	
	var string : String {
		get {
			switch self { // The comments show alternative names used by Bulbapedia etc.
				case .Standard:		return "Standard" // medium fast
				case .VeryFast:		return "Very Fast" // erratic
				case .Slowest:		return "Slowest" // fluctuating
				case .Slow:			return "Slow" // medium slow
				case .Fast:			return "Fast" // fast
				case .VerySlow:		return "Very Slow" // slow
			}
		}
		
	}
	
	var maxExp : Int {
		get {
			switch self {
				case .Standard:		return 1_000_000
				case .VeryFast:		return 600_000
				case .Slowest:		return 1_640_000
				case .Slow:			return 1_059_860
				case .Fast:			return 800_000
				case .VerySlow:		return 1_250_000
			}
		}
	}
	
	func expForLevel(level: Int) -> Int {
		switch self {
			case .Standard:		return expForLevelStandard(level)
			case .VeryFast:		return expForLevelVeryFast(level)
			case .Slowest:		return expForLevelSlowest(level)
			case .Slow:			return expForLevelSlow(level)
			case .Fast:			return expForLevelFast(level)
			case .VerySlow:		return expForLevelVerySlow(level)
		}
	}
	
	func expForLevelVeryFast(n: Int) -> Int {
		
		if n <= 50 {
			return (n^^3) * (100 - n) / 50
		} else if n <= 68 {
			return (n^^3) * (150 - n) / 100
		} else if n <= 98 {
			let m = Int( floor( ( 1911 - (10 * Float(n)) ) / 3 ) )
			return (n^^3) * m / 500
		} else {
			return (n^^3) * (160 - n) / 100
		}
	}
	
	func expForLevelFast(n: Int) -> Int {
		return 4 * (n^^3) / 5
	}
	
	func expForLevelStandard(n: Int) -> Int {
		return n^^3
	}
	
	func expForLevelSlow(n: Int) -> Int {
		return (6 * (n^^3) / 5) - (15 * (n^^2)) + (100 * n) - 140
	}
	
	func expForLevelVerySlow(n: Int) -> Int {
		return 5 * (n^^3) / 4
	}
	
	func expForLevelSlowest(n: Int) -> Int {
		
		if n <= 15 {
			let m = Int( floor( ( Float(n) + 1 ) / 3 ) )
			return (n^^3) * (m + 24) / 50
		} else if n <= 36 {
			return (n^^3) * (n + 14) / 50
		} else {
			let m = Int( floor( Float(n) / 2 ) )
			return (n^^3) * (m + 32) / 50
		}
	}
	
	func cycle() -> XGExpRate {
		
		return XGExpRate(rawValue: self.rawValue + 1) ?? XGExpRate(rawValue: 0)!
		
	}
	
}






















//
//  XGGiftPokemon.swift
//  XG Tool
//
//  Created by The Steez on 01/08/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

protocol XGGiftPokemon {
	
	var index			: Int { get set }
	
	var level			: Int { get set }
	var species			: XGPokemon { get set }
	var move1			: XGMoves { get set }
	var move2			: XGMoves { get set }
	var move3			: XGMoves { get set }
	var move4			: XGMoves { get set }
	
	var giftType		: String { get set }
	
	func save()
   
}













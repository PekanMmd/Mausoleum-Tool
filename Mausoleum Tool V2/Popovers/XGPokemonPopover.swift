//
//  pokemonTableViewController.swift
//  Mausoleum Tool
//
//  Created by The Steez on 22/10/2014.
//  Copyright (c) 2014 Steezy. All rights reserved.
//

import UIKit

class XGPokemonPopover: XGPopover {
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return kNumberOfPokemon
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = dequeueCell()
		
		let poke = XGPokemon.Pokemon(indexPath.row)
		
		cell.title		= poke.name.string
		cell.background = poke.type1.image
		cell.picture	= poke.face
		
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		delegate.selectedItem = XGPokemon.Pokemon(indexPath.row) as Any
		delegate.popoverDidDismiss()
	}
	
}

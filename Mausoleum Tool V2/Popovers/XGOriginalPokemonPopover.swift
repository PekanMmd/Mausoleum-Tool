//
//  XGOriginalPokemonPopover.swift
//  XG Tool
//
//  Created by The Steez on 02/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGOriginalPokemonPopover: XGPopover {
	
//	var pokeList = [String]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
//		pokeList = XGResources.JSON("Original Pokemon").json as! [String]
		self.tableView.reloadData()
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return kNumberOfPokemon
	}
	
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = dequeueCell()
		
//		let name = pokeList[indexPath.row].capitalizedString
//		cell.title = name
		
		let poke = XGOriginalPokemon.Pokemon(indexPath.row)
		cell.title = poke.name
		
		let type = poke.type1
		cell.background = type.image
		
		
		if type == XGMoveTypes.Dark {
			cell.textLabel?.textColor = UIColor.whiteColor()
			cell.detailTextLabel?.textColor = UIColor.whiteColor()
		} else {
			cell.textLabel?.textColor = UIColor.blackColor()
			cell.detailTextLabel?.textColor = UIColor.blackColor()
		}
		
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		delegate.selectedItem = XGOriginalPokemon.Pokemon(indexPath.row) as Any
		delegate.popoverDidDismiss()
	}
	
}
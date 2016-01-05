//
//  movesTableViewController.swift
//  Mausoleum Tool
//
//  Created by The Steez on 03/11/2014.
//  Copyright (c) 2014 Steezy. All rights reserved.
//

import UIKit

class XGMovePopover: XGPopover {
	
	var moves = [(String,Int,Int)]()
	
	override init() {
		super.init()
		
		let data = XGFiles.Common_rel.data
		let table = XGFiles.Common_rel.stringTable
		
		var offset = kFirstMoveOffset
		
		for var i = 0; i < kNumberOfMoves; i++ {
			
			let nameID = data.get2BytesAtOffset(offset + kMoveNameIDOffset)
			let name = table.stringSafelyWithID(nameID).string
			
			let type = data.getByteAtOffset(offset + kMoveTypeOffset)
			
			moves.append((name,type,i))
			
			offset += kSizeOfMoveData
		}
		
		moves.sortInPlace{ if ($0.2 == 0) {return true}; if ($1.2 == 0) {return false}; if XGMoves.Move($0.2).isShadowMove { return XGMoves.Move($1.2).isShadowMove ? $0.0 < $1.0 : false }; if ($0.1 == $1.1) { return $0.0 < $1.0 }; return $0.1 < $1.1 }
		
	}

	required init!(coder aDecoder: NSCoder) {
	    super.init(coder: aDecoder)
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		// Custom initialization
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return kNumberOfMoves
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = dequeueCell()
		
		let move = moves[indexPath.row]
		
		cell.title = move.0
		cell.background = XGMoveTypes(rawValue: move.1)!.image
		
		if XGMoves.Move(moves[indexPath.row].2).isShadowMove {
			cell.background = UIImage(named: "shadow")!
		}
		
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		delegate.selectedItem = XGMoves.Move(moves[indexPath.row].2) as Any
		delegate.popoverDidDismiss()
	}
	
}














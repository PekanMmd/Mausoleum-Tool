//
//  XGEvolutionCell.swift
//  XG Tool
//
//  Created by The Steez on 03/07/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGEvolutionCell: XGTableViewCell {

	var index = 0
	
	var level = XGValueTextField()
	var move  = XGPopoverButton()
	
	var delegate : XGPokemonStatsViewController!
	var selectedItem : Any = 0
	
	func popoverDidDismiss() {
		let item = selectedItem as! XGMoves
		
		self.delegate.pokemon.levelUpMoves[index].move = item
		self.delegate.updateView()
	}
	
	init(viewController: XGViewController) {
		super.init()
		
		level = XGValueTextField(title: "Level", value: 1, min: 1, max: 100, height: 50, width: 100, action: {
			self.delegate.pokemon.levelUpMoves[self.index].level = self.level.value
		})
		self.addSubview(level)
		
		move = XGPopoverButton(title: "Move", colour: UIColor.blackColor(), textColour: UIColor.orangeColor(), popover: XGMovePopover(), viewController: viewController)
		self.addSubview(move)
		
		let views = ["l" : level, "m" : move]
		
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[l][m]|", options: .AlignAllCenterY, metrics: nil, views: views))
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(5)-[m(50)]-(5)-|", options: .AlignAllCenterY, metrics: nil, views: views))
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

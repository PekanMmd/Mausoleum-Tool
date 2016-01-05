//
//  XGRootViewController.swift
//  XG Tool
//
//  Created by The Steez on 26/05/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGRootViewController: UITableViewController {
	
	let toolTitles = ["Pokemon Stats Editor", "Trainer Editor", "String Table Reader", "Move Editor", "TM Editor", "Type Editor", "Gift Pokemon Editor", "Randomiser", "LZSS Compressor", "FSYS Importer"]
	let toolSegues = ["toStatsVC", "toDeckVC", "toStringTableReader", "toMoveVC", "toTMVC", "toTypeVC", "toGiftVC", "toDolVC", "toLZSSVC", "toFSYSVC"]

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.setUpNavigationBar()
		self.setUpUI()
		self.createDirectories()
		self.copyResourcesFromMainBundle()
		
	}
	
	func createDirectories() {
		
		// main directories
		XGFolders.StringTables.createDirectory()
		XGFolders.DOL.createDirectory()
		XGFolders.Common.createDirectory()
		XGFolders.Images.createDirectory()
		XGFolders.JSON.createDirectory()
		XGFolders.FSYS.createDirectory()
		XGFolders.LZSS.createDirectory()
		
		// subdirectories
		XGFolders.PokeFace.createDirectory()
		XGFolders.PokeBody.createDirectory()
		XGFolders.Types.createDirectory()
		XGFolders.Trainers.createDirectory()
		
	}
	
	func copyResourcesFromMainBundle() {
		
		XGFolders.DOL.copyResource(.DOL)
		XGFolders.Common.copyResource(.FDAT("common_rel"))
		
		for var i = 0; i < kNumberOfTypes; i++ {
			XGFolders.Types.copyResource(.PNG(String(i)))
		}
		XGFolders.Types.copyResource(.PNG("shadow"))
		
	}
	
	func setUpNavigationBar() {
		
		let titleTextAttributes = [NSForegroundColorAttributeName : UIColor.orangeColor()]
		self.navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
		self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
		self.navigationController?.navigationBar.tintColor = UIColor.orangeColor()
		self.navigationController?.navigationBar.translucent = false
		
	}
	
	func setUpUI() {
		
		self.title = "Mausoleum Tool"
		
		self.tableView.separatorStyle = .None
		self.view.backgroundColor = UIColor.orangeColor()
		
	}

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return toolTitles.count
    }
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 150
	}

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("rootCell") as! XGRootTableViewCell!
		if cell == nil {
			cell = XGRootTableViewCell(style: .Default, reuseIdentifier: "rootCell")
		}
		
		cell.title.textColor = UIColor.blackColor()
		
		let row = indexPath.row
		
		if row < self.toolTitles.count {
			cell.title.text = self.toolTitles[row]
		} else {
			cell.title.text = ""
		}
		
		cell.background.image = UIImage(named: "Tool Cell")!

        return cell!
    }
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let row = indexPath.row
		
		if row < self.toolSegues.count {
			self.performSegueWithIdentifier(self.toolSegues[row], sender: self)
		}
	}

}





























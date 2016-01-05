//
//  XGFilePicker.swift
//  XG Tool
//
//  Created by The Steez on 03/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import Foundation

import UIKit

class XGFilePickerPopover: XGPopover {
	
	var folder = XGFolders.Documents
	
	var files = [String]()
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	init(folder: XGFolders) {
		super.init()
		self.folder = folder
		self.files = self.folder.filenames
		
		files.filter{ $0.substringWithRange(Range<String.Index>(start: $0.startIndex,end: $0.startIndex)) != "." }
		
		self.delegate = delegate
		self.tableView.backgroundColor = UIColor.orangeColor()
	}

	required init!(coder aDecoder: NSCoder) {
	    super.init(coder: aDecoder)
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return files.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = dequeueCell()
		
		cell.title = files[indexPath.row]
		
		switch self.folder {
			case .PNG: cell.picture = folder.files[indexPath.row].image
			case .PokeBody: cell.picture = folder.files[indexPath.row].image
			case .PokeFace: cell.picture = folder.files[indexPath.row].image
			case .Types: cell.picture = folder.files[indexPath.row].image
			case .Trainers: cell.picture = folder.files[indexPath.row].image
			
			default: break
		}
		
		cell.background = UIImage(named: "File Cell")!
		
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		
		delegate.selectedItem =  XGFiles.NameAndFolder(files[indexPath.row], self.folder) as Any
		delegate.popoverDidDismiss()
	}
	
	
	
}








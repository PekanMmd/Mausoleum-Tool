//
//  XGStringSearchViewController.swift
//  XG Tool
//
//  Created by The Steez on 22/05/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit
import Darwin

class XGStringSearchViewController: XGTableViewController {
	
	var stringTables = [XGStringTable]()
	var needsRefresh = false
	
	var results = [XGString(string: "Search Results Appear Here.", file: nil, sid: nil)] {
		didSet {
			if (self.results.count > 0) &&  !self.needsRefresh {
				self.selectedString = self.results[0]
				self.resultsBox.text = self.selectedString.string
				self.reloadTable()
			}
		}
	}
	
	var selectedString = XGString(string: "", file: nil, sid: nil)
	
	var filePickerButton = XGPopoverButton()
	
	var searchBar = XGTextField()
	var replaceBar = XGTextField()
	var resultsBox = UITextView()
	
	var resultsTable : UITableView {
		get {
			return self.table
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.loadStringTables()
		self.setUpUI()
		
	}
	
	func setUpUI() {
		
		self.title = "String Table Reader"
		
		view.backgroundColor = UIColor.orangeColor()
		
		searchBar = XGTextField(title: "Search ID or String", text: "", height: 60, width: 300, action: {})
		self.addSubview(searchBar, name: "sbar")
		
		replaceBar = XGTextField(title: "Replacement String", text: "", height: 60, width: 300, action: {})
		self.addSubview(replaceBar, name: "rbar")
		
		resultsBox.backgroundColor = UIColor.blackColor()
		resultsBox.textColor = UIColor.orangeColor()
		resultsBox.layer.cornerRadius = 10
		resultsBox.clipsToBounds = true
		resultsBox.font = UIFont(name: "Helvetica", size: 30)
		resultsBox.scrollEnabled = true
		resultsBox.bounces = true
		resultsBox.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(resultsBox, name: "rbox")
		
		let searchButton = XGButton(title: "Search for ID", colour: UIColor.blueColor(), textColour: UIColor.whiteColor(), action: {self.searchID()})
		self.addSubview(searchButton, name: "sbut")
		
		let searchSubButton = XGButton(title: "Search for String", colour: UIColor.blueColor(), textColour: UIColor.whiteColor(), action: {self.searchForSubstring()})
		self.addSubview(searchSubButton, name: "ssbut")
		
		let replaceButton = XGButton(title: "Replace substring", colour: UIColor.redColor(), textColour: UIColor.whiteColor(), action: {self.replaceOccurences()})
		self.addSubview(replaceButton, name: "rbut")
		
		let replaceTextButton = XGButton(title: "Replace text", colour: UIColor.redColor(), textColour: UIColor.whiteColor(), action: {self.replace()})
		self.addSubview(replaceTextButton, name: "rtbut")
		
		let replaceAllButton = XGButton(title: "Replace All", colour: UIColor.redColor(), textColour: UIColor.whiteColor(), action: {self.replaceAllOccurences()})
		self.addSubview(replaceAllButton, name: "rabut")
		
		filePickerButton = XGPopoverButton(title: "Search File", colour: UIColor.blueColor(), textColour: UIColor.whiteColor(), popover: XGFilePickerPopover(folder: .StringTables), viewController: self)
		self.addSubview(filePickerButton, name: "fb")
		
		let specialsButton = XGPopoverButton(title: "Special Characters", colour: UIColor.greenColor(), textColour: UIColor.whiteColor(), popover: XGStringCopierPopover(), viewController: self)
		self.addSubview(specialsButton, name: "spb")
		
		self.createDummyViewsEqualWidths(3, baseName: "h")
		self.createDummyViewsEqualWidths(4, baseName: "i")
		self.createDummyViewsEqualWidths(4, baseName: "j")
		self.createDummyViewsEqualHeights(4, baseName: "k")
		
		self.addConstraints(visualFormat: "H:[rbox(700)]", layoutFormat: [])
		self.addConstraints(visualFormat: "H:|[h1][sbar][h2][rbar][h3]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[i1][sbut(200)][i2][ssbut(200)][i3][fb(200)][i4]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:|[j1][rtbut(200)][j2][rbut(200)][j3][rabut(200)][j4]|", layoutFormat: [.AlignAllTop, .AlignAllBottom])
		self.addConstraints(visualFormat: "H:[spb(300)]", layoutFormat: [])
		self.addConstraintAlignCenterX(view1: self.contentView, view2: resultsBox)
		self.addConstraints(visualFormat: "V:|-(20)-[rbox(200)]-(10)-[h2][k1][ssbut(80)][k2][rbut(80)][k3][spb(80)][k4]|", layoutFormat: .AlignAllCenterX)
		
	}
	
	func loadStringTables() {
		
		self.showActivityView { (Bool) -> Void in
			
			self.stringTables = [XGStringTable]()
			
			let stringTable1 = XGStringTable.common_rel()
			let stringTable2 = XGStringTable.dol()
			
			self.stringTables = [stringTable1, stringTable2]
			
			XGFolders.StringTables.map{ (file: XGFiles) -> Void in
				self.stringTables.append(file.stringTable)
			}
			self.hideActivityView()
			self.needsRefresh = false
		}
	}
	
	func reloadTable() {
		
		if self.needsRefresh {
			
			self.loadStringTables()
			
			for var i = 0; i < results.count; i++ {
				let r = results[i]
				results[i] = searchStringIDInAllTables( String(format: "%x", r.id) )
			}
			
			self.needsRefresh = false
		}
		
		
		self.showActivityView{ (Bool) -> Void in
			self.resultsTable.reloadData()
			self.resultsTable.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: .Top, animated: true)
			self.hideActivityView()
		}
	}
	
	func searchID() {
		
		self.showActivityView{ (Bool) -> Void in
			
			self.results = [self.searchStringIDInAllTables(self.searchBar.text)]
			self.searchBar.resignFirstResponder()
			
			self.hideActivityView()
		}
	}
	
	func searchStringID(sid: String, inTable table: XGStringTable) -> XGString? {
		
		return table.stringWithID(hexStringToInt(sid))
		
	}
	
	func searchStringIDInAllTables(sid: String) -> XGString {
		
		let id = hexStringToInt(sid)
		
		for table in self.stringTables {
			if table.containsStringWithId(id) {
				
				return table.stringWithID(id)!
				
			}
		}
		
		return XGString(string: "No strings were found with id: \(sid).", file: nil, sid: nil)
		
	}
	
	func hexStringToInt(hex: String) -> Int {
		
		return Int(strtoul(hex, nil, 16)) // converts hex string to uint and then cast as Int
		
	}
	
	func getAllStringsFromTable(table: XGStringTable) {
		
		self.showActivityView{ (Bool) -> Void in
			self.results = table.allStrings()
			
			self.hideActivityView()
		}
	}
	
	func arrayOfAllString() -> [XGString] {
		
		var r = [XGString]()
		for table in self.stringTables {
			let s = table.allStrings()
			r = r + s
		}
		return r
	}
	
	func getAllStrings() {
		self.showActivityView{ (Bool) -> Void in
			self.results = self.arrayOfAllString()
			
			self.hideActivityView()
		}
	}
	
	func searchForSubstring() {
		
		self.showActivityView{ (Bool) -> Void in
			let sub = self.searchBar.text
			self.results = self.arrayOfAllString().filter{ $0.containsSubstring(sub) }
			
			self.hideActivityView()
		}
	}
	
	func replace() {
		self.showActivityView{ (Bool) -> Void in
			let new = self.resultsBox.text
			self.selectedString.duplicateWithString(new).replace(true)
			
			self.hideActivityView()
		}
		self.needsRefresh = true
		self.reloadTable()
	}
	
	func replaceOccurences() {
		self.showActivityView{ (Bool) -> Void in
			let sub = self.searchBar.text
			let new = self.replaceBar.text
			self.selectedString.replaceSubstring(sub, withString: new, verbose: true)
			
			self.hideActivityView()
		}
		self.needsRefresh = true
		self.reloadTable()
	}
	
	func replaceAllOccurences() {
		self.showActivityView{ (Bool) -> Void in
			let sub = self.searchBar.text
			let new = self.replaceBar.text
			for r in self.results {
				r.replaceSubstring(sub, withString: new, verbose: false)
			}
			self.hideActivityView()
		}
		self.needsRefresh = true
		self.reloadTable()
	}
	
	override func popoverDidDismiss() {
		
		if popoverPresenter == filePickerButton {
			let f = selectedItem as! XGFiles
			self.results = f.stringTable.allStrings()
			self.resultsTable.reloadData()
		}
		
		self.popoverPresenter.popover.dismissPopoverAnimated(true)
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! XGStringCell!
		if cell == nil {
			cell = XGStringCell(string: XGString(string: "", file: nil, sid: nil), reuseIdentifier: "cell")
		}
		
		if results.count == 0 {
			cell.string = XGString(string: "No Results", file: nil, sid: nil)
		} else {
			cell.string = self.results[indexPath.row]
		}
		cell.background = XGResources.PNG("Item Cell").image
		
		cell.textView.textColor = UIColor.blackColor()
		
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		self.selectedString = results[indexPath.row]
		self.resultsBox.text = selectedString.string
	}
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		
		if results.count == 0 {
			self.results = [XGString(string: "No results were found.", file: nil, sid: nil)]
		}
		
		let tv = UILabel()
		tv.lineBreakMode = .ByWordWrapping
		tv.translatesAutoresizingMaskIntoConstraints = false
		let string = results[indexPath.row]
		tv.text = string.stringPlusIDAndFile
		tv.numberOfLines = 0
		tv.font = UIFont(name: "Helvetica", size: 20)
		tv.preferredMaxLayoutWidth = 280
		tv.frame.size.width = 280
		tv.frame.size.height = 1000
		tv.sizeToFit()
		let height = tv.frame.height + 100
		
		return height
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.results.count > 0 ? self.results.count : 1
	}

}






















//
//  XGFsysImporterViewController.swift
//  XG Tool
//
//  Created by The Steez on 30/07/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGFsysImporterViewController: XGViewController {
	
	var folder		= XGFolders.Documents
	
	var fsysPicker  = XGPopoverButton()
	var lzssPicker  = XGPopoverButton()
	
	var importButton = XGButton()
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.setUpUI()
		
    }
	
	func setUpUI() {
		
		importButton = XGButton(title: "Import Files", colour: UIColor.blueColor(), textColour: UIColor.whiteColor(), action: {self.importFsys()})
		self.addSubview(importButton, name: "i")
		self.addConstraintAlignCenters(view1: importButton, view2: self.contentView)
		
	}
	
	override func popoverDidDismiss() {
	
	
	
	}
	
	func importFsys() {
		
		self.showActivityView { (Bool) -> Void in
			
			XGFsys.Fsys(.FSYS("common.fsys")).replaceFileWithIndex(0, withFile: .LZSS("common_rel.lzss"))
			
			self.hideActivityView()
		}
	}
	
	
	

}




















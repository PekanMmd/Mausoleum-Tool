//
//  XGLZSSViewController.swift
//  XG Tool
//
//  Created by The Steez on 30/07/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit


class XGLZSSViewController: XGTableViewController {
	
	var compress = XGButton()
	

    override func viewDidLoad() {
        super.viewDidLoad()

       self.setUpUI()
    }

	func setUpUI() {
		
		compress = XGButton(title: "Compress Files", colour: UIColor.blueColor(), textColour: UIColor.whiteColor(), action: { self.compressFiles() })
		self.addSubview(compress, name: "c")
		self.addConstraintAlignCenters(view1: compress, view2: self.contentView)
		
	}
	
	func compressFiles() {
		
		self.showActivityView { (Bool) -> Void in
			
			XGLZSS.Input(.Common_rel).compress()
			
			self.hideActivityView()
		}
		
	}
	
	
}











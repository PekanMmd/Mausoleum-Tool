//
//  XGViewController.swift
//  XG Tool
//
//  Created by The Steez on 06/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

class XGViewController: UIViewController, XGPopoverDelegate  {
	
	var activityView = XGActivityView()
	
	var popoverPresenter = XGPopoverButton()
	var selectedItem	 : Any	= 0
	
	var views    : [String : UIView ] = [String : UIView ]()
	var metrics  : [String : CGFloat] = [String : CGFloat]()
	
	var contentView : UIView! {
		get {
			return view
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.addMetric(value: self.contentView.frame.height, name: "screenHeight")
		self.addMetric(value: self.contentView.frame.width , name: "screenWidth" )
		
		self.contentView.backgroundColor = UIColor.orangeColor()

	}
	
	func openPopover(sender: XGPopoverButton) {
		self.popoverPresenter = sender
		
		sender.showPopover()
		
	}
	
	func popoverDidDismiss() {
		self.popoverPresenter.popover.dismissPopoverAnimated(true)
	}
	
	func showActivityView() {
		self.showActivityView(nil)
	}
	
	func showActivityView(completion: ( (Bool) -> Void)! ) {
		
		self.view.addSubview(activityView)
		let views = ["av" : activityView]
		self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[av]|", options: [], metrics: nil, views: views))
		self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[av]|", options: [], metrics: nil, views: views))
		UIView.animateWithDuration(0.25, animations: {
			self.activityView.alpha = 1.0
		}, completion : { (done: Bool) -> Void in
			if completion != nil {
				completion(done)
			}
		})
		
	}
	
	func hideActivityView() {
		UIView.animateWithDuration(0.25, animations: {
			self.activityView.alpha = 0
		}, completion: { (Bool) -> Void in
			self.activityView.removeFromSuperview()
		})
	}
	
	func dispatchAfter(dispatchTime dispatchTime: Double, closure: () -> Void) {
		
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(dispatchTime * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
			closure()
		})
	}
	
	
	func addSubview(view: UIView, name: String) {
		
		view.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.addSubview(view)
		self.views[name] = view
		
	}
	
	func addMetric(value value: CGFloat, name: String) {
		self.metrics[name] = value
	}
	
	func addConstraints(visualFormat visualFormat: String, layoutFormat: NSLayoutFormatOptions) {
		self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: layoutFormat, metrics: self.metrics, views: self.views))
	}
	
	func addConstraintEqualWidths(view1 view1: UIView, view2: UIView) {
		self.contentView.addConstraint(NSLayoutConstraint(item: view1, attribute: .Width, relatedBy: .Equal, toItem: view2, attribute: .Width, multiplier: 1, constant: 0))
	}
	
	func addConstraintEqualHeights(view1 view1: UIView, view2: UIView) {
		self.contentView.addConstraint(NSLayoutConstraint(item: view1, attribute: .Height, relatedBy: .Equal, toItem: view2, attribute: .Height, multiplier: 1, constant: 0))
	}
	
	func addConstraintEqualSizes(  view1 view1: UIView, view2: UIView) {
		self.addConstraintEqualHeights(view1: view1, view2: view2)
		self.addConstraintEqualWidths( view1: view1, view2: view2)
	}
	
	func addConstraintAlignCenterX(view1 view1: UIView, view2: UIView) {
		self.contentView.addConstraint(NSLayoutConstraint(item: view1, attribute: .CenterX, relatedBy: .Equal, toItem: view2, attribute: .CenterX, multiplier: 1, constant: 0))
	}
	
	func addConstraintAlignCenterY(view1 view1: UIView, view2: UIView) {
		self.contentView.addConstraint(NSLayoutConstraint(item: view1, attribute: .CenterY, relatedBy: .Equal, toItem: view2, attribute: .CenterY, multiplier: 1, constant: 0))
	}
	
	func addConstraintAlignCenters(view1 view1: UIView, view2: UIView) {
		self.addConstraintAlignCenterX(view1: view1, view2: view2)
		self.addConstraintAlignCenterY(view1: view1, view2: view2)
	}
	
	func addConstraintAlignLeftEdges(view1 view1: UIView, view2: UIView) {
		self.contentView.addConstraint(NSLayoutConstraint(item: view1, attribute: .Left, relatedBy: .Equal, toItem: view2, attribute: .Left, multiplier: 1, constant: 0))
	}
	
	func addConstraintAlignRightEdges(view1 view1: UIView, view2: UIView) {
		self.contentView.addConstraint(NSLayoutConstraint(item: view1, attribute: .Right, relatedBy: .Equal, toItem: view2, attribute: .Right, multiplier: 1, constant: 0))
	}
	
	func addConstraintAlignTopEdges(view1 view1: UIView, view2: UIView) {
		self.contentView.addConstraint(NSLayoutConstraint(item: view1, attribute: .Top, relatedBy: .Equal, toItem: view2, attribute: .Top, multiplier: 1, constant: 0))
	}
	
	func addConstraintAlignBottomEdges(view1 view1: UIView, view2: UIView) {
		self.contentView.addConstraint(NSLayoutConstraint(item: view1, attribute: .Bottom, relatedBy: .Equal, toItem: view2, attribute: .Bottom, multiplier: 1, constant: 0))
	}
	
	func addConstraintAlignTopAndBottomEdges(view1 view1: UIView, view2: UIView) {
		self.addConstraintAlignTopEdges(view1: view1, view2: view2)
		self.addConstraintAlignBottomEdges(view1: view1, view2: view2)
	}
	
	func addConstraintAlignLeftAndRightEdges(view1 view1: UIView, view2: UIView) {
		self.addConstraintAlignLeftEdges(view1: view1, view2: view2)
		self.addConstraintAlignRightEdges(view1: view1, view2: view2)
	}
	
	func addConstraintAlignAllEdges(view1 view1: UIView, view2: UIView) {
		self.addConstraintAlignLeftAndRightEdges(view1: view1, view2: view2)
		self.addConstraintAlignTopAndBottomEdges(view1: view1, view2: view2)
	}
	
	func addConstraintHeight(view view: UIView, height: CGFloat) {
		let view = ["v" : view]
		let metric = ["h" : height]
		self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[v(h)]", options: [], metrics: metric, views: view))
	}
	
	func addConstraintWidth( view view: UIView, width : CGFloat) {
		let view = ["v" : view]
		let metric = ["w" : width]
		self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[v(w)]", options: [], metrics: metric, views: view))
	}
	
	func addConstraintSize( view view: UIView, height: CGFloat, width : CGFloat) {
		self.addConstraintWidth( view: view, width : width)
		self.addConstraintHeight(view: view, height: height)
	}
	
	func createDummyViewsEqualHeights(number : Int, baseName : String) {
		
		for var i = 1; i <= number; i++ {
			
			let dummy = UIView()
			dummy.userInteractionEnabled = false
			dummy.alpha = 0.0
			dummy.hidden = true
			dummy.translatesAutoresizingMaskIntoConstraints = false
			
			self.addSubview(dummy, name: baseName + "\(i)")
			
			if i > 1 {
				self.addConstraintEqualHeights(view1: views[baseName + "\(1)"]!, view2: views[baseName + "\(i)"]!)
			}
			
		}
	}
	
	func createDummyViewsEqualWidths(number : Int, baseName : String) {
		
		for var i = 1; i <= number; i++ {
			
			let dummy = UIView()
			dummy.translatesAutoresizingMaskIntoConstraints = false
			
			self.addSubview(dummy, name: baseName + "\(i)")
			
			if i > 1 {
				self.addConstraintEqualWidths(view1: views[baseName + "\(1)"]!, view2: views[baseName + "\(i)"]!)
			}
			
		}
	}
	
	func addShadowToView(view view: UIView, radius: CGFloat, xOffset: CGFloat, yOffset: CGFloat) {
		
		view.layer.masksToBounds = false
		view.layer.shadowOpacity = 0.9
		view.layer.shadowOffset = CGSizeMake(xOffset, yOffset)
		view.layer.shadowColor = UIColor.blackColor().CGColor
		view.layer.shadowRadius = radius
		
	}


}












































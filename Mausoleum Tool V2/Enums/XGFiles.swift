//
//  XGDecks.swift
//  XG Tool
//
//  Created by The Steez on 30/05/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//

import UIKit

enum XGFiles {
	
	case Dol
	case Common_rel
	case PokeFace(Int)
	case PokeBody(Int)
	case TypeImage(Int)
	case TrainerFace(Int)
	case StringTable(String)
	case Resources(XGResources)
	case FSYS(String)
	case LZSS(String)
	case NameAndFolder(String, XGFolders)
	
	var path : String {
		get{
			switch self {
				case .Resources(let r)  : return r.path!
				default					: return (folder.path as NSString).stringByAppendingPathComponent(self.fileName)
			}
		}
		
	}
	
	var fileName : String {
		get {
			switch self {
				
				case .Dol					: return "Start.dol"
				case .Common_rel			: return "common_rel.fdat"
				case .PokeFace(let id)		: return String(format: "%03d", id) + ".png"
				case .PokeBody(let id)		: return String(format: "%03d", id) + ".png"
				case .TypeImage(let id)		: return String(id) + ".png"
				case .TrainerFace(let id)	: return String(id) + ".png"
				case .StringTable(let s)	: return s
				case .Resources(let r)		: return r.fileName
				case .FSYS(let s)			: return s
				case .LZSS(let s)			: return s
				case .NameAndFolder(let name, let _) : return name
				
			}
		}
	}
	
	var folder : XGFolders {
		get {
			var folder = XGFolders.Documents
			
			switch self {
				
				case .Dol				: folder = .DOL
				case .Common_rel		: folder = .Common
				case .PokeFace			: folder = .PokeFace
				case .PokeBody			: folder = .PokeBody
				case .TypeImage			: folder = .Types
				case .TrainerFace		: folder = .Trainers
				case .StringTable		: folder = .StringTables
				case .FSYS				: folder = .FSYS
				case .LZSS				: folder = .LZSS
				case .NameAndFolder(let _, let aFolder) : folder = aFolder
				default: break
				
			}
			
			return folder
		}
	}

	var data : XGMutableData {
		get {
			return XGMutableData(contentsOfXGFile: self)!
		}
	}
	
	var exists : Bool {
		get {
			let fm = NSFileManager.defaultManager()
			return fm.fileExistsAtPath(self.path)
		}
	}
	
	var json : AnyObject {
		get {
			return try! NSJSONSerialization.JSONObjectWithData(self.data.data, options: NSJSONReadingOptions.MutableContainers)
		}
	}
	
	var image : UIImage {
		get {
			return UIImage(contentsOfFile: self.path)!
		}
	}
	
	var stringTable : XGStringTable {
		get {
			switch self {
				case .Common_rel : return XGStringTable.common_rel()
				case .Dol		 : return XGStringTable.dol()
				default			 : return XGStringTable(file: self, startOffset: 0, fileSize: self.fileSize)
			}
		}
	}
	
	var fileSize : Int {
		get {
			return self.data.length
		}
	}
	
	func rename(name: String) {
		let fm = NSFileManager.defaultManager()
		
		let newPath = (self.folder.path as NSString).stringByAppendingPathComponent(name)
		do {
			try fm.moveItemAtPath(self.path, toPath: newPath)
		} catch _ {
		}
	}
	
	func delete() {
		let fm = NSFileManager.defaultManager()
		
		var error : NSError?
		var isDirectory : ObjCBool = false
		let pathExists = fm.fileExistsAtPath(self.path, isDirectory: &isDirectory)
		
		if pathExists && !isDirectory {
			do {
				try fm.removeItemAtPath(self.path)
			} catch let error1 as NSError {
				error = error1
			}
		}
	}
	
}

enum XGFolders : String {
	
	case Documents			= "Documents"
	case Common				= "Common"
	case DOL				= "DOL"
	case JSON				= "JSON"
	case StringTables		= "String Tables"
	case TextureImporter	= "Texture Importer"
	case PNG				= "PNG"
	case FDAT				= "FDAT"
	case Output				= "Output"
	case Images				= "Images"
	case PokeFace			= "PokeFace"
	case PokeBody			= "PokeBody"
	case Trainers			= "Trainers"
	case Types				= "Types"
	case FSYS				= "FSYS"
	case LZSS				= "LZSS"
	
	var name : String {
		get {
			return self.rawValue
		}
	}
	
	var path : String {
		get {
			var path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
			
			switch self {
				
				case .Documents	: return path
				case .PNG		: path = XGFolders.TextureImporter.path
				case .FDAT		: path = XGFolders.TextureImporter.path
				case .Output	: path = XGFolders.TextureImporter.path
				case .PokeFace	: path = XGFolders.Images.path
				case .PokeBody	: path = XGFolders.Images.path
				case .Trainers	: path = XGFolders.Images.path
				case .Types		: path = XGFolders.Images.path
				default: break
				
			}
			
			return (path as NSString).stringByAppendingPathComponent(self.name)
		}
	}
	
	var filenames : [String]! {
		get {
			let names = (try? NSFileManager.defaultManager().contentsOfDirectoryAtPath(self.path)) as [String]!
			return names.filter{ $0.substringToIndex( $0.startIndex.advancedBy(1)) != "." }
		}
	}
	
	var files : [XGFiles]! {
		get {
			let fileNames = self.filenames ?? []
			var xgfs = [XGFiles]()
			
			for file in fileNames {
				let xgf = XGFiles.NameAndFolder(file, self)
				xgfs.append(xgf)
			}
			return xgfs
		}
	}
	
	func createDirectory() {
		
		var fm = NSFileManager.defaultManager()
		
		var error : NSError?
		var isDirectory : ObjCBool = false
		var pathExists = fm.fileExistsAtPath(self.path, isDirectory: &isDirectory)
		
		if !pathExists || !isDirectory {
			
			do {
				try fm.removeItemAtPath(self.path)
			} catch var error1 as NSError {
				error = error1
			}
			do {
				try fm.createDirectoryAtPath(self.path, withIntermediateDirectories: true, attributes: nil)
			} catch var error1 as NSError {
				error = error1
			}
			
			var fileURL = NSURL(fileURLWithPath: self.path)
			do {
				try fileURL.setResourceValue(false, forKey: NSURLIsExcludedFromBackupKey)
			} catch var error1 as NSError {
				error = error1
			}
			
		}
		
	}
	
	func copyResource(resource: XGResources) {
		
		let fm = NSFileManager.defaultManager()
		
		let copyPath = (self.path as NSString).stringByAppendingPathComponent(resource.fileName)
		
		if !fm.fileExistsAtPath(copyPath) && (resource.path != nil) {
			do {
				try fm.copyItemAtPath(resource.path!, toPath: copyPath)
			} catch _ {
			}
		}
		
	}
	
	func map(function: ((file: XGFiles) -> Void) ) {
		
		let files = self.files ?? []
		
		for file in files {
			function(file: file)
		}
	}
	
	func empty() {
		self.map{ (file: XGFiles) -> Void in
			file.delete()
		}
	}
	
}















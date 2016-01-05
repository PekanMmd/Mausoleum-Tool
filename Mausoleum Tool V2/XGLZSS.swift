//
//  XGLZSS.swift
//  XG Tool
//
//  Created by The Steez on 02/06/2015.
//  Copyright (c) 2015 Ovation International. All rights reserved.
//


import Foundation

enum XGLZSS {
	
	case Input(XGFiles)
	
	var input : XGFiles {
		get {
			switch self {
				case .Input(let file): return file
			}
		}
	}
	
	var output : XGFiles {
		get {
			return .LZSS((input.fileName as NSString).stringByDeletingPathExtension + ".lzss")
		}
	}
	
	var originalData : XGMutableData {
		get {
			return self.input.data
		}
	}
	
	var compressedData : XGMutableData {
		get {
			var stream  = originalData.charStream
			let compressor = XGLZSSWrapper()
			let bytes = compressor.compressFile(&stream, ofSize: stream.count)
			let length = compressor.outLength
			var compressedStream = [UInt8]()
			for var i : Int32 = 0; i < length; i++ {
				compressedStream.append(bytes[Int(i)])
			}
			let compressedData = XGMutableData(byteStream: compressedStream, file: output)
			return compressedData
		}
	}
	
	func compress() {
		compressedData.save()
	}
	
	
}




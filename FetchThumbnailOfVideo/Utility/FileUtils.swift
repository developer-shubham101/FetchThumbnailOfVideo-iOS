//
//  FileUtils.swift
//  Reward
//
//  Created by Arka Softwares on 19/02/20.
//  Copyright © 2020 Arka Softwares. All rights reserved.
//

import Foundation


class FileUtils {
	
	//	public static let SIZE_KB: Double = 1024.0
	public static let SIZE_MB: Double = 1024.0
	public static let SIZE_GB: Double = 1024.0
	
	
	static func saveIntoDir(fileUrl:String, data:Data) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(fileUrl)
            
            //writing
            do {
                try data.write(to: fileURL)
            }
            catch {/* error handling here */}
            
        }
    }
	static func readImageFromDir(fileUrl:String) -> Data? {
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(fileUrl)
            
            //reading
            do {
                let imageData = try Data(contentsOf: fileURL)
                return imageData
            }
            catch {
                return nil
            }
        }
        return nil
    }
	
	static func saveIntoDir(fileUrl:String, data:String){
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(fileUrl)
            
            //writing
            do {
                try data.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {/* error handling here */}
            
        }
    }
	
	static func readFromDir(fileUrl:String) -> String? {
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(fileUrl)
            
            //reading
            do {
                let text2 = try String(contentsOf: fileURL, encoding: .utf8)
                return text2
            }
            catch {
                return nil
            }
        }
        return nil
    }
	
	
	
	
	static func convertFileSize(byteSize: Double) -> String {
		
		if (byteSize == -1){
			return "unknown"
		}
		
		
		let fileSizeInKB: Double = byteSize/1024.0
		var fileSize: String = String(format: "%.2f", fileSizeInKB) + " KB"
		
		if fileSizeInKB >= (FileUtils.SIZE_MB) {
			fileSize =  String(format: "%.2f", fileSizeInKB/FileUtils.SIZE_MB) + " MB"
		}else if fileSizeInKB >= (FileUtils.SIZE_GB) {
			fileSize = String(format: "%.2f", fileSizeInKB/FileUtils.SIZE_GB) + " GB"
		}
		
		return fileSize
		
		//		let m:Double = Double(fileSizeInKB)/1024.0;
		//		let g:Double = Double(fileSizeInKB)/1048576.0;
		//		let t:Double = Double(fileSizeInKB)/1073741824.0;
	}
}

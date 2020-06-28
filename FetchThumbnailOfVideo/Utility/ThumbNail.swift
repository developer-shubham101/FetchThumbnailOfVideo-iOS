//
//  ThumbNail.swift
//  FetchThumbnailOfVideo
//
//  Created by Shubham Sharma on 28/06/20.
//  Copyright © 2020 Newdevpoint. All rights reserved.
//

import Foundation
import UIKit
import AVKit


class ThumbNail {
    
    /*
     fileprivate func getThumbnailFromUrl(_ url: String?, _ completion: @escaping ((_ image: UIImage?)->Void)) {
     
     guard let url = URL(string: url ?? "") else { return }
     DispatchQueue.main.async {
     let asset = AVAsset(url: url)
     print(asset.duration)
     let assetImgGenerate = AVAssetImageGenerator(asset: asset)
     assetImgGenerate.appliesPreferredTrackTransform = true
     
     
     let time = CMTimeMake(value: 2, timescale: 1)
     do {
     let img: CGImage = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
     let thumbnail = UIImage(cgImage: img)
     completion(thumbnail)
     } catch (let error) {
     print("Error :: ", error.localizedDescription)
     completion(nil)
     }
     }
     }
     */
    
    static func getThumbnailFromUrl(_ url: String, defaultImage: Bool = true, _ completion: @escaping ((_ image: UIImage?)->Void)) {
        
        let md5Hex: String = url.toMD5
        if let oldData: Data = FileUtils.readImageFromDir(fileUrl: md5Hex) {
            
            completion(UIImage(data: oldData))
            
            //            completion(UIImage.imageByMergingImages(topImage: UIImage(named: "tmp_placeholder_video")!, bottomImage: UIImage(data: oldData)!))
        }else{
            guard let url = URL(string: url) else { return }
            
            DispatchQueue.global(qos: .utility).async {
                let asset = AVAsset(url: url)
                //            print(asset.duration)
                let durationSeconds = CMTimeGetSeconds(asset.duration)
                let assetImgGenerate = AVAssetImageGenerator(asset: asset)
                assetImgGenerate.appliesPreferredTrackTransform = true
                
                
                let time = CMTimeMakeWithSeconds(durationSeconds/3.0, preferredTimescale: 600)
                do {
                    let img: CGImage = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
                    let thumbnail = UIImage(cgImage: img)
                    
                    FileUtils.saveIntoDir(fileUrl: md5Hex, data: thumbnail.pngData()!)
                    DispatchQueue.main.async {
                        completion(thumbnail)
                    }
                    
                } catch (let error) {
                    print("Error :: ", error.localizedDescription)
                    DispatchQueue.main.async {
                        if defaultImage {
                            completion(UIImage(contentsOfFile: "tmp_placeholder_video"))
                        }else{
                            completion(nil)
                        }
                    }
                }
            }
        }
    }
    static func getThumbnailFromFile(_ url: URL) -> UIImage? {
         
        let asset = AVAsset(url: url)
        //            print(asset.duration)
        let durationSeconds = CMTimeGetSeconds(asset.duration)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        
        let time = CMTimeMakeWithSeconds(durationSeconds/3.0, preferredTimescale: 600)
        do {
            let img: CGImage = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            
            return thumbnail
            
        } catch (let error) {
            return nil
        }
    }
    
}

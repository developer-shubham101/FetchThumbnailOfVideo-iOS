//
//  ExtString.swift
//  FetchThumbnailOfVideo
//
//  Created by Shubham Sharma on 28/06/20.
//  Copyright © 2020 Newdevpoint. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {
    
    var toMD5: String {
        get {
            let messageData = self.data(using:.utf8)!
            var digestData: Data = Data(count: Int(CC_MD5_DIGEST_LENGTH))
            
            _ = digestData.withUnsafeMutableBytes {digestBytes in
                messageData.withUnsafeBytes {messageBytes in
                    CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
                }
            }
            
            return digestData.map { String(format: "%02hhx", $0 as CVarArg) }.joined()
        }
    }
 
}

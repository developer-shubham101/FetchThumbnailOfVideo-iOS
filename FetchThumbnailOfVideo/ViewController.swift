//
//  ViewController.swift
//  FetchThumbnailOfVideo
//
//  Created by Shubham Sharma on 28/06/20.
//  Copyright © 2020 Newdevpoint. All rights reserved.
//

import UIKit
import AVKit


class ViewController: UIViewController {
    
    @IBOutlet weak var urlField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapFetchThumbUrl(_ sender: UIButton) {
        sender.isEnabled = false
        ThumbNail.getThumbnailFromUrl(urlField.text!) { (image) in
            sender.isEnabled = true
            self.imageView.image = image
        }
    }
    
    @IBAction func didTapFetchThumbLocal(_ sender: Any) {
        //Big_Buck_Bunny_1080_10s_1MB.mp4
        let urlPath = Bundle.main.path(forResource: "Big_Buck_Bunny_1080_10s_1MB", ofType: "mp4")
        self.imageView.image = ThumbNail.getThumbnailFromFile(URL(fileURLWithPath: urlPath!))
        
    }
}

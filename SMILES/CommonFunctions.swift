//
//  CommonFunctions.swift
//  Resource Coach
//
//  Created by Apple on 31/12/20.
//  Copyright © 2020 Biipmi. All rights reserved.
//

import UIKit
import YouTubePlayer

class CommonFunctions {
    static let shared = CommonFunctions()

    func getYouTubeImageURLFrom(urlStr : String) -> URL {
        
        let theUrl = URL.init(string: urlStr)
        let vid = YouTubePlayer.videoIDFromYouTubeURL(theUrl!)
        let youtubeImgStr = "https://img.youtube.com/vi/" + vid! + "/1.jpg"
        let youtubeImgURL = URL.init(string: youtubeImgStr)
        return youtubeImgURL!
    }
}

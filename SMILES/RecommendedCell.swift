//
//  RecommendedCell.swift
//  Resource Coach
//
//  Created by Apple on 26/12/20.
//  Copyright © 2020 Biipmi. All rights reserved.
//

import UIKit
import AVFoundation
import YouTubePlayer

protocol RecommendedCellDelegate : class {
    func recommendedArticleTapped(catLock : String,articleID : String)
}
class RecommendedCell: UITableViewCell {

    var delegate : RecommendedCellDelegate?
    
    @IBOutlet weak var recommendedCV: UICollectionView!
    @IBOutlet weak var recommendedCVContainer: UIView!
    
    var recommendedArticleArr : NSArray?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.recommendedCV.dataSource = self
        self.recommendedCV.delegate = self
        self.recommendedCV.register(UINib.init(nibName: "RecommendedCVCell", bundle: nil), forCellWithReuseIdentifier: "RecommendedCVCellID")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  /*  //Generate Thumbnail
    func thumbnailForVideoAtURL(url: URL) -> UIImage? {
        
        return autoreleasepool { () -> UIImage in
            let asset = AVAsset(url: url)
            let assetImageGenerator = AVAssetImageGenerator(asset: asset)
            assetImageGenerator.appliesPreferredTrackTransform = true
            do {
                let imageRef = try assetImageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 1) , actualTime: nil)
                return UIImage(cgImage: imageRef).fixOrientation()
            } catch {
                print("This is failing for some reason \(url)")
                return  UIImage()
            }
        }
    }
    
    private func createVideoThumbnail(from url: URL) -> UIImage? {

        let asset = AVAsset(url: url)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        assetImgGenerate.maximumSize = CGSize(width: frame.width, height: frame.height)

        let time = CMTimeMakeWithSeconds(0.0, preferredTimescale: 600)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        }
        catch {
          print(error.localizedDescription)
          return nil
        }

    }
    func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        DispatchQueue.global().async { //1
            let asset = AVAsset(url: url) //2
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
            avAssetImageGenerator.appliesPreferredTrackTransform = true //4
            let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
                let thumbNailImage = UIImage(cgImage: cgThumbImage) //7
                DispatchQueue.main.async { //8
                    completion(thumbNailImage) //9
                }
            } catch {
                print(error.localizedDescription) //10
                DispatchQueue.main.async {
                    completion(nil) //11
                }
            }
        }
    } */
    
}
extension RecommendedCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendedArticleArr?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedCVCellID", for: indexPath as IndexPath) as! RecommendedCVCell
        
        let tmpDict = recommendedArticleArr?[indexPath.row] as! NSDictionary
        cell.recommendedArticleTitle.text = "\(tmpDict.value(forKey: "title")!)"
        cell.durationLbl.text =  "\(tmpDict.value(forKey: "link_duration")!)"
        
        cell.playImgView.isHidden = true
        
        let fileType = "\(tmpDict.value(forKey: "file_type")!)"
        if fileType != "<null>"{
            if fileType == "2" {
                cell.durationLbl.isHidden = true
                cell.playImgView.isHidden = true
                let tmpImg = "\(tmpDict.value(forKey: "photo1")!)"
                let theUrl = URL.init(string: (BASE_URL + tmpImg))
                cell.recommendedArticleImg.contentMode = .scaleAspectFill
                cell.recommendedArticleImg.sd_setImage(with: theUrl, placeholderImage: UIImage.init(named: "ic_placeholder_articles_item.png"), options: SDWebImageOptions.highPriority) { (img, err, cacheType, url) in
                    print("downloaded by sd WebImage....")
                }
            }else if fileType == "3"{
               /* cell.durationLbl.isHidden = false
                let tmpImg = "\(tmpDict.value(forKey: "link_thumb")!)"
                if tmpImg == "<null>" {
                    let thumbnailStr = "\(tmpDict.value(forKey: "link")!)"
                    let theUrl = URL.init(string: thumbnailStr)!
                    let thumbnailImg = createVideoThumbnail(from: theUrl)
                    cell.recommendedArticleImg.image = thumbnailImg
                    cell.playImgView.isHidden = false
                }else{
                    let theUrl = URL.init(string: tmpImg)
                    cell.recommendedArticleImg.sd_setImage(with: theUrl, placeholderImage: UIImage.init(named: "ic_placeholder_articles_item.png"), options: SDWebImageOptions.highPriority) { (img, err, cacheType, url) in
                        
                        if err == nil{
                            cell.playImgView.isHidden = false
                        }else{
                            cell.playImgView.isHidden = true
                        }
                    }
                }*/

            }else if fileType == "4"{
                let duration = "\(tmpDict.value(forKey: "link_duration")!)"
                if duration == "<null>"{
                    cell.durationLbl.text = "00:00"
                }else{
                    cell.durationLbl.text = duration
                }
                
                
                
//                cell.durationLbl.isHidden = false
                cell.durationLbl.isHidden = true
                let tmpImg = "\(tmpDict.value(forKey: "link_thumb")!)"
                if tmpImg == "<null>" {
                    let thumbnailStr = "\(tmpDict.value(forKey: "link")!)"
                    let theUrl = URL.init(string: thumbnailStr)!
                    
                    let vid = YouTubePlayer.videoIDFromYouTubeURL(theUrl)
                    let youtubeImgStr = "https://img.youtube.com/vi/" + vid! + "/1.jpg"
                    let youtubeImgURL = URL.init(string: youtubeImgStr)
                    
                    cell.recommendedArticleImg.sd_setImage(with: youtubeImgURL) { (img, err, cacheType, url) in
                        print("Youtube thumbnail img generated...")
                        cell.playImgView.isHidden = false
                    }
                }else{
                    let theUrl = URL.init(string: tmpImg)
                    cell.recommendedArticleImg.sd_setImage(with: theUrl, placeholderImage: UIImage.init(named: "ic_placeholder_articles_item.png"), options: SDWebImageOptions.highPriority) { (img, err, cacheType, url) in
                        
                        if err == nil{
                            cell.playImgView.isHidden = false
                        }else{
                            cell.playImgView.isHidden = true
                        }
                    }
                }
            }
            
            let lock = "\(tmpDict.value(forKey: "category_lock")!)"
            if lock != "<null>" {
                cell.lockImgView.isHidden = (lock == "0") ? true : false
            }else{
                print("category_lock is comming as <null>")
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.recommendedCV.frame.size.width/1.75), height: 105)
//        return CGSize(width: (self.searchCV.frame.size.width/2)-5, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let catLock : String?
        let tmpDict = recommendedArticleArr?[indexPath.row] as! NSDictionary
        let lock = "\(tmpDict.value(forKey: "category_lock")!)"
        let artID = "\(tmpDict.value(forKey: "id")!)"
        if lock != "<null>" {
            catLock = (lock == "0") ? "0" : "1"
            delegate?.recommendedArticleTapped(catLock: catLock ?? "1", articleID: artID)
        }else{
            print("category_lock is comming as <null>")
        }
    
    }
}

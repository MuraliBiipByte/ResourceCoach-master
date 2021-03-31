//
//  DocumentCell.swift
//  Resource Coach
//
//  Created by Apple on 26/12/20.
//  Copyright © 2020 Biipmi. All rights reserved.
//

import UIKit

protocol DocumentCellDelegate : class {
    
}
class DocumentCell: UITableViewCell {

    @IBOutlet weak var imgCV: UICollectionView!
    @IBOutlet weak var loadView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var myLoader: UIActivityIndicatorView!
    var delegate : DocumentCellDelegate?
    
    var articlesImgArr = [String]()
    var captionArr = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    self.imgCV.dataSource = self
    self.imgCV.delegate = self
    self.imgCV.register(UINib.init(nibName: "ImgCVCell", bundle: nil), forCellWithReuseIdentifier: "ImgCVCellID")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension DocumentCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 2
        self.articlesImgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImgCVCellID", for: indexPath as IndexPath) as! ImgCVCell
        //cell.articleImgView.image = UIImage.init(named: "assessmentbgimg")
        
        cell.articleImgView.sd_setImage(with: URL(string: self.articlesImgArr[indexPath.row]), placeholderImage: UIImage(named: "PlaceholderImg"))
        cell.articleImgView.contentMode = .scaleAspectFill
        if captionArr.count > indexPath.row {
            if captionArr[indexPath.row] != "<null>" {
                cell.captionLbl.text = captionArr[indexPath.row]
            }
        }
        
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return self.multiImgCV.frame.size
        return imgCV.frame.size
    }
}

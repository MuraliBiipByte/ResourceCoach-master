//
//  ArticleSearchVC.swift
//  Resource Coach
//
//  Created by Apple on 19/12/20.
//  Copyright © 2020 Biipmi. All rights reserved.
//

import UIKit
import YouTubePlayer

class ArticleSearchVC: UIViewController {

    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet var searchTxt: UITextField!
    @IBOutlet weak var SearchResultsTV: UITableView!
    
    var backGroundView: UIView? = nil
    var loadingView: HYCircleLoadingView?
    var img: UIImageView?
    var refreshCtrl : UIRefreshControl?
    var img1:UIImageView? = nil
//    var lblass1:UILabel? = nil
    var lblass:UILabel? = nil
    
    var dataArr : [NSDictionary]? = nil
    var arrVideoType : NSMutableArray? = nil
    var arrCategory_lock : NSMutableArray? = nil
    
    
    var usrId = "",uID = "", noMatchFound = "No Match Found", UserType = "", loginUserType = "", searchValue = "",selectedLanguage = ""
    
    @IBOutlet var keywordTV: UITableView!
    var keywordArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Search Articles"
        let lefticonButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 20, height: 20)))
        lefticonButton.setBackgroundImage(UIImage(named: "BackArrow"), for: .normal)
        lefticonButton.addTarget(self, action: #selector(self.backBtnTapped), for: UIControl.Event.touchUpInside)
        let leftbarButton = UIBarButtonItem(customView: lefticonButton)
        navigationItem.leftBarButtonItem = leftbarButton
        
        if let font = UIFont(name: "Roboto-Regular", size: 14) {
            navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: font
            ]
        }

        
    
        keywordArr = UserDefaults.standard.object(forKey: "Article_SearchKeywords") as? [String] ?? []
       
       
       self.keywordTV.dataSource = self
       self.keywordTV.delegate = self
       self.keywordTV.separatorColor = .clear
       self.keywordTV.isHidden = false
       self.keywordTV.tableFooterView = UIView.init(frame: CGRect.zero)
       self.keywordTV.reloadData()
        
//        if #available(iOS 13.0, *) {
//            let searchSysImg = UIImage(systemName: "Search")
//            searchBtn.setImage(searchSysImg, for: .normal)
//        } else {
//            // Fallback on earlier versions
//        }
        
        
        self.SearchResultsTV.isHidden = true
        self.SearchResultsTV.tableFooterView = UIView()
        
        let defaults = UserDefaults.standard
        usrId = (defaults.value(forKey: "id") as? String)!
        arrVideoType = NSMutableArray.init()
        arrCategory_lock = NSMutableArray.init()
        
        backGroundView = UIView(frame: view.bounds)
        view.addSubview(backGroundView!)
        backGroundView!.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.20)
        backGroundView!.isHidden = true
        
        loadingView = HYCircleLoadingView(frame: CGRect(x: view.frame.size.width / 2 - 30, y: view.frame.size.height / 2 - 30, width: 60, height: 60))
        img = UIImageView(frame: CGRect(x: view.frame.size.width / 2 + 15 - 38, y: view.frame.size.height / 2 + 15 - 38, width: 45, height: 45))
        img!.image = UIImage(named: "loading")
        backGroundView!.addSubview(img!)
        img!.isHidden = true
        loadingView!.isHidden = true
//        backGroundView!.addSubview(loadingView!)
//        view.bringSubviewToFront(backGroundView!)
        self.view.addSubview(self.loadingView!)
        
        dataArr =  [NSDictionary]() //NSMutableArray.init() as? [NSDictionary]
        refreshCtrl =  UIRefreshControl.init()
        refreshCtrl?.tintColor = UIColor.gray
        /* if strIdentify == "Home"{
            refreshCtrl?.addTarget(self, action: #selector(homeCatAllArticles), for: .valueChanged)
            btnSelectLanguage.isEnabled = false
            btnSelectLanguage.tintColor = UIColor.clear
        }else if strIdentify == "sequenceList" {
            refreshCtrl?.addTarget(self, action: #selector(getSequenceDetails), for: .valueChanged)
            btnSelectLanguage.isEnabled = false
            btnSelectLanguage.tintColor = UIColor.clear
        }else if searchIdentify == "search" {
            refreshCtrl?.addTarget(self, action: #selector(search), for: .valueChanged)
            btnSelectLanguage.isEnabled = false
            btnSelectLanguage.tintColor = UIColor.clear
        }else{
            refreshCtrl?.addTarget(self, action: #selector(getAllArticles), for: .valueChanged)
            btnSelectLanguage.isEnabled = false
            btnSelectLanguage.tintColor = UIColor.clear
        }*/
        
        
        refreshCtrl?.addTarget(self, action: #selector(search), for: .valueChanged)
        SearchResultsTV.addSubview(refreshCtrl!)
        SearchResultsTV.alwaysBounceVertical = true
    }
    
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(keywordArr, forKey: "Article_SearchKeywords")
    }

    
    
    
    @IBAction func search_Tapped(_ sender: Any) {
        
        keywordTV.isHidden = true
        if !keywordArr.contains(searchTxt.text!) {
            keywordArr.append(searchTxt.text!)
        }
        searchTxt.resignFirstResponder()
        
        searchValue  = searchTxt.text!
        search(searchStr: searchValue)
        
    }
    /* @objc func getAllArticles() {
        backGroundView!.isHidden = false
        loadingView!.startAnimation()
        loadingView!.isHidden = false
        img!.isHidden = false
        
        APIManager.sharedInstance()?.getAllArticles(withSubCatId: strSubCatId!, andWithUserid: usrId, andLanguage: selectedLanguage, andComplete: { [self] (success, result) in
            
            backGroundView!.isHidden = true
            loadingView!.stopAnimation()
            loadingView!.isHidden = true
            img!.isHidden = true
            refreshCtrl?.endRefreshing()
            
            if (!success){
                img1 = UIImageView(frame: CGRect(x: view.frame.size.width / 2 - 50, y: view.frame.size.height / 2 - 50, width: 100, height: 100))
                img1!.image = UIImage(named: "nodataimg")
                lblass1 = UILabel(frame: CGRect(x: 8, y: img1!.frame.origin.y + 108, width: view.frame.size.width - 16, height: 21))
                lblass1!.textAlignment = .center
                lblass1!.textColor = UIColor.lightGray
                lblass1!.font = UIFont(name: "Roboto-Regular", size: 14)
                lblass1!.text = Language.noArticlesAvailable()
                view.addSubview(img1!)
                view.addSubview(lblass1!)
                categoriesTV.isHidden = true
                return
            }
            
            lblass1?.isHidden = true
            img1?.isHidden = true
            let resultDict = result as! NSDictionary
            dataArr = resultDict.object(forKey: "article_data") as? [NSDictionary]
            
            loginUserType = "\(resultDict.value(forKey: "user_type")!)"
            SearchResultsTV.isHidden = false
            SearchResultsTV.reloadData()
        })
    }*/
    @objc func search(searchStr : String) {
        self.loadingView?.isHidden = false
        self.loadingView?.startAnimation()
        self.img?.isHidden = false
        
        SearchResultsTV.isHidden = false
        refreshCtrl?.endRefreshing()
        
        APIManager.sharedInstance()?.search(usrId, andWithKeyText: searchValue, andWithUserId: usrId, andComplete: { [self] (success, result) in
        
            self.loadingView?.isHidden = true
            self.loadingView?.stopAnimation()
            self.img?.isHidden = true
            
            if (!success){
                print("Not success from search api....")
                img = UIImageView(frame: CGRect(x: view.frame.size.width / 2 - 50, y: view.frame.size.height / 2 - 50, width: 100, height: 100))
                img!.image = UIImage(named: "nodataimg")
                lblass = UILabel(frame: CGRect(x: 8, y: img!.frame.origin.y + 108, width: view.frame.size.width - 16, height: 21))
                lblass!.textAlignment = .center
                lblass!.textColor = UIColor.lightGray
                lblass!.font = UIFont(name: "Roboto-Bold", size: 14)
                lblass!.text = noMatchFound
                view.addSubview(img!)
                view.addSubview(lblass!)
                SearchResultsTV.isHidden = true
                img!.isHidden = false
                lblass!.isHidden = false
                return
                
            }
            
            
            img1?.isHidden = true
            lblass?.isHidden = true
            let resultDict = result as! NSDictionary
            dataArr = resultDict.object(forKey: "article_data") as? [NSDictionary]
            loginUserType = "\(resultDict.value(forKey: "user_type")!)"
            
            SearchResultsTV.isHidden = false
            SearchResultsTV.reloadData()
            
        })
    }
    

}
extension ArticleSearchVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == keywordTV {
            return 47
        }else{
        //if tableView == SearchResultsTV{
            return 190
            
//            return UITableView.automaticDimension
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == keywordTV {
            return keywordArr.count
        }else{
            if dataArr != nil {
                return dataArr!.count
            }else{
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == keywordTV {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell")as! SearchTableViewCell
            cell.searchHistoryLbl.text = keywordArr[indexPath.row]
            return cell
        }else{
        //if tableView == SearchResultsTV{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCatTableViewCell") as! ArticleCatTableViewCell
            
            
//            let dict = dataArr?.object(at: indexPath.row) as? NSDictionary
            
            let dict = dataArr![indexPath.row] //as? NSDictionary
            arrVideoType?.add(dict.value(forKey: "article_type")! as Any)
            arrCategory_lock?.add(dict.value(forKey: "category_lock")! as Any)
            
            let title = "\(dict.value(forKey: "title") ?? "")"
            cell.lblArticleTitle.text = title.uppercased()
            let type = "\(dict.value(forKey: "file_type") ?? "")"
            if type == "2"{
                //Photo
                cell.articleVideoPlayImg.isHidden = true
            let imgStr = "\(dict.value(forKey: "photo1") ?? "")"
                
                let urlStr = BASE_URL + imgStr
                let theURL = URL.init(string: urlStr)
                
                cell.articleImage.sd_setImage(with: theURL, placeholderImage: UIImage(named: "ic_placeholder_articles_item.png"), options: .highPriority) { (img, err, cacheType, imageUrl) in
                    print("Image Downloaded by SD_WEB")}
                
                cell.lblArticleDuration.isHidden = true
            }else if type == "3"{
                let imgStr = "\(dict.value(forKey: "link_thumb") ?? "")"
                if imgStr != "<null>"{
                    let theURL = URL.init(string: imgStr)
                    cell.articleImage.sd_setImage(with: theURL, placeholderImage: UIImage(named: "ic_placeholder_articles_item.png"), options: .highPriority) { (img, err, cacheType, imageUrl) in
                        print("Image Downloaded by SD_WEB")}
                }else{
                    let thumbnailStr = "\(dict.value(forKey: "link")!)"
                    let theUrl = URL.init(string: thumbnailStr)!
                    
                    let vid = YouTubePlayer.videoIDFromYouTubeURL(theUrl)
                    let youtubeImgStr = "https://img.youtube.com/vi/" + vid! + "/1.jpg"
                    let youtubeImgURL = URL.init(string: youtubeImgStr)
                    
                    
                    cell.articleImage.sd_setImage(with: youtubeImgURL, placeholderImage: UIImage(named: "ic_placeholder_articles_item.png")) { (img, err, cacheType, url) in
                        print("Youtube thumbnail img generated...")
                    }
                }
                
                cell.articleVideoPlayImg.isHidden = false
                cell.lblArticleDuration.isHidden = true
                cell.lblArticleDuration.text = "\(dict.value(forKey: "link_duration") ?? "")"
            }else{
                let imgStr = "\(dict.value(forKey: "link_thumb") ?? "")"
                let theURL = URL.init(string: imgStr)
                
                cell.articleImage.sd_setImage(with: theURL, placeholderImage: UIImage(named: "ic_placeholder_articles_item.png"), options: .highPriority) { (img, err, cacheType, imageUrl) in
                    print("Image Downloaded by SD_WEB")}
            }
            
            if ((cell.articleImage.image == nil)){
                cell.articleImage.image = UIImage(named: "ic_placeholder_articles_item.png")
            }
            let auth = dict.value(forKey: "user_data") as? NSDictionary
            let tmp = "\(auth?.value(forKey: "username") ?? "")"
            let byAuth = Language.by() + tmp
            cell.lblAuthorName.text = byAuth
            let str = "\(dict.value(forKey: "avg_rate") ?? "")"
            if str == "0"{
                cell.lblRateCount.text = str
            }else{
                let rat = Float(str)
                cell.lblRateCount.text = String(format: "%.1f", rat!)
            }
            
            let number = "\(dict.value(forKey: "review_count") ?? "")"
            if number == "0"{
                cell.lblReviedCount.text = ""
            }else{
                cell.lblReviedCount.text = "\((number))"
            }
            
            var vie: String? = nil
            if let value = dict.value(forKey: "view_count") {
                vie = Language.views() + "\(value)"
            }
            cell.lblViewsCount.text = "\(vie ?? "")"
            let shortDes = dict.value(forKey: "short_description") as? String
            if shortDes! as NSObject == NSNull() {
                print("Null Data")
            } else {
                cell.lblShortDescription.text = dict.value(forKey: "short_description") as? String
            }
            
            cell.articleImage.layer.masksToBounds = true
            cell.articleImage.layer.cornerRadius = 5.0
            let watch = dict.value(forKey: "watched") as? String
            if watch == "yes" {
                cell.imgNew.isHidden = true
                cell.viewedImage.isHidden = false
            } else {
                cell.imgNew.isHidden = false
                cell.viewedImage.isHidden = true
            }
            
            
            
            let favStatu = dict["favorite"] as? String
            if favStatu == "no" {
                cell.favPressedImg.image = UIImage(named: "unfavorite")
            } else {
                cell.favPressedImg.image = UIImage(named: "favorite")
            }
            
            cell.btnFavorite.addTarget(self, action: #selector(addtoFavorite(sender:)), for: .touchUpInside)
            let layer = cell.layer
            layer.masksToBounds = false
            layer.cornerRadius = 4.0
            cell.layer.cornerRadius = 5.0
            cell.contentView.layer.cornerRadius = 5.0
            cell.lblBgRate.layer.masksToBounds = true
            cell.lblBgRate.layer.cornerRadius = 4.0
            
            
            
            let artType = arrVideoType![indexPath.row] as? String
            if (loginUserType == "non_subscriber") && (artType == "subscriber") {
                cell.btnFavorite.isEnabled = false
                //cell.imgArticleLock.hidden = NO;
            } else {
                cell.btnFavorite.isEnabled = true
                //cell.imgArticleLock.hidden = YES;
            }
            
            let catLock = arrCategory_lock![indexPath.row] as? String
            if catLock == "1" {
                cell.imgArticleLock.isHidden = false
                cell.btnFavorite.isHidden = true
                cell.favPressedImg.isHidden = true
            } else {
                cell.imgArticleLock.isHidden = true
                cell.btnFavorite.isHidden = false
                cell.favPressedImg.isHidden = false
            }
            
            
            
            
            
                let direction: CGFloat = cell != nil ? -1 : 1
            cell.transform = CGAffineTransform(translationX: cell.bounds.size.width * direction, y: 0)
                UIView.animate(withDuration: 0.25, animations: {
                    cell.transform = CGAffineTransform.identity
                })
            
            return cell
        }
        
        //return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == keywordTV {
            let selectedStr = self.keywordArr[indexPath.row]
            //callFilterService(searchStr: selectedStr)
            searchTxt.text = selectedStr
            searchValue = selectedStr
            search(searchStr: selectedStr)
            self.keywordTV.isHidden = true
        }
        else{
            
            
            let catLock = arrCategory_lock![indexPath.row] as? String
            if catLock == "1" {
                let subscriptionDedaaBoxClass = storyboard!.instantiateViewController(withIdentifier: "SubScribeToDedaaBoxViewController") as? SubScribeToDedaaBoxViewController
                if let subscriptionDedaaBoxClass = subscriptionDedaaBoxClass {
                    navigationController?.pushViewController(subscriptionDedaaBoxClass, animated: true)
                }
            } else {
                let dict = dataArr![indexPath.row] as? [AnyHashable : Any]
                let articleid = dict?["id"] as? String
                let details = storyboard!.instantiateViewController(withIdentifier: "ArticleDetailsVCSBID") as? ArticleDetailsVC
                details?.articleId = articleid!
                details?.strMinicertificationId = ""
                if let details = details {
                    navigationController?.pushViewController(details, animated: true)
                }
            }
        }
    }
    
    @objc func addtoFavorite(sender: Any?) {
        
        let favBtn = sender as! UIButton
        let clickedCell = favBtn.superview?.superview as? ArticleCatTableViewCell
        var indexPathCell: IndexPath? = nil
        if let clickedCell = clickedCell {
            indexPathCell = SearchResultsTV.indexPath(for: clickedCell)
        }
        let dict = dataArr![indexPathCell?.row ?? 0] as? [AnyHashable : Any]
        let strArticleId = dict?["id"] as? String
        let favStatu = dict?["favorite"] as? String
        
        if favStatu == "no" {
                // [Utility showLoading:self];
            backGroundView!.isHidden = false
            loadingView!.startAnimation()
            loadingView!.isHidden = false
            img!.isHidden = false
                
            APIManager.sharedInstance()?.addArticleToMyFavoriteArticles(withUserId: usrId, andWithArticleId: strArticleId, andComplete: { [self] (success, result) in
            
                backGroundView!.isHidden = true
                loadingView!.startAnimation()
                loadingView!.isHidden = true
                img!.isHidden = true
                
                if (!success){
                    let alert = SCLAlertView.init(newWindow: ())
                    alert!.horizontalButtons = true
                    alert!.showSuccess(AppName, subTitle: result as? String, closeButtonTitle: Language.ok(), duration: 0.0)
                    return
                }
                /* if strIdentify == "sequenceList" {
                    getSequenceDetails()
                } else if searchIdentify == "search" {
                    search()
                } else {
                    getAllArticles()
                }*/
                
                search(searchStr: searchValue)
                
            })
            
            
        }else{
            let alert = SCLAlertView.init(newWindow: ())
            alert!.horizontalButtons = true
            alert?.addButton(Language.ok(), actionBlock: { [self] in
                let clickedCell = favBtn.superview?.superview as? ArticleCatTableViewCell
                var indexPathCell: IndexPath? = nil
                if let clickedCell = clickedCell {
                    indexPathCell = SearchResultsTV.indexPath(for: clickedCell)
                }
                let dict = dataArr![indexPathCell?.row ?? 0] as? [AnyHashable : Any]
                let strArticleId = dict?["id"] as? String
                backGroundView!.isHidden = false
                loadingView!.startAnimation()
                loadingView!.isHidden = false
                img!.isHidden = false
                
                APIManager.sharedInstance()?.removeArticleFromMyFavoriteArticles(withUserId: usrId, andWithArticleId: strArticleId, andComplete: { (success, result) in
                    backGroundView!.isHidden = true
                    loadingView!.startAnimation()
                    loadingView!.isHidden = true
                    img!.isHidden = true
                    
                    if !success {
                        Utility.showAlert(AppName, withMessage: result as? String)
                        return
                    }
                    /*if strIdentify == "sequenceList" {
                        getSequenceDetails()
                    } else if searchIdentify == "search" {
                        search()
                    } else {
                        getAllArticles()
                    }*/
                    search(searchStr: searchValue)
                    
                })
            })
            
            alert?.showSuccess(AppName, subTitle: Language.removearticlefromFavouriteList(), closeButtonTitle: "Cancel", duration: 0.0)
        }
    }
    
    
}
extension ArticleSearchVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        keywordTV.isHidden = true
        if !keywordArr.contains(searchTxt.text!) {
            keywordArr.append(searchTxt.text!)
        }
        searchTxt.resignFirstResponder()
//        callFilterService(searchStr: searchTxt.text!)
        search(searchStr: searchTxt.text!)
        return true
        
    }
}

//
//  GetAllArticlesVC.swift
//  Resource Coach
//
//  Created by Apple on 17/12/20.
//  Copyright © 2020 Biipmi. All rights reserved.
//

import UIKit
import YouTubePlayer

class GetAllArticlesVC: UIViewController {

    @objc var strSubCatId : String? = nil
    @objc var subCatBack : String? = nil
    @objc var strIdentify : String? = nil
    @objc var searchIdentify : String? = nil
    @objc var strSeqId : String? = nil
    
    @IBOutlet weak var categoriesTV: UITableView!
    @IBOutlet weak var btnSelectLanguage: UIBarButtonItem!
    
    var usrId = "",uID = "", noMatchFound = "", UserType = "", loginUserType = "", searchValue = "",selectedLanguage = ""
    
    var backGroundView: UIView? = nil
    var loadingView: HYCircleLoadingView?
    var img: UIImageView?
    
    var refreshCtrl : UIRefreshControl?
    
    var img1:UIImageView? = nil
    var lblass1:UILabel? = nil
    var lblass:UILabel? = nil
    
    var dataArr : [NSDictionary]? = nil
    
    var arrVideoType : NSMutableArray? = nil
    var arrCategory_lock : NSMutableArray? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("GetAllArticlesVC.....")
        let defaults = UserDefaults.standard
        usrId = (defaults.value(forKey: "id") as? String)!
        
        arrVideoType = NSMutableArray.init()
        arrCategory_lock = NSMutableArray.init()
        
        configureNavigationBar()
        
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
        backGroundView!.addSubview(loadingView!)
        view.bringSubviewToFront(backGroundView!)
        //self.view.addSubview(self.loadingView!)
        
        categoriesTV.isHidden = true
        dataArr =  [NSDictionary]() //NSMutableArray.init() as? [NSDictionary]
        refreshCtrl =  UIRefreshControl.init()
        refreshCtrl?.tintColor = UIColor.gray
        if strIdentify == "Home"{
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
        }
        
        
//        let defaults = UserDefaults.standard
        uID = (defaults.value(forKey: "id") as? String)!
        UserType = defaults.value(forKey: "usertype") as! String
        checkUserType()
        if strIdentify == "sequenceList" {
            getSequenceDetails()
        }else if searchIdentify == "search" {
            
        }else if strIdentify == "Home"{
            homeCatAllArticles()
        }else{
            getAllArticles()
        }
        
        categoriesTV.addSubview(refreshCtrl!)
        categoriesTV.alwaysBounceVertical = true
       
    }
    
    @objc func homeCatAllArticles() {
        backGroundView!.isHidden = false
        loadingView!.startAnimation()
        loadingView!.isHidden = false
        img!.isHidden = false
        
        APIManager.sharedInstance()?.homeCategoryArticlesList(withCatId: strSubCatId, andWithUserId: usrId, andComplete: { [self] (success, result) in
        
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
            categoriesTV.isHidden = false
            categoriesTV.reloadData()
            
            
        })
    }
    @objc func getSequenceDetails() {
        backGroundView!.isHidden = false
        loadingView!.startAnimation()
        loadingView!.isHidden = false
        img!.isHidden = false
        
        APIManager.sharedInstance()?.getSequenceDetails(withUserId: usrId, andWithSequenceId: self.strSeqId, andComplete: { [self] (success, result) in
            
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
                lblass1!.text = Language.noSequenceAvailable()
                view.addSubview(img1!)
                view.addSubview(lblass1!)
                return
            }
            img1?.isHidden = true
            let resultDict = result as! NSDictionary
            dataArr = resultDict.object(forKey: "sequence_data") as? [NSDictionary]
            loginUserType = "\(resultDict.value(forKey: "user_type")!)"
            categoriesTV.isHidden = false
            categoriesTV.reloadData()
        })
    }
    @objc func search() {
        
        
        backGroundView!.isHidden = false
        loadingView!.startAnimation()
        loadingView!.isHidden = false
        img!.isHidden = false
        categoriesTV.isHidden = false
        refreshCtrl?.endRefreshing()
        
        APIManager.sharedInstance()?.search(usrId, andWithKeyText: searchValue, andWithUserId: usrId, andComplete: { [self] (success, result) in
            
            backGroundView!.isHidden = true
            loadingView!.stopAnimation()
            loadingView!.isHidden = true
            img!.isHidden = true
            
            if (!success){
                
                img = UIImageView(frame: CGRect(x: view.frame.size.width / 2 - 50, y: view.frame.size.height / 2 - 50, width: 100, height: 100))
                img!.image = UIImage(named: "nodataimg")
                lblass = UILabel(frame: CGRect(x: 8, y: img!.frame.origin.y + 108, width: view.frame.size.width - 16, height: 21))
                lblass!.textAlignment = .center
                lblass!.textColor = UIColor.lightGray
                lblass!.font = UIFont(name: "Roboto-Bold", size: 14)
                lblass!.text = noMatchFound
                view.addSubview(img!)
                view.addSubview(lblass!)
                categoriesTV.isHidden = true
                img!.isHidden = false
                lblass!.isHidden = false
                return
            }
            
            img1?.isHidden = true
            lblass?.isHidden = true
            let resultDict = result as! NSDictionary
            dataArr = resultDict.object(forKey: "article_data") as? [NSDictionary]
            loginUserType = "\(resultDict.value(forKey: "user_type")!)"
            
            categoriesTV.isHidden = false
            categoriesTV.reloadData()
            
        })
    }
    @objc func getAllArticles() {
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
            categoriesTV.isHidden = false
            categoriesTV.reloadData()
        })
    }
    
    func configureNavigationBar() {
        
        let defaults = UserDefaults.standard
        let language = defaults.value(forKey: "language") 
        
        if strIdentify == "sequenceList" {
            if language != nil {
                if language as! String == "2"{
                    self.title = "mini-သင်ခန်းစာများ Lis"
                    noMatchFound = "မီးခြစ်မျှမတွေ့"
                    if let font = UIFont(name: "Roboto-Regular", size: 14) {
                        navigationController?.navigationBar.titleTextAttributes = [
                            NSAttributedString.Key.foregroundColor: UIColor.white,
                            NSAttributedString.Key.font: font
                        ]
                    }
                }else if language as! String == "3"{
                    noMatchFound = "မီးခြစ်မျှမတွေ့"
                    let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
                    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
                    label.text = "mini-သင်ခန်းစာများ Lis"
                    label.textColor = UIColor.white
                    label.textAlignment = .center
                    view.addSubview(label)
                    navigationItem.titleView = view
                    label.font = UIFont(name: "Roboto-Regular", size: 14)
                    
                }else{
                    self.title = "Mini-Lessons List"
                    noMatchFound="No Match Found"
                    if let font = UIFont(name: "Roboto-Regular", size: 14) {
                        navigationController?.navigationBar.titleTextAttributes = [
                            NSAttributedString.Key.foregroundColor: UIColor.white,
                            NSAttributedString.Key.font: font
                        ]
                    }
                }
            }else{
                self.title = "Mini-Lessons List"
                noMatchFound="No Match Found"
                if let font = UIFont(name: "Roboto-Regular", size: 14) {
                    navigationController?.navigationBar.titleTextAttributes = [
                        NSAttributedString.Key.foregroundColor: UIColor.white,
                        NSAttributedString.Key.font: font
                    ]
                }
            }
            
        }else{
            if language != nil {
                if language as! String == "2"{
                    noMatchFound="မီးခြစ်မျှမတွေ့"
                    let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
                    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
                    label.text = Language.articles()
                    label.textColor = UIColor.white
                    label.textAlignment = .center
                    view.addSubview(label)
                    navigationItem.titleView = view
                    label.font = UIFont(name: "Roboto-Regular", size: 14)
                    
                    if let font = UIFont(name: "Roboto-Regular", size: 14) {
                        navigationController?.navigationBar.titleTextAttributes = [
                            NSAttributedString.Key.foregroundColor: UIColor.white,
                            NSAttributedString.Key.font: font
                        ]
                    }
                }else if language as! String == "3"{
                    noMatchFound="မီးခြစ်မျှမတွေ့"
                    let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
                    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
                    label.text = "ဆောင်းပါးများ"
                    label.textColor = UIColor.white
                    label.textAlignment = .center
                    view.addSubview(label)
                    navigationItem.titleView = view
                    label.font = UIFont(name: "Roboto-Regular", size: 14)
                }else if searchIdentify == "search" {
                    noMatchFound="No matches found"
                    if let font = UIFont(name: "Roboto-Regular", size: 14) {
                        navigationController?.navigationBar.titleTextAttributes = [
                            NSAttributedString.Key.foregroundColor: UIColor.white,
                            NSAttributedString.Key.font: font
                        ]
                    }
                }else{
                    self.title="Lessons"
                    noMatchFound="No matches found"
                    if let font = UIFont(name: "Roboto-Regular", size: 14) {
                        navigationController?.navigationBar.titleTextAttributes = [
                            NSAttributedString.Key.foregroundColor: UIColor.white,
                            NSAttributedString.Key.font: font
                        ]
                    }
                }
                
            }else{
                self.title="Lessons"
                noMatchFound="No matches found"
                if let font = UIFont(name: "Roboto-Regular", size: 14) {
                    navigationController?.navigationBar.titleTextAttributes = [
                        NSAttributedString.Key.foregroundColor: UIColor.white,
                        NSAttributedString.Key.font: font
                    ]
                }
            }
        }
        
        
        
    }
    @IBAction func backBtnTapped(_ sender: UIBarButtonItem) {
        if strIdentify == "sequenceList" {
            let article = storyboard!.instantiateViewController(withIdentifier: "SequenceViewController") as? SequenceViewController
            if let article = article {
                navigationController?.pushViewController(article, animated: true)
            }
        } else if searchIdentify == "search" {
            let homeView = storyboard!.instantiateViewController(withIdentifier: "RootViewController") as? RootViewController
            if let homeView = homeView {
                present(homeView, animated: true)
            }
        } else if subCatBack == "Back" {
            navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        /* let defaults = UserDefaults.standard
        uID = (defaults.value(forKey: "id") as? String)!
        UserType = defaults.value(forKey: "usertype") as! String
        checkUserType()
        if strIdentify == "sequenceList" {
            getSequenceDetails()
        }else if searchIdentify == "search" {
            
        }else if strIdentify == "Home"{
            homeCatAllArticles()
        }else{
            getAllArticles()
        }*/
        
        
        
        
    }
    
    func checkUserType(){
        APIManager.sharedInstance()?.checkingUserType(uID, andComplete: { [self] (success, result) in
            
            if (!success){
                return
            }else{
                
                let resultDict = result as! NSDictionary
                let userData = resultDict.value(forKey: "userdata") as! NSDictionary
                let type = userData.value(forKey: "usertype")
                let userIds = userData.value(forKey: "user_id")
                let userName = userData.value(forKey: "username")
                
                if !(UserType == type as! String){
                    
                    let alert = UIAlertController(title: AppName, message: "Your user account type has been changed by Admin", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                        let defaults = UserDefaults.standard
                        defaults.set(userIds, forKey: "id")
                        defaults.set(userName, forKey: "name")
                        defaults.set(type, forKey: "usertypeid")
                        defaults.set(type, forKey: "usertype")

                        let homeView = self.storyboard!.instantiateViewController(withIdentifier: "RootViewController") as? RootViewController
                        if let homeView = homeView {
                            self.present(homeView, animated: true)
                        }


                    })
                    alert.addAction(ok)
                    present(alert, animated: true)

                }
                
            }
            
        })
    }

}
extension GetAllArticlesVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == categoriesTV{
            return 190
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == categoriesTV{
            return dataArr!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == categoriesTV{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCatTableViewCell") as! ArticleCatTableViewCell
            
            
//            let dict = dataArr?.object(at: indexPath.row) as? NSDictionary
            
            let dict = dataArr![indexPath.row] //as? NSDictionary
            arrVideoType?.add(dict.value(forKey: "article_type")! as Any)
            arrCategory_lock?.add(dict.value(forKey: "category_lock")! as Any)
            
            let title = "\(dict.value(forKey: "title") ?? "")"
            cell.lblArticleTitle.text = title.uppercased()
            let type = "\(dict.value(forKey: "file_type") ?? "")"
            
            cell.lblArticleDuration.isHidden = true
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
                let theURL = URL.init(string: imgStr)
                cell.articleImage.sd_setImage(with: theURL, placeholderImage: UIImage(named: "ic_placeholder_articles_item.png"), options: .highPriority) { (img, err, cacheType, imageUrl) in
                    print("Image Downloaded by SD_WEB")}
                cell.articleVideoPlayImg.isHidden = false
                cell.lblArticleDuration.isHidden = true
                cell.lblArticleDuration.text = "\(dict.value(forKey: "link_duration") ?? "")"
            }else{
                /* let imgStr = "\(dict.value(forKey: "link_thumb") ?? "")"
                let theURL = URL.init(string: imgStr)
                
                cell.articleImage.sd_setImage(with: theURL, placeholderImage: UIImage(named: "ic_placeholder_articles_item.png"), options: .highPriority) { (img, err, cacheType, imageUrl) in
                    print("Image Downloaded by SD_WEB")} */
                
                
                
            
                let tmpImg = "\(dict.value(forKey: "link_thumb")!)"
                if tmpImg == "<null>" {
                    let thumbnailStr = "\(dict.value(forKey: "link")!)"
                    let theUrl = URL.init(string: thumbnailStr)!
                    
                    let vid = YouTubePlayer.videoIDFromYouTubeURL(theUrl)
                    let youtubeImgStr = "https://img.youtube.com/vi/" + vid! + "/1.jpg"
                    let youtubeImgURL = URL.init(string: youtubeImgStr)
                    
                    
                    cell.articleImage.sd_setImage(with: youtubeImgURL, placeholderImage: UIImage(named: "ic_placeholder_articles_item.png")) { (img, err, cacheType, url) in
                        print("Youtube thumbnail img generated...")
                    }
                }else{
                    let theUrl = URL.init(string: tmpImg)
                    cell.articleImage.sd_setImage(with: theUrl, placeholderImage: UIImage.init(named: "ic_placeholder_articles_item.png"), options: SDWebImageOptions.highPriority) { (img, err, cacheType, url) in
                        
                    }
                }
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
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == categoriesTV {
            let catLock = arrCategory_lock![indexPath.row] as? String
            if catLock == "1" {
                let subscriptionDedaaBoxClass = storyboard!.instantiateViewController(withIdentifier: "SubScribeToDedaaBoxViewController") as? SubScribeToDedaaBoxViewController
                if let subscriptionDedaaBoxClass = subscriptionDedaaBoxClass {
                    navigationController?.pushViewController(subscriptionDedaaBoxClass, animated: true)
                }
            } else {
                let dict = dataArr![indexPath.row] as? [AnyHashable : Any]
                let articleid = dict?["id"] as? String
                
//                let details = storyboard!.instantiateViewController(withIdentifier: "ArticleDetailsViewController") as? ArticleDetailsViewController
                
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
            indexPathCell = categoriesTV.indexPath(for: clickedCell)
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
                if strIdentify == "sequenceList" {
                    getSequenceDetails()
                } else if searchIdentify == "search" {
                    search()
                } else {
                    getAllArticles()
                }
                
            })
            
            
        }else{
            let alert = SCLAlertView.init(newWindow: ())
            alert!.horizontalButtons = true
            alert?.addButton(Language.ok(), actionBlock: { [self] in
                let clickedCell = favBtn.superview?.superview as? ArticleCatTableViewCell
                var indexPathCell: IndexPath? = nil
                if let clickedCell = clickedCell {
                    indexPathCell = categoriesTV.indexPath(for: clickedCell)
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
                    if strIdentify == "sequenceList" {
                        getSequenceDetails()
                    } else if searchIdentify == "search" {
                        search()
                    } else {
                        getAllArticles()
                    }
                    
                })
            })
            
            alert?.showSuccess(AppName, subTitle: Language.removearticlefromFavouriteList(), closeButtonTitle: "Cancel", duration: 0.0)
        }
    }
    
}

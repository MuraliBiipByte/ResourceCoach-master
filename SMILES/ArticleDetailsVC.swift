//
//  ArticleDetailsVC.swift
//  Resource Coach
//
//  Created by Apple on 22/12/20.
//  Copyright © 2020 Biipmi. All rights reserved.
//

//if (strQuizStatus == NSNull()) || (articleVideoType == "mini_certification") {
//}

import UIKit
import AVKit
import YouTubePlayer

class ArticleDetailsVC: UIViewController {

    var selectedAlignementOption = 0
    var dismissable = false
    var recommendedArticleArr : NSArray?
    
    var removeQuizTitle : Bool?
    var numberOfTotalRows : Int = 0
    var numberOfStaticRows : Int = 6
    var numberOfQuizRows : Int = 0
    var arrOfQAStruct = [QAStruct]()
    
    var selectionImg = UIImage()
    var unSelectionImg = UIImage()
    var correctImg = UIImage()
    var wrongImg = UIImage()
    
    
    @objc var articleId = "",strMinicertificationId = ""
    var postedOn = "",viewsArt = "",by = "",Ok = "", Cancel = "",removeFav = "",corectAnswer = ""
    var startTime = "",endTime = ""
    var userId = "",UserType = ""
    var articleVideoType = "",authoreId = "",authorName = "",authorImg = "",createdDate = "",viewCount = "",strFavStatus = "",ratingCount = "",avgrate = ""
    var strVideoEndTime = ""
    var articleTitle = "",strBookMark = "",loginUserType = ""
    
    var articleType,articleImage1,articleImage2,articleImage3,articleImgTitle1,articleImgTitle2,articleImgTitle3,artticleVideo,articleVideoThumb,articleYoutubeLinks,strArticleDuration : String?
    
    var articleShortDescription,articleLongDescription : String?
//    var articleImgArr = [String]()
    
    var chatButton : UIBarButtonItem? = nil
    var btnBookMark : UIBarButtonItem? = nil
    
    
    let player = AVPlayer()
    
    var startAndEndtimeDefaults: UserDefaults? = nil
    
    
    var backGroundView: UIView? = nil
    var loadingView: HYCircleLoadingView?
    var img: UIImageView?
    
    @IBOutlet weak var theContainerTV: UITableView!
    var dataDict : NSDictionary? = nil
    //var quizArr : NSArray? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theContainerTV.dataSource = self
        theContainerTV.delegate = self
        
        theContainerTV.register(UINib(nibName: "RatingCell", bundle: nil), forCellReuseIdentifier: "RatingCellID" )
        theContainerTV.register(UINib(nibName: "ImageVideoCell", bundle: nil), forCellReuseIdentifier: "ImageVideoCellID" )
        theContainerTV.register(UINib(nibName: "SecondCell", bundle: nil), forCellReuseIdentifier: "SecondCellID")
        theContainerTV.register(UINib(nibName: "DescriptionCell", bundle: nil), forCellReuseIdentifier: "DescriptionCellID")
        theContainerTV.register(UINib(nibName: "QuizTitleCell", bundle: nil), forCellReuseIdentifier: "QuizTitleCellID")
        theContainerTV.register(UINib(nibName: "QACell", bundle: nil), forCellReuseIdentifier: "QACellID")
        theContainerTV.register(UINib(nibName: "SharingCell", bundle: nil), forCellReuseIdentifier: "SharingCellID")
        theContainerTV.register(UINib(nibName: "RecommendedCell", bundle: nil), forCellReuseIdentifier: "RecommendedCellID")
        theContainerTV.register(UINib(nibName: "DocumentCell", bundle: nil), forCellReuseIdentifier: "DocumentCellID")
        
        selectionImg = UIImage(named: "radioCheck")!
        unSelectionImg = UIImage(named: "radioUncheck")!
        
        correctImg = UIImage(named: "checkMark")!
        wrongImg = UIImage(named: "redRadiobutton")!
        
        
        backGroundView = UIView(frame: view.bounds)
        view.addSubview(backGroundView!)
        backGroundView!.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.20)
        backGroundView!.isHidden = false
        
        loadingView = HYCircleLoadingView(frame: CGRect(x: view.frame.size.width / 2 - 30, y: view.frame.size.height / 2 - 30, width: 60, height: 60))
        img = UIImageView(frame: CGRect(x: view.frame.size.width / 2 + 15 - 38, y: view.frame.size.height / 2 + 15 - 38, width: 45, height: 45))
        img!.image = UIImage(named: "loading")
        backGroundView!.addSubview(img!)
        img!.isHidden = false
        loadingView!.isHidden = false
        backGroundView!.addSubview(loadingView!)
        view.bringSubviewToFront(backGroundView!)
        
        
        
        let userDefaults = UserDefaults.standard
        userId = userDefaults.value(forKey: "id") as! String
        UserType = userDefaults.value(forKey: "usertype") as! String
        checkUserType()
        getArticleDetails()

        configureNavigationBar()
        
        
        
        startAndEndtimeDefaults = UserDefaults.standard
        startAndEndtimeDefaults?.setValue("", forKey: "date")
        startAndEndtimeDefaults?.setValue("", forKey: "identity")
        startAndEndtimeDefaults?.setValue("", forKey: "userid")
        startAndEndtimeDefaults?.setValue("", forKey: "articleid")

        let str = startAndEndtimeDefaults?.value(forKey: "userid") as? String
        print("userid is \(str ?? "")")
        
        let currentDate = Date()
        let timeZone = NSTimeZone.default as NSTimeZone
        // or Timezone with specific name like
        // [NSTimeZone timeZoneWithName:@"Europe/Riga"] (see link below)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone as TimeZone
        dateFormatter.dateFormat = "HH:mm:ss"
        startTime = dateFormatter.string(from: currentDate)
        
        startAndEndtimeDefaults!.set(startTime, forKey: "starttime")
        startAndEndtimeDefaults!.setValue("identity", forKey: "identity")
        startAndEndtimeDefaults!.setValue(userId, forKey: "userid")
        startAndEndtimeDefaults!.setValue(articleId, forKey: "articleid")

        let str1 = startAndEndtimeDefaults!.value(forKey: "date") as? String
        print("date  is \(str1 ?? "")")
        
        
        let defaults = UserDefaults.standard
        defaults.setValue(strMinicertificationId, forKey: "miniid")
        defaults.setValue(articleId, forKey: "artid")

        if strVideoEndTime == "" {
            defaults.setValue("00:00:00", forKey: "videoStart")
        } else {
            defaults.setValue(strVideoEndTime, forKey: "videoStart")
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let uDefaults = UserDefaults.standard
        if uDefaults.bool(forKey: "NeedToReloadArticleDetails") {
            uDefaults.set(false, forKey: "NeedToReloadArticleDetails")
            getArticleDetails()
        } else {
            print("No need to reload ArticleDetails....")
        }
    }
    func checkUserType (){
        APIManager.sharedInstance()?.checkingUserType(userId, andComplete: { [self] (success, result) in
            
            if (!success){
                return
            }else{
                
                
                let resultDict = result as! NSDictionary
                let userdata = resultDict.value(forKey: "userdata") as! NSDictionary
                
//                let userdata = dataDict.value(forKey: "userdata") as! NSDictionary
                let type = userdata["usertype"] as? String
                let userIds = userdata["user_id"] as? String
                let userName = userdata["username"] as? String
                
                if UserType != type {
                    let alert = UIAlertController(title: AppName, message: "Your user account type has been changed by Admin", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                        let defaults = UserDefaults.standard
                        defaults.set(userIds, forKey: "id")
                        defaults.set(userName, forKey: "name")
                        defaults.set(type, forKey: "usertypeid")
                        defaults.set(type, forKey: "usertype")

                        let rootVC = self.storyboard!.instantiateViewController(withIdentifier: "RootViewController") as? RootViewController
                        if let homeView = rootVC {
                            self.present(homeView, animated: true)
                        }


                    })
                    alert.addAction(ok)
                    present(alert, animated: true)

                }else{
                    
                }
            }
            
        })
    }
    func getArticleDetails(){
        backGroundView!.isHidden = false
        loadingView!.startAnimation()
        loadingView!.isHidden = false
        img!.isHidden = false
        APIManager.sharedInstance()?.getArticleDetails(withArticleId: articleId, withUserid: userId, andWithAssessmentId: strMinicertificationId, andComplete: { [self] (success, result) in
            
            loadingView?.stopAnimation()
            backGroundView!.isHidden = true
            loadingView!.isHidden = true
            
            if !success {
                if result != nil {
                    Utility.showAlert(AppName, withMessage: (result as! String))
                }else{
                    Utility.showAlert(AppName, withMessage: "something went wrong")
                }
                
                return
            }
            let resultDict = result as! NSDictionary
            dataDict = resultDict.value(forKey: "data") as? NSDictionary
            let articleDataArr = dataDict!.object(forKey: "article_data") as! NSArray
            let subArticleDataArr = articleDataArr.value(forKey: "sub_article_data") as! NSArray
            let aDict = articleDataArr[0] as! NSDictionary
            let userDataDict = aDict.value(forKey: "user_data") as! NSDictionary
            
            //Author Part
            articleTitle = "\(aDict.value(forKey: "title")!)"
            let subCount = "\(aDict.value(forKey: "count_sub_articles")!)"
            
            strBookMark = "\(aDict.value(forKey: "bookmarked")!)"
            //btnBookMark?.image = UIImage(named: "bookmark")
            if strBookMark == "0" {
                btnBookMark?.isEnabled = true
            }else{
                btnBookMark?.isEnabled = false
            }
            
            createdDate = "\(aDict.value(forKey: "relative_date")!)"
            viewCount = "\(aDict.value(forKey: "view_count")!)"
            strFavStatus = "\(aDict.value(forKey: "favorite")!)"
            ratingCount = "\(aDict.value(forKey: "review_count")!)"
            avgrate = "\(aDict.value(forKey: "avg_rate")!)"
            
            authorName = "\(userDataDict.value(forKey: "username")!)"
            authorImg = "\(userDataDict.value(forKey: "user_image")!)"
            authoreId = "\(userDataDict.value(forKey: "id")!)"
            loginUserType = "\(dataDict!.value(forKey: "login_usertype")!)"
            
            // Image Part
            articleType = "\(aDict.value(forKey: "file_type")!)"
            articleImage1 = "\(aDict.value(forKey: "photo_orig1")!)"
            articleImage2 = "\(aDict.value(forKey: "photo_orig2")!)"
            articleImage3 = "\(aDict.value(forKey: "photo_orig3")!)"
            articleImgTitle1 = "\(aDict.value(forKey: "caption_image1")!)"
            articleImgTitle2 = "\(aDict.value(forKey: "caption_image2")!)"
            articleImgTitle3 = "\(aDict.value(forKey: "caption_image3")!)"
            artticleVideo = "\(aDict.value(forKey: "video")!)"
            articleVideoThumb = "\(aDict.value(forKey: "video_thumb")!)"
            articleYoutubeLinks = "\(aDict.value(forKey: "link")!)"
            strArticleDuration = "\(aDict.value(forKey: "link_duration")!)"
//            "\(aDict.value(forKey: "")!)"
            
            
            
            //Description Part
//            articleShortDescription=[[articleData objectAtIndex:0]valueForKey:@"short_description"];
//            artcleLongDescription=[[articleData objectAtIndex:0] valueForKey:@"description"];
            
            articleShortDescription =  "\(aDict.value(forKey: "short_description")!)"
            articleLongDescription =  "\(aDict.value(forKey: "description")!)"
            
            //Recommended Part
            recommendedArticleArr = aDict.value(forKey: "recomended_article_data") as? NSArray ?? NSArray()
            
            
            //Quiz Part
            let quizArr : NSArray = aDict.value(forKey: "quiz_data") as? NSArray ?? NSArray()
            if quizArr.count == 0{
                
            }
            
            removeQuizTitle = quizArr.count == 0 ? true : false
            numberOfTotalRows = (quizArr.count ) + numberOfStaticRows
            numberOfQuizRows = quizArr.count
            
            self.arrOfQAStruct.removeAll()
             for _ in 1...4{
                 let aStruct = QAStruct()
                 self.arrOfQAStruct.append(aStruct)
             }
            
            
            for aDict in quizArr {
                var aStruct = QAStruct()
                let tempDict = aDict as! NSDictionary
                aStruct.Question = (tempDict.value(forKey: "question") as! String)
                aStruct.answer1 = (tempDict.value(forKey: "option1") as! String)
                aStruct.answer2 = (tempDict.value(forKey: "option2") as! String)
                aStruct.answer3 = (tempDict.value(forKey: "option3") as! String)
                aStruct.answer4 = (tempDict.value(forKey: "option4") as! String)
                aStruct.actualAnwser = (tempDict.value(forKey: "answer") as! String)
                
                aStruct.isOption1Tapped = false
                aStruct.isOption2Tapped = false
                aStruct.isOption3Tapped = false
                aStruct.isOption4Tapped = false
                
                aStruct.isAnswerImgViewHidden = true
                aStruct.isSubmitBtnTapped = false
                
                self.arrOfQAStruct.append(aStruct)
            }
            
            let aStructSharing = QAStruct()
            let aStructForRecommended = QAStruct()
            self.arrOfQAStruct.append(aStructSharing)
            self.arrOfQAStruct.append(aStructForRecommended)
            
            theContainerTV.reloadData()
            
        })
    }
    
    func configureNavigationBar() {
        let defaults = UserDefaults.standard
        let language1 = defaults.value(forKey: "language")
        
        if language1 != nil {
            if language1 as! String  == "2" {
                self.title="文章详情"
                postedOn="发表于:"
                viewsArt="视图:"
                by="通过 "
                Ok="好"
                Cancel="取消"
                removeFav="您确定要将此文章从收藏夹列表中删除吗？"
                corectAnswer="正确答案:"
               
                //lblCorrect.text="အဖြေမှန်:"
                if let font = UIFont(name: "Roboto-Regular", size: 14) {
                    navigationController?.navigationBar.titleTextAttributes = [
                        NSAttributedString.Key.foregroundColor: UIColor.white,
                        NSAttributedString.Key.font: font
                    ]
                }

                let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
                label.text = "အပိုဒ်အသေးစိတ်"
                label.textColor = UIColor.white
                label.textAlignment = .center
                view.addSubview(label)
                navigationItem.titleView = view
                label.font = UIFont(name: "Roboto-Regular", size: 14)
                
                
            }else if language1 as! String == "3"{
                postedOn="တွင် Posted:"
                viewsArt="အမြင်ချင်း"
                by="အားဖြင့် "
                Ok="အိုကေ"
                Cancel="ဖျက်သိမ်း"
                removeFav="သင်အကြိုက်ဆုံးစာရင်းထဲကနေဤဆောင်းပါးကိုဖယ်ရှားလို, သေချာပါသလား?"
                corectAnswer="အဖြေမှန်:"
                let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
                label.text = "အပိုဒ်အသေးစိတ်"
                label.textColor = UIColor.white
                label.textAlignment = .center
                view.addSubview(label)
                navigationItem.titleView = view
                label.font = UIFont(name: "Roboto-Regular", size: 14)
                
                
            }else{
                self.title="Lesson Details";
                postedOn = "Posted On:"
                viewsArt = "Views:"
                by = "By "
                Ok = "ok"
                Cancel = "cancel"
                removeFav = "Are you sure, you want to remove this Lesson from your Favorite List?"
                corectAnswer = "Correct Answer:"
                
                if let font = UIFont(name: "Roboto-Regular", size: 14) {
                    navigationController?.navigationBar.titleTextAttributes = [
                        NSAttributedString.Key.foregroundColor: UIColor.white,
                        NSAttributedString.Key.font: font
                    ]
                }
                
               
            }
        }else{
            self.title="Lesson Details";
            postedOn = "Posted On:"
            viewsArt = "Views:"
            by = "By "
            Ok = "ok"
            Cancel = "cancel"
            removeFav = "Are you sure, you want to remove this Lesson from your Favorite List?"
            corectAnswer = "Correct Answer:"
            
            if let font = UIFont(name: "Roboto-Regular", size: 14) {
                navigationController?.navigationBar.titleTextAttributes = [
                    NSAttributedString.Key.foregroundColor: UIColor.white,
                    NSAttributedString.Key.font: font
                ]
            }
        }
        


        let chatButton = UIBarButtonItem(image: UIImage(named: "chat"), style: .plain, target: self, action: #selector(goToChatView))

        btnBookMark = UIBarButtonItem(image: UIImage(named: "bookmark"), style: .plain, target: self, action: #selector(bookMoarkPopUp))
        
        navigationItem.rightBarButtonItems = [chatButton,btnBookMark!]
        //navigationItem.rightBarButtonItem = [btnBookMark]
        
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "BackArrow"), style: .plain, target: self, action: #selector(backBtnTapped(_:)))
        navigationItem.leftBarButtonItem = barButtonItem
       
        
    }
    @objc func backBtnTapped(_ sender: Any?) {
        player.pause()
        let duration = player.currentItem?.duration //total time
        var cTotalSeconds: Int? = nil
        if let duration = duration {
            cTotalSeconds = Int(CMTimeGetSeconds(duration))
        }


        let cHours = (cTotalSeconds ?? 0) / 3600
        let cMinutes = (cTotalSeconds ?? 0) % 3600 / 60
        let cSeconds = (cTotalSeconds ?? 0) % 3600 % 60

        let videoDurationText = String(format: "%02i:%02i:%02i", cHours, cMinutes, cSeconds)
        print("time :\(videoDurationText)")
        if let duration = duration {
            print("seconds = \(CMTimeGetSeconds(duration))")
        }
        let currentTime : CMTime = player.currentTime()//playing time
        let temp = CMTimeGetSeconds(currentTime)
        
        
        guard !(temp.isInfinite || temp.isNaN) else {
            print("invalid number....")
            navigationController?.popViewController(animated: true)
            return
        }
        let dTotalSeconds = Int(temp)
        
//        guard !(dTotalSeconds.isNaN || dTotalSeconds.isInfinite) else {
//            return "illegal value" // or do some error handling
//        }

        let dHours = dTotalSeconds / 3600
        let dMinutes = dTotalSeconds % 3600 / 60
        let dSeconds = dTotalSeconds % 3600 % 60
        
        let cvideoDurationText = String(format: "%02i:%02i:%02i", dHours, dMinutes, dSeconds)
        print("time :\(cvideoDurationText)")

        let defaults = UserDefaults.standard
        defaults.setValue(cvideoDurationText, forKey: "VCT")
        print("seconds = \(CMTimeGetSeconds(currentTime))")
        
        startTime = startAndEndtimeDefaults!.value(forKey: "starttime") as! String
        
        if (startTime == ""){
            print("Already inserted")
            navigationController?.popViewController(animated: true)
        }else{
            startAndEndtimeDefaults!.set("", forKey: "identity")

            let currentDate = Date()
            let timeZone = NSTimeZone.default as NSTimeZone
            // or Timezone with specific name like
            // [NSTimeZone timeZoneWithName:@"Europe/Riga"] (see link below)
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = timeZone as TimeZone
            dateFormatter.dateFormat = "HH:mm:ss"
            
            endTime = dateFormatter.string(from: currentDate)
            let start = startAndEndtimeDefaults!.value(forKey: "starttime") as? String
            print("date  is \(endTime)")
            
            APIManager.sharedInstance()?.startAndEndTimeforArticle(start, andWithEndTime: endTime, withUserId: userId, andWithArticleId: articleId, andComplete: { [self] (success, result) in
                
                if !success {
                    navigationController?.popViewController(animated: true)
                    return
                }
                startAndEndtimeDefaults!.set("", forKey: "starttime")
                navigationController?.popViewController(animated: true)
                
            })
        }
        
        
        if articleVideoType == "mini_certification" {
            let defaults = UserDefaults.standard
            let VideostartTime = "00:00:00"
            let VideoendTime = defaults.value(forKey: "VCT") as? String
            APIManager.sharedInstance()?.updatingVideoDuration(withUserId: userId, andWithAssementId: strMinicertificationId, withArticleId: articleId, withStartTime: VideostartTime, andWithEndTime: VideoendTime, andComplete: { [self] (success, result) in
                
                if !success {
                    navigationController?.popViewController(animated: true)
                    return
                } else {
                    let defaults = UserDefaults.standard
                    defaults.setValue("", forKey: "VCT")
                    defaults.setValue("", forKey: "miniid")
                    defaults.setValue("", forKey: "artid")

                    print("Success")
                    navigationController?.popViewController(animated: true)
                }
                
            })
            
        }else{
            print("This is normal lesson")
            navigationController?.popViewController(animated: true)
        }
        
    }
    @objc func goToChatView(){
        
        player.pause()
        let duration = player.currentItem?.duration //total time
        var cTotalSeconds: Int? = nil
        if let duration = duration {
            cTotalSeconds = Int(CMTimeGetSeconds(duration))
        }


        let cHours = (cTotalSeconds ?? 0) / 3600
        let cMinutes = (cTotalSeconds ?? 0) % 3600 / 60
        let cSeconds = (cTotalSeconds ?? 0) % 3600 % 60

        let videoDurationText = String(format: "%02i:%02i:%02i", cHours, cMinutes, cSeconds)
        print("time :\(videoDurationText)")
        if let duration = duration {
            print("seconds = \(CMTimeGetSeconds(duration))")
        }
        let currentTime : CMTime = player.currentTime()//playing time
        let temp = CMTimeGetSeconds(currentTime)
        
        
       /* guard !(temp.isInfinite || temp.isNaN) else {
            print("invalid number....")
            navigationController?.popViewController(animated: true)
            return
        }
        let dTotalSeconds = Int(temp)
        
//        guard !(dTotalSeconds.isNaN || dTotalSeconds.isInfinite) else {
//            return "illegal value" // or do some error handling
//        }

        let dHours = dTotalSeconds / 3600
        let dMinutes = dTotalSeconds % 3600 / 60
        let dSeconds = dTotalSeconds % 3600 % 60
        
        let cvideoDurationText = String(format: "%02i:%02i:%02i", dHours, dMinutes, dSeconds)
        print("time :\(cvideoDurationText)")

        let defaults = UserDefaults.standard
        defaults.setValue(cvideoDurationText, forKey: "VCT") */


        print("seconds = \(CMTimeGetSeconds(currentTime))")
        
        if articleVideoType == "mini_certification" {
            let defaults = UserDefaults.standard
            let VideostartTime = "00:00:00"
            let VideoendTime = defaults.value(forKey: "VCT") as? String
            APIManager.sharedInstance()?.updatingVideoDuration(withUserId: userId, andWithAssementId: strMinicertificationId, withArticleId: articleId, withStartTime: VideostartTime, andWithEndTime: VideoendTime, andComplete: { (success, result) in
                
                if !success {
                    return
                } else {
                    let defaults = UserDefaults.standard
                    defaults.setValue("", forKey: "VCT")
                    defaults.setValue("", forKey: "miniid")
                    defaults.setValue("", forKey: "artid")

                    print("Success")
                }
                
            })
            
        }else{
            print("This is normal lesson")
        }

        startTime = startAndEndtimeDefaults!.value(forKey: "starttime") as! String
        
        if (startTime == ""){
            print("Already inserted")
        }else{
            startAndEndtimeDefaults!.set("", forKey: "identity")

            let currentDate = Date()
            let timeZone = NSTimeZone.default as NSTimeZone
            // or Timezone with specific name like
            // [NSTimeZone timeZoneWithName:@"Europe/Riga"] (see link below)
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = timeZone as TimeZone
            dateFormatter.dateFormat = "HH:mm:ss"
            
            endTime = dateFormatter.string(from: currentDate)
            let start = startAndEndtimeDefaults!.value(forKey: "starttime") as? String
            print("date  is \(endTime)")
            
            APIManager.sharedInstance()?.startAndEndTimeforArticle(start, andWithEndTime: endTime, withUserId: userId, andWithArticleId: articleId, andComplete: { [self] (success, result) in
                
                if !success {
                    return
                }
                startAndEndtimeDefaults!.set("", forKey: "starttime")
            })
        }
        
        let defaul = UserDefaults.standard
        let mainAuthore = "-\(authoreId)"
        defaul.setValue(mainAuthore, forKey: "mainAuthoreId")

        let loginUserId = defaul.value(forKey: "id") as? String
        if loginUserId == authoreId {
            let userList = storyboard!.instantiateViewController(withIdentifier: "UsersListViewController") as? UsersListViewController
            userList?.articleId = articleId
            if let userList = userList {
                navigationController?.pushViewController(userList, animated: true)
            }
        } else {
            let messageView = storyboard!.instantiateViewController(withIdentifier: "ChatingViewController") as? ChatingViewController

            messageView?.authorId = authoreId
            messageView?.articleId = articleId
            messageView?.authorName = authorName
            messageView?.authoreImage = authorImg


            if let messageView = messageView {
                navigationController?.pushViewController(messageView, animated: true)
            }
        }
        
    }
    
    @objc func bookMoarkPopUp(){
        
        player.pause()
        let popin = storyboard!.instantiateViewController(withIdentifier: "BookMarkPopUpViewController") as? BookMarkPopUpViewController
        
//        popin?.popinTransitionStyle = BKTPopinTransitionStyle.slide
        
        popin?.setPopinTransitionStyle(BKTPopinTransitionStyle.slide)
        
        if dismissable {
//            popin?.popinOptions = BKTPopinDefault
//            popin?.setPopinOptions(BKTPopinOption)
            popin?.setPopinOptions(BKTPopinOption.dimmingViewStyleNone)
        } else {
//            popin?.popinOptions = BKTPopinDisableAutoDismiss
            popin?.setPopinOptions(BKTPopinOption.disableAutoDismiss)
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(bookMarkStatus),
            name: NSNotification.Name("SecondViewControllerDismissed"),
            object: nil)
        
        popin?.setPopinAlignment(BKTPopinAlignementOption(rawValue: self.selectedAlignementOption)!)
        popin?.strArticleId = articleId as NSString
        popin?.strArticleName = articleTitle as NSString
        
        let blurParameters = BKTBlurParameters()
        blurParameters.alpha = 1.0
        blurParameters.radius = 8.0
        blurParameters.saturationDeltaFactor = 1.8
        blurParameters.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        popin?.setBlurParameters(blurParameters)
        
//        popin?.setPopinOptions(BKTPopinOption(rawValue: (popin?.popinOptions())! | BKTPopinOption.dimmingViewStyleNone.rawValue))
        
//        popin?.setPopinOptions(BKTPopinOption.pop)
        popin?.setPopinOptions((popin?.popinOptions())!)
        
       /* if popin?.popinTransitionStyle() == BKTPopinTransitionStyle.custom {
            popin?.setPopinCustomInAnimation({ (popinController, initialFrame, finalFrame) in
                
                popinController?.view.frame = finalFrame
                popinController?.view.transform = CGAffineTransform(rotationAngle: M_PI_4 / 2)
            }
            
            popin?.setPopinCustomOutAnimation({ (popinController, initialFrame, finalFrame) in
                popinController.view.frame = finalFrame
                popinController.view.transform = CGAffineTransform(rotationAngle: M_PI_2)
                    
            })
            )
        } */
        
        
        
        if popin?.popinTransitionStyle() == BKTPopinTransitionStyle.custom{
            
            popin?.setPopinCustomInAnimation({ (popinController, initialFrame, finalFrame) in
                popinController?.view.frame = finalFrame
                popinController?.view.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_4) / 2)
            })
            
            popin?.setPopinCustomOutAnimation({ (popinController, initialFrame, finalFrame) in
                popinController?.view.frame = finalFrame
                popinController?.view.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
            })
        }
        
        popin?.setPreferedPopinContentSize(CGSize(width: 340.0, height: 350.0))
        
        popin?.setPopinTransitionDirection(BKTPopinTransitionDirection.top)
        self.navigationController?.presentPopinController(popin, animated: true, completion: {
            print("Popin presented !")
        })
        
//        if popin.popinTransitionStyle == BKTPopinTransitionStyleCustom {
//            popin.popinCustomInAnimation = { popinController, initialFrame, finalFrame in
//
//                popinController?.view.frame = finalFrame
//                popinController?.view.transform = CGAffineTransform(rotationAngle: M_PI_4 / 2)
//
//            }
//
//            popin.popinCustomOutAnimation = { popinController, initialFrame, finalFrame in
//
//                popinController?.view.frame = finalFrame
//                popinController?.view.transform = CGAffineTransform(rotationAngle: M_PI_2)
//
//            }
//        }
        
        
        
        
    }
    @objc func bookMarkStatus(){
        
        self.loadingView?.startAnimation()
        self.loadingView?.isHidden = false
        self.img?.isHidden = false
        
        APIManager.sharedInstance()?.getArticleDetails(withArticleId: articleId, withUserid: userId, andWithAssessmentId: strMinicertificationId, andComplete: { [self] (success, result) in
            
            loadingView?.stopAnimation()
            backGroundView!.isHidden = true
            loadingView!.isHidden = true
            
            if !success {
                if result != nil {
                    let resultDict = result as! NSDictionary
                    let strMessage = "\(resultDict.value(forKey: "message")!)"
                    let alert = SCLAlertView(newWindow: ())
                    alert?.horizontalButtons = true
                    alert?.showSuccess(AppName, subTitle: strMessage, closeButtonTitle: "OK", duration: 0.0)
                    
//                    Utility.showAlert(AppName, withMessage: (result as! String))
                }else{
                    Utility.showAlert(AppName, withMessage: "something went wrong")
                }
                
                return
            }else{
                let resultDict = result as! NSDictionary
                dataDict = resultDict.value(forKey: "data") as? NSDictionary
                let articleDataArr = dataDict!.object(forKey: "article_data") as! NSArray
                let aDict = articleDataArr[0] as! NSDictionary
                let bookMarkStatus = "\(aDict.value(forKey: "bookmarked")!)"
                strBookMark = bookMarkStatus
                
                //btnBookMark?.image = UIImage.init(named: "bookmark")
                if strBookMark == "0"{
                    btnBookMark?.isEnabled = true
                }else{
                    btnBookMark?.isEnabled = false
                }
                
            }
            
            
            
        })
        
        
        
        
        
    }
   
}
extension ArticleDetailsVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            //Author
            return 180
        }else if indexPath.row == 1{
            //Image or Video
            return strMinicertificationId != "" ? UITableView.automaticDimension : 250
        }else if indexPath.row == 2{
            //Description
            return strMinicertificationId != "" ? 50 : UITableView.automaticDimension
        }else if indexPath.row == 3{
            //Quiz Title
            if removeQuizTitle ?? true{
                return 0
            }else{
                return 40
            }
        }else if indexPath.row == (numberOfQuizRows + 4){
            //Share
            return 50
        }else if indexPath.row == (numberOfQuizRows + 5){
            //Recommended View
            return 175
        }
        else {
            //Quiz QA
            return 280
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if strMinicertificationId != ""{
            return 3
        }else{
            return numberOfTotalRows
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if strMinicertificationId != "" {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "RatingCellID", for: indexPath) as! RatingCell
                cell.selectionStyle = .none
    //            cell.backgroundColor = UIColor.clear
                cell.delegate = self
                cell.articleId = articleId
                cell.userId = userId
                
                cell.index = indexPath.row
                cell.section = indexPath.section
                
                
    //            cell.authorImage.isHidden = true
                cell.authorImage.layer.masksToBounds = true
                cell.authorImage.layer.cornerRadius = 4.0
                let theURL = BASE_URL + authorImg
                cell.authorImage.sd_setImage(with: URL.init(string: theURL), placeholderImage: UIImage.init(named: "userprofile")) { (img, err, cacheType, imgURL) in
                    print("Image Downloaded by SD_WEB")
                }
                
                cell.lblArticleTitle.text = articleTitle.uppercased()
                cell.lblAuthorName.text = Language.by() + authorName
                cell.lblPostedDate.text = Language.postedOn() + createdDate
                cell.lblViewsCount.text = Language.views() + viewCount
                
                /* if strFavStatus == "no"{
                    cell.btnFavourite.setImage(UIImage.init(named: "unfavourite"), for: .normal)
                }else{
                    cell.btnFavourite.setImage(UIImage.init(named: "favorite"), for: .normal)
                } */
                cell.btnFavourite.isHidden = true
                
                if ratingCount == "0" {
                    cell.lblRatingCount.text = ""
                    cell.btnViewComments.isHidden = true
                }else{
                    cell.lblRatingCount.text = ratingCount
                    cell.btnViewComments.isHidden = false
                }
                
                
                if avgrate == "0"{
                    cell.btnViewComments.isEnabled = false
                }else{
                    cell.btnViewComments.isEnabled = true
                }
                
                cell.myFloatRatingView.delegate = self
                cell.myFloatRatingView.type = .wholeRatings
                cell.myFloatRatingView.editable = false
                cell.myFloatRatingView.rating = Double(avgrate) ?? 0
                
                return cell
            }
            else if indexPath.row == 1 {
                
                    let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCellID", for: indexPath) as! DescriptionCell
                    cell.selectionStyle = .none
                    cell.backgroundColor = UIColor.clear
                    cell.delegate = self
                    cell.descriptionTitleLbl.text = "Reason" //Language.description()
                
                
                let html_description = articleLongDescription // self.Dict["description"] as? String
                cell.descriptionLbl.text = html_description?.stripOutHtml()
                
                
                return cell
            }
            else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SharingCellID", for: indexPath) as! SharingCell
                cell.selectionStyle = .none
                cell.backgroundColor = UIColor.clear
                cell.delegate = self
                return cell
            }
            
            return UITableViewCell()
        }else{
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "RatingCellID", for: indexPath) as! RatingCell
                cell.selectionStyle = .none
    //            cell.backgroundColor = UIColor.clear
                cell.delegate = self
                cell.articleId = articleId
                cell.userId = userId
                
                cell.index = indexPath.row
                cell.section = indexPath.section
                
                
    //            cell.authorImage.isHidden = true
                cell.authorImage.layer.masksToBounds = true
                cell.authorImage.layer.cornerRadius = 4.0
                let theURL = BASE_URL + authorImg
                cell.authorImage.sd_setImage(with: URL.init(string: theURL), placeholderImage: UIImage.init(named: "userprofile")) { (img, err, cacheType, imgURL) in
                    print("Image Downloaded by SD_WEB")
                }
                
                cell.lblArticleTitle.text = articleTitle.uppercased()
                cell.lblAuthorName.text = Language.by() + authorName
                cell.lblPostedDate.text = Language.postedOn() + createdDate
                cell.lblViewsCount.text = Language.views() + viewCount
                
                if strFavStatus == "no"{
                    cell.btnFavourite.setImage(UIImage.init(named: "unfavourite"), for: .normal)
                }else{
                    cell.btnFavourite.setImage(UIImage.init(named: "favorite"), for: .normal)
                }
                
                if ratingCount == "0" {
                    cell.lblRatingCount.text = ""
                    cell.btnViewComments.isHidden = true
                }else{
                    cell.lblRatingCount.text = ratingCount
                    cell.btnViewComments.isHidden = false
                }
                
                
                if avgrate == "0"{
                    cell.btnViewComments.isEnabled = false
                }else{
                    cell.btnViewComments.isEnabled = true
                }
                
                cell.myFloatRatingView.delegate = self
                cell.myFloatRatingView.type = .wholeRatings
                cell.myFloatRatingView.editable = false
                cell.myFloatRatingView.rating = Double(avgrate) ?? 0
                
                return cell
            }
            else if indexPath.row == 1 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCellID", for: indexPath) as! DocumentCell
                cell.selectionStyle = .none
                cell.backgroundColor = UIColor.clear
                cell.delegate = self
                
                cell.myLoader.isHidden = false
                cell.myLoader.startAnimating()
                
                if articleType == "2"{
                    cell.imgCV.isHidden = false
                    
                    cell.articlesImgArr.removeAll()
                    if articleImage1 != "<null>" {
                        cell.articlesImgArr.append((BASE_URL + articleImage1!))
                    }
                    
                    if articleImage2 != "<null>" {
                        cell.articlesImgArr.append((BASE_URL + articleImage2!))
                    }
                    
                    if articleImage3 != "<null>" {
                        cell.articlesImgArr.append((BASE_URL + articleImage3!))
                    }
                    
                    cell.captionArr.removeAll()
                    if articleImgTitle1 != "<null>"{
                        cell.captionArr.append(articleImgTitle1!)
                    }
                    if articleImgTitle2 != "<null>"{
                        cell.captionArr.append(articleImgTitle2!)
                    }
                    if articleImgTitle3 != "<null>"{
                        cell.captionArr.append(articleImgTitle3!)
                    }
                }
                if articleType == "3"{
                    /*
                     cell.loadView.isHidden = false
                     
                     let videoUrlStr = articleYoutubeLinks
                     
                     let player = AVPlayer(url: URL(string: videoUrlStr ?? "")!)
                     let avPlayerViewController = AVPlayerViewController()
                     avPlayerViewController.player = player
                     
                     avPlayerViewController.view.frame = cell.loadView.frame
                     cell.loadView.addSubview(avPlayerViewController.view)
                     self.addChild(avPlayerViewController)
                     
                     player.play() */
                }else if articleType == "4"{
                    //you tube video
                    
                    //                cell.multiImgCV.isHidden = true
                    cell.imgCV.isHidden = true
                    cell.loadView.isHidden = false
                    
                    let videoUrl: URL! = URL(string: articleYoutubeLinks ?? "")
                    //            let videoUrl: URL! = URL(string: self.Dict["url_link"] as! String)
                    print(videoUrl!)
                    
                    //                    let videoPlayer = YouTubePlayerView(frame: CGRect( x: 0, y: 0, width: cell.loadView.frame.size.width, height: cell.loadView.frame.size.height))
                    
                    //let videoPlayer = YouTubePlayerView(frame: CGRect( x: 0, y: 0, width: cell.viewFullScreenBtn.frame.size.width, height: cell.loadView.frame.size.height))
                    
                    
                    let player = YouTubePlayerView()
                    player.frame = CGRect(x: 0, y: 0, width: cell.loadView.bounds.width, height: cell.loadView.frame.height)
                    
                    
                    player.loadVideoURL(videoUrl!)
                    cell.loadView.addSubview(player)
                    
                }
                cell.myLoader.isHidden = true
                cell.myLoader.stopAnimating()
                return cell
            }
            else if indexPath.row == 2 {
                
                    let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCellID", for: indexPath) as! DescriptionCell
                    cell.selectionStyle = .none
                    cell.backgroundColor = UIColor.clear
                    cell.delegate = self
                    cell.descriptionTitleLbl.text = Language.description()
                
                
                let html_description = articleLongDescription // self.Dict["description"] as? String
                cell.descriptionLbl.text = html_description?.stripOutHtml()
                
                
                return cell
            }
            else if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "QuizTitleCellID", for: indexPath) as! QuizTitleCell
                cell.selectionStyle = .none
                cell.backgroundColor = UIColor.clear
                cell.delegate = self
                return cell
            }
            else if indexPath.row == (numberOfQuizRows + 4) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SharingCellID", for: indexPath) as! SharingCell
                cell.selectionStyle = .none
                cell.backgroundColor = UIColor.clear
                cell.delegate = self
                return cell
            }
            else if indexPath.row == (numberOfQuizRows + 5) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendedCellID", for: indexPath) as! RecommendedCell
                cell.selectionStyle = .none
                cell.backgroundColor = UIColor.clear
                cell.delegate = self
                cell.recommendedArticleArr = self.recommendedArticleArr
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "QACellID", for: indexPath) as! QACell
                cell.selectionStyle = .none
                cell.backgroundColor = UIColor.clear
                cell.delegate = self
                
                let aQAStruct = self.arrOfQAStruct[indexPath.row]
                cell.questionLbl.text = aQAStruct.Question
                cell.option1Lbl.text = aQAStruct.answer1
                cell.option2Lbl.text = aQAStruct.answer2
                cell.option3Lbl.text = aQAStruct.answer3
                cell.option4Lbl.text = aQAStruct.answer4
                
                
                cell.option1Btn.tag = indexPath.row
                cell.option1Btn.accessibilityHint = "1"
                if aQAStruct.isOption1Tapped {
                    cell.option1Btn.setImage(selectionImg, for: .normal)
                }else{
                    cell.option1Btn.setImage(unSelectionImg, for: .normal)
                }
                cell.option1Btn.addTarget(self, action: #selector(option1Tapped(sender:)), for: .touchUpInside)
                
                
                if aQAStruct.isSubmitBtnTapped {
                    
                    cell.answerImgView.isHidden = false
                    if aQAStruct.actualAnwser == aQAStruct.selectedAnswer {
                        cell.answerImgView.image = self.correctImg
                        cell.correctAnswerLbl.isHidden = true
                    }else{
                        cell.answerImgView.image = self.wrongImg
                        cell.correctAnswerLbl.isHidden = false
                        cell.correctAnswerLbl.text = "Correct answer : \(aQAStruct.actualAnwser!)"
                    }
                    
                }else{
                    cell.answerImgView.isHidden = true //aQAStruct.isAnswerImgViewHidden
                    cell.correctAnswerLbl.isHidden = true
                }
                
                
                cell.option2Btn.tag = indexPath.row
                cell.option2Btn.accessibilityHint = "2"
                if aQAStruct.isOption2Tapped {
                    cell.option2Btn.setImage(selectionImg, for: .normal)
                }else{
                    cell.option2Btn.setImage(unSelectionImg, for: .normal)
                }
                cell.option2Btn.addTarget(self, action: #selector(option2Tapped(sender:)), for: .touchUpInside)
                
                
                
                cell.option3Btn.tag = indexPath.row
                cell.option3Btn.accessibilityHint = "3"
                if aQAStruct.isOption3Tapped {
                    cell.option3Btn.setImage(selectionImg, for: .normal)
                }else{
                    cell.option3Btn.setImage(unSelectionImg, for: .normal)
                }
                cell.option3Btn.addTarget(self, action: #selector(option3Tapped(sender:)), for: .touchUpInside)
                
                
                
                cell.option4Btn.tag = indexPath.row
                cell.option4Btn.accessibilityHint = "4"
                cell.option4Btn.addTarget(self, action: #selector(option4Tapped(sender:)), for: .touchUpInside)
                
                if aQAStruct.isOption4Tapped {
                    cell.option4Btn.setImage(selectionImg, for: .normal)
                }else{
                    cell.option4Btn.setImage(unSelectionImg, for: .normal)
                }
                
                
     
                cell.submitBtn.tag = indexPath.row
                cell.submitBtn.accessibilityHint = "5"
                cell.submitBtn.addTarget(self, action: #selector(submitBtnTapped(sender:)), for: .touchUpInside)
                
                return cell

            }
        }
        
        
            
        

        
        
    }
    
    @objc func option1Tapped(sender: UIButton){
        let buttonTag = sender.tag
        print("cell index is ",buttonTag)
        print("option1 tapped")
        
        if self.arrOfQAStruct[buttonTag].isOption1Tapped {
//            self.arrOfQAStruct[buttonTag].isOption1Tapped = false
        }else{
            self.arrOfQAStruct[buttonTag].isOption1Tapped = true
            self.arrOfQAStruct[buttonTag].isOption2Tapped = false
            self.arrOfQAStruct[buttonTag].isOption3Tapped = false
            self.arrOfQAStruct[buttonTag].isOption4Tapped = false
            
            self.arrOfQAStruct[buttonTag].selectedAnswer = self.arrOfQAStruct[buttonTag].answer1
        }
        updateTheCell(cellIndex: buttonTag, sender: sender)
        
    }
    
    @objc func option2Tapped(sender: UIButton){
        let buttonTag = sender.tag
        print("cell index is ",buttonTag)
        print("option1 tapped")
        
        if self.arrOfQAStruct[buttonTag].isOption2Tapped {
//            self.arrOfQAStruct[buttonTag].isOption2Tapped = false
        }else{
            self.arrOfQAStruct[buttonTag].isOption2Tapped = true
            self.arrOfQAStruct[buttonTag].isOption1Tapped = false
            self.arrOfQAStruct[buttonTag].isOption3Tapped = false
            self.arrOfQAStruct[buttonTag].isOption4Tapped = false
            
            self.arrOfQAStruct[buttonTag].selectedAnswer = self.arrOfQAStruct[buttonTag].answer2
        }
        updateTheCell(cellIndex: buttonTag, sender: sender)
        
    }
    
    @objc func option3Tapped(sender: UIButton){
        let buttonTag = sender.tag
        print("cell index is ",buttonTag)
        print("option1 tapped")
        
        if self.arrOfQAStruct[buttonTag].isOption3Tapped {
//            self.arrOfQAStruct[buttonTag].isOption3Tapped = false
        }else{
            self.arrOfQAStruct[buttonTag].isOption3Tapped = true
            self.arrOfQAStruct[buttonTag].isOption1Tapped = false
            self.arrOfQAStruct[buttonTag].isOption2Tapped = false
            self.arrOfQAStruct[buttonTag].isOption4Tapped = false
            
            self.arrOfQAStruct[buttonTag].selectedAnswer = self.arrOfQAStruct[buttonTag].answer3
        }
        updateTheCell(cellIndex: buttonTag, sender: sender)
        
    }
    
    @objc func option4Tapped(sender: UIButton){
        let buttonTag = sender.tag
        print("cell index is ",buttonTag)
        print("option1 tapped")
        
        if self.arrOfQAStruct[buttonTag].isOption4Tapped {
//            self.arrOfQAStruct[buttonTag].isOption4Tapped = false
        }else{
            self.arrOfQAStruct[buttonTag].isOption4Tapped = true
            self.arrOfQAStruct[buttonTag].isOption1Tapped = false
            self.arrOfQAStruct[buttonTag].isOption2Tapped = false
            self.arrOfQAStruct[buttonTag].isOption3Tapped = false
            
            self.arrOfQAStruct[buttonTag].selectedAnswer = self.arrOfQAStruct[buttonTag].answer4
        }
        updateTheCell(cellIndex: buttonTag, sender: sender)
        
    }
    
    
    @objc func submitBtnTapped(sender: UIButton){
        let cellIndex = sender.tag
        print("Cell index is ",cellIndex)
        
        if self.arrOfQAStruct[cellIndex].isSubmitBtnTapped {
//            self.arrOfQAStruct[buttonTag].isOption1Tapped = false
        }else{
            self.arrOfQAStruct[cellIndex].isSubmitBtnTapped = true
            
        }
        updateTheCell(cellIndex: cellIndex, sender: sender)
    }
    func updateTheCell(cellIndex : Int,sender : UIButton){
        
        let selectedIndexPath = IndexPath(row: cellIndex, section: 0)
        let cell = self.theContainerTV.cellForRow(at: selectedIndexPath as IndexPath) as! QACell
        
        switch sender.accessibilityHint {
            case "1":
                if self.arrOfQAStruct[cellIndex].isOption1Tapped {
                    cell.option1Btn.setImage(selectionImg, for: .normal)
                    cell.option2Btn.setImage(unSelectionImg, for: .normal)
                    cell.option3Btn.setImage(unSelectionImg, for: .normal)
                    cell.option4Btn.setImage(unSelectionImg, for: .normal)
                    
                }else{
//                    cell.option1Btn.setImage(unSelectionImg, for: .normal)
                }
                break
        case "2":
            if self.arrOfQAStruct[cellIndex].isOption2Tapped {
                cell.option2Btn.setImage(selectionImg, for: .normal)
                cell.option1Btn.setImage(unSelectionImg, for: .normal)
                cell.option3Btn.setImage(unSelectionImg, for: .normal)
                cell.option4Btn.setImage(unSelectionImg, for: .normal)
            }else{
//                cell.option2Btn.setImage(unSelectionImg, for: .normal)
            }
            break
        case "3":
            if self.arrOfQAStruct[cellIndex].isOption3Tapped {
                cell.option3Btn.setImage(selectionImg, for: .normal)
                cell.option1Btn.setImage(unSelectionImg, for: .normal)
                cell.option2Btn.setImage(unSelectionImg, for: .normal)
                cell.option4Btn.setImage(unSelectionImg, for: .normal)
                
            }else{
//                cell.option3Btn.setImage(unSelectionImg, for: .normal)
            }
            break
        case "4":
            if self.arrOfQAStruct[cellIndex].isOption4Tapped {
                cell.option4Btn.setImage(selectionImg, for: .normal)
                cell.option1Btn.setImage(unSelectionImg, for: .normal)
                cell.option2Btn.setImage(unSelectionImg, for: .normal)
                cell.option3Btn.setImage(unSelectionImg, for: .normal)
                
            }else{
//                cell.option4Btn.setImage(unSelectionImg, for: .normal)
            }
            break
            
        case "5" :
            if self.arrOfQAStruct[cellIndex].isSubmitBtnTapped {
                
                cell.answerImgView.isHidden = false
                if self.arrOfQAStruct[cellIndex].actualAnwser  == self.arrOfQAStruct[cellIndex].selectedAnswer {
                    cell.answerImgView.image = self.correctImg
                    cell.correctAnswerLbl.isHidden = true
                }else{
                    cell.answerImgView.image = self.wrongImg
                    cell.correctAnswerLbl.isHidden = false
                    cell.correctAnswerLbl.text = "Correct answer : \(self.arrOfQAStruct[cellIndex].actualAnwser!)"
                }
            }else{
                cell.answerImgView.isHidden = true
            }
            break
            
        default:
            break
        }
    }
    
    
}
extension ArticleDetailsVC : RatingCellDelegate {
    func makeFavoriteUnfavourite(articleId: String, UserId: String, row: Int, section: Int) {
        if strFavStatus == "no"{
            backGroundView!.isHidden = false
            loadingView!.startAnimation()
            loadingView!.isHidden = false
            img!.isHidden = false
            
            APIManager.sharedInstance()?.addArticleToMyFavoriteArticles(withUserId: UserId, andWithArticleId: articleId, andComplete: { [self] (success, result) in
            
                backGroundView!.isHidden = true
                loadingView!.stopAnimation()
                loadingView!.isHidden = true
                img!.isHidden = true
                
                if(!success){
                    let alert = SCLAlertView.init(newWindow: ())
                    alert?.horizontalButtons = true
                    alert?.showSuccess(AppName, subTitle: result as? String, closeButtonTitle: Language.ok(), duration: 0.0)
                    return
                }
                
                let selectedIndexPath = IndexPath(row: row, section: section)
                let cell = self.theContainerTV.cellForRow(at: selectedIndexPath) as! RatingCell
                cell.btnFavourite.setImage(UIImage.init(named: "favorite"), for: .normal)
                strFavStatus = "yes"
                
            
            })
        }else{
            let alert = SCLAlertView.init(newWindow: ())
            alert?.horizontalButtons = true
            alert?.addButton(Language.ok(), actionBlock: { [self] in
                backGroundView!.isHidden = false
                loadingView!.startAnimation()
                loadingView!.isHidden = false
                img!.isHidden = false
                
                APIManager.sharedInstance()?.removeArticleFromMyFavoriteArticles(withUserId: UserId, andWithArticleId: articleId, andComplete: { (success, result) in
                    
                    backGroundView!.isHidden = true
                    loadingView!.stopAnimation()
                    loadingView!.isHidden = true
                    img!.isHidden = true
                    
                    if(!success){
                        let alert = SCLAlertView.init(newWindow: ())
                        alert?.horizontalButtons = true
                        alert?.showSuccess(AppName, subTitle: result as? String, closeButtonTitle: Language.ok(), duration: 0.0)
                        return
                    }
                    let selectedIndexPath = IndexPath(row: row, section: section)
                    let cell = self.theContainerTV.cellForRow(at: selectedIndexPath) as! RatingCell
                    cell.btnFavourite.setImage(UIImage.init(named: "unfavourite"), for: .normal)
                    strFavStatus = "no"
                    
                })
            })
            alert?.showSuccess(AppName, subTitle: Language.removearticlefromFavouriteList(), closeButtonTitle: "Cancel", duration: 0.0)
        }

    }
    

    
    func openReadReviewVC(articleId: String) {
        player.pause()
        let duration = player.currentItem?.duration //total time
        var cTotalSeconds: Int? = nil
        if let duration = duration {
            cTotalSeconds = Int(CMTimeGetSeconds(duration))
        }


        let cHours = (cTotalSeconds ?? 0) / 3600
        let cMinutes = (cTotalSeconds ?? 0) % 3600 / 60
        let cSeconds = (cTotalSeconds ?? 0) % 3600 % 60

        let videoDurationText = String(format: "%02i:%02i:%02i", cHours, cMinutes, cSeconds)
        print("time :\(videoDurationText)")
        if let duration = duration {
            print("seconds = \(CMTimeGetSeconds(duration))")
        }
        let currentTime : CMTime = player.currentTime()//playing time
        let temp = CMTimeGetSeconds(currentTime)
        
        
        /* guard !(temp.isInfinite || temp.isNaN) else {
            print("invalid number....")
            navigationController?.popViewController(animated: true)
            return
        }
        let dTotalSeconds = Int(temp)
        
        let dHours = dTotalSeconds / 3600
        let dMinutes = dTotalSeconds % 3600 / 60
        let dSeconds = dTotalSeconds % 3600 % 60
        
        let cvideoDurationText = String(format: "%02i:%02i:%02i", dHours, dMinutes, dSeconds)
        print("time :\(cvideoDurationText)")

        let defaults = UserDefaults.standard
        defaults.setValue(cvideoDurationText, forKey: "VCT")
        print("seconds = \(CMTimeGetSeconds(currentTime))") */
        
        
        if articleVideoType == "mini_certification" {
            let defaults = UserDefaults.standard
            let VideostartTime = "00:00:00"
            let VideoendTime = defaults.value(forKey: "VCT") as? String
            APIManager.sharedInstance()?.updatingVideoDuration(withUserId: userId, andWithAssementId: strMinicertificationId, withArticleId: articleId, withStartTime: VideostartTime, andWithEndTime: VideoendTime, andComplete: { (success, result) in
                
                if (!success){
                    return
                }else{
                    
                    print("Success")
                    let defaults = UserDefaults.standard
                    defaults.setValue("", forKey: "VCT")
                    defaults.setValue("", forKey: "miniid")
                    defaults.setValue("", forKey: "artid")
                    
                }
                
            })
        }else{
            print("This is normal lesson")
        }
        
        
        startAndEndtimeDefaults!.set("", forKey: "identity")

        let currentDate = Date()
        let timeZone = NSTimeZone.default as NSTimeZone
        // or Timezone with specific name like
        // [NSTimeZone timeZoneWithName:@"Europe/Riga"] (see link below)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone as TimeZone
        dateFormatter.dateFormat = "HH:mm:ss"


        endTime = dateFormatter.string(from: currentDate)
        let start = startAndEndtimeDefaults!.value(forKey: "starttime") as? String
        print("date  is \(endTime)")
        
        
        APIManager.sharedInstance()?.startAndEndTimeforArticle(start, andWithEndTime: endTime, withUserId: userId, andWithArticleId: articleId, andComplete: { (success, result) in
            
            if(!success){
                return
            }
        })
        
        
        let allReviews = storyboard!.instantiateViewController(withIdentifier: "GetAllReviewViewController") as? GetAllReviewViewController
        allReviews?.articleId = articleId
        allReviews?.cameFrom = "RatingBtn"
        if let allReviews = allReviews {
            navigationController?.pushViewController(allReviews, animated: true)
        }
        
        
    }
    
    func openWriteReviewVC(articleId: String) {
        
        player.pause()
        let duration = player.currentItem?.duration //total time
        var cTotalSeconds: Int? = nil
        if let duration = duration {
            cTotalSeconds = Int(CMTimeGetSeconds(duration))
        }


        let cHours = (cTotalSeconds ?? 0) / 3600
        let cMinutes = (cTotalSeconds ?? 0) % 3600 / 60
        let cSeconds = (cTotalSeconds ?? 0) % 3600 % 60

        let videoDurationText = String(format: "%02i:%02i:%02i", cHours, cMinutes, cSeconds)
        print("time :\(videoDurationText)")
        if let duration = duration {
            print("seconds = \(CMTimeGetSeconds(duration))")
        }
        let currentTime : CMTime = player.currentTime()//playing time
        let temp = CMTimeGetSeconds(currentTime)
        
        
        /* guard !(temp.isInfinite || temp.isNaN) else {
            print("invalid number....")
            navigationController?.popViewController(animated: true)
            return
        }
        let dTotalSeconds = Int(temp)
        
        let dHours = dTotalSeconds / 3600
        let dMinutes = dTotalSeconds % 3600 / 60
        let dSeconds = dTotalSeconds % 3600 % 60
        
        let cvideoDurationText = String(format: "%02i:%02i:%02i", dHours, dMinutes, dSeconds)
        print("time :\(cvideoDurationText)")

        let defaults = UserDefaults.standard
        defaults.setValue(cvideoDurationText, forKey: "VCT")
        print("seconds = \(CMTimeGetSeconds(currentTime))") */
        
        
        if articleVideoType == "mini_certification" {
            let defaults = UserDefaults.standard
            let VideostartTime = "00:00:00"
            let VideoendTime = defaults.value(forKey: "VCT") as? String
            APIManager.sharedInstance()?.updatingVideoDuration(withUserId: userId, andWithAssementId: strMinicertificationId, withArticleId: articleId, withStartTime: VideostartTime, andWithEndTime: VideoendTime, andComplete: { (success, result) in
                
                if (!success){
                    return
                }else{
                    
                    print("Success")
                    let defaults = UserDefaults.standard
                    defaults.setValue("", forKey: "VCT")
                    defaults.setValue("", forKey: "miniid")
                    defaults.setValue("", forKey: "artid")
                    
                }
                
            })
        }else{
            print("This is normal lesson")
        }
        
        
        startAndEndtimeDefaults!.set("", forKey: "identity")

        let currentDate = Date()
        let timeZone = NSTimeZone.default as NSTimeZone
        // or Timezone with specific name like
        // [NSTimeZone timeZoneWithName:@"Europe/Riga"] (see link below)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone as TimeZone
        dateFormatter.dateFormat = "HH:mm:ss"


        endTime = dateFormatter.string(from: currentDate)
        let start = startAndEndtimeDefaults!.value(forKey: "starttime") as? String
        print("date  is \(endTime)")
        
        
        APIManager.sharedInstance()?.startAndEndTimeforArticle(start, andWithEndTime: endTime, withUserId: userId, andWithArticleId: articleId, andComplete: { (success, result) in
            
            if(!success){
                return
            }
        })
        
        let rateThis = storyboard!.instantiateViewController(withIdentifier: "NewReviewViewController") as? NewReviewViewController
        rateThis?.articleId = articleId
        if let rateThis = rateThis {
            navigationController?.pushViewController(rateThis, animated: true)
        }
    }
    
    func reloadAllCells(){
        
    }
    
}


extension ArticleDetailsVC : FloatRatingViewDelegate {
    
}
extension ArticleDetailsVC : DescriptionCellDelegate{
    
}
extension ArticleDetailsVC : SharingCellDelegate{
    func openSharing() {
        
        let startingMessage = "Resource Coach App"
        let secondMessage = "Hey! I came across a very good Lesson"
        let followMessage = "Please download the Resource Coach app from Google Play Store and App Store now!"
        //NSString * message = @"www.facebook.com";
        //NSString *mess=[AppName stringByAppendingString:@"-Total Learning App"];
        let titleName = "Title"
        let descr = "Description"
        let title = articleTitle
        let desc = articleShortDescription

        let totalString = "\(startingMessage)\n\n\(secondMessage)\n\n\(titleName) :\(title)\n\n\(descr) :\(desc)\n\n\(followMessage)"

        let shareItems = [totalString]

        let avc = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)

        present(avc, animated: true)

    }
    
    
}
extension ArticleDetailsVC : QuizTitleCellDelegate{
    
}
extension ArticleDetailsVC : QADelegate{
    
}
extension ArticleDetailsVC : RecommendedCellDelegate{
    func recommendedArticleTapped(catLock: String,articleID : String) {
        if catLock == "1" {
            let subscriptionDedaaBoxClass = storyboard!.instantiateViewController(withIdentifier: "SubScribeToDedaaBoxViewController") as? SubScribeToDedaaBoxViewController
            if let subscriptionDedaaBoxClass = subscriptionDedaaBoxClass {
                navigationController?.pushViewController(subscriptionDedaaBoxClass, animated: true)
            }
        }else{

            let details = storyboard!.instantiateViewController(withIdentifier: "ArticleDetailsVCSBID") as? ArticleDetailsVC
            
            if let details = details {
                
                let ud = UserDefaults.standard
//                let abcd = ud.value(forKey: "NeedToReloadArticleDetails")
//                ud.setValue(true, forKey: "NeedToReloadArticleDetails")
                ud.set(true, forKey: "NeedToReloadArticleDetails")
                
                details.articleId = articleID
                details.strMinicertificationId = ""
                navigationController?.pushViewController(details, animated: true)
            }
//            self.viewDidLoad()
//            self.reloadViewFromNib()
        }
    }
    
    /*func recommendedArticleTapped {
        if catLock == "1" {
            let subscriptionDedaaBoxClass = storyboard!.instantiateViewController(withIdentifier: "SubScribeToDedaaBoxViewController") as? SubScribeToDedaaBoxViewController
            if let subscriptionDedaaBoxClass = subscriptionDedaaBoxClass {
                navigationController?.pushViewController(subscriptionDedaaBoxClass, animated: true)
            }
        } else {
            
            /* let dict = dataArr![indexPath.row] as? [AnyHashable : Any]
            let articleid = dict?["id"] as? String
            
//                let details = storyboard!.instantiateViewController(withIdentifier: "ArticleDetailsViewController") as? ArticleDetailsViewController
            
            let details = storyboard!.instantiateViewController(withIdentifier: "ArticleDetailsVCSBID") as? ArticleDetailsVC
            
            details?.articleId = articleid!
            details?.strMinicertificationId = ""
            if let details = details {
                navigationController?.pushViewController(details, animated: true)
            }*/
        }
    } */
    
    
}
extension ArticleDetailsVC : DocumentCellDelegate{
    
}

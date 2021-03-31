//
//  ProfileVC.swift
//  Resource Coach
//
//  Created by Apple on 02/12/20.
//  Copyright © 2020 Biipmi. All rights reserved.
//

import UIKit

//import SDWebImage

//import ReFrosted

class ProfileVC: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var txtUserName: RPFloatingPlaceholderTextField!
    @IBOutlet weak var txtMobileNumber: RPFloatingPlaceholderTextField!
    @IBOutlet weak var txtEmail: RPFloatingPlaceholderTextField!
    
    @IBOutlet weak var mobileVerifiedImg: UIImageView!
    @IBOutlet weak var emailVerifiedImg: UIImageView!
    
    @IBOutlet weak var lblExpiryDate: UILabel!
    
    @IBOutlet weak var viewAllSubscriptionBtn: UIButton!
    
    
    
    
    
    var backGroundView: UIView? = nil
    var loadingView: HYCircleLoadingView?
    var img: UIImageView?
    
    var strUserId: String? = nil
    var uID: String? = nil
    var UserType:String? = nil
    
    var couponNameArr = [String]()
    
    @IBOutlet weak var lblMobileVerify: UILabel!
    @IBOutlet weak var lblEmailVerify: UILabel!
    
    
    
    @IBOutlet weak var certificatesView: UIView!
    @IBOutlet weak var lblCertificationName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblCertificateMobileNumber: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var imgCertificate: UIImageView!
    
    
    @IBOutlet weak var btnViewAllCertificates: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtUserName.placeholder = Language.fullName()
        txtMobileNumber.placeholder = Language.mobileNumber()
        txtEmail.placeholder = Language.email()
        certificatesView.isHidden = true
        btnEditProfile.isHidden = true
        viewAllSubscriptionBtn.isHidden = true
        btnEditProfile.isHidden = true
        
        certificatesView.layer.cornerRadius = 2
        certificatesView.layer.masksToBounds = true
        
        certificatesView.layer.shadowColor = UIColor.gray.cgColor
        certificatesView.layer.shadowOffset = CGSize.zero
        certificatesView.layer.masksToBounds = false
        certificatesView.layer.shadowRadius = 4.0
        certificatesView.layer.shadowOpacity = 1.0
        
        // Do any additional setup after loading the view.
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
        
        mobileVerifiedImg.isHidden = true
        emailVerifiedImg.isHidden = true
        
        lblExpiryDate.isHidden = true
        viewAllSubscriptionBtn.isHidden = true
        viewAllSubscriptionBtn.isHidden = true
        txtEmail.isEnabled = false
        txtUserName.isEnabled = false
        txtMobileNumber.isEnabled = false
       
        profileImg.layer.cornerRadius = profileImg.frame.size.height/2;
        profileImg.layer.masksToBounds = true
        profileImg.layer.borderWidth = 3.0
        profileImg.layer.borderColor = UIColor.white.cgColor
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let userDefaults = UserDefaults.standard
        strUserId =  userDefaults.object(forKey: "id") as? String
        getTheUserProfileDetails()

        let usercheckup = UserDefaults.standard
        uID = usercheckup.value(forKey: "id") as? String
        UserType = usercheckup.value(forKey: "usertype") as? String
    }
    

    func getTheUserProfileDetails(){
        
        backGroundView?.isHidden = false
        self.loadingView?.startAnimation()
        self.loadingView?.isHidden = false
        self.img?.isHidden = false
        
        APIManager.sharedInstance()?.getUserProfileDetails(withUserId: strUserId, andComplete: { [self] (success, result) in
            
            /*
             
            if (!success)
            {
                _certificatesView.hidden=YES;
                _btnViewAllCertificates.hidden=YES;
                [Utility showAlert:AppName withMessage:result];
                return ;
            } */
            
            self.backGroundView?.isHidden = true
            self.loadingView?.stopAnimation()
            self.loadingView?.isHidden = true
            self.img?.isHidden = true
            if(!success){
                print("Service Not Success....")
                certificatesView.isHidden = true
                btnViewAllCertificates.isHidden = true
                Utility.showAlert(AppName, withMessage: result as? String)
                return
            }else{
                print("Service Success....")
                
                let resultDict = result as! NSDictionary
                let dataDict = resultDict.value(forKey: "data") as! NSDictionary
                let status = "\(resultDict.value(forKey: "status")!)"
                let message = resultDict.value(forKey: "message") as! String
                print("Status = ",status)
                print("Message = ",message)
                
                
                let userDataDict = dataDict.value(forKey: "userdata") as! NSDictionary
                let userSubscriptionArr = userDataDict.value(forKey: "user_subscription") as! NSArray
                
                
                couponNameArr.removeAll()
                for aDict in userSubscriptionArr {
                    let tmpDict = aDict as! NSDictionary
                    let couponName = "\(tmpDict.value(forKey: "coupon_name")!)"
                    couponNameArr.append(couponName)
                }
                
                let certArr = dataDict.value(forKey: "certificate") as! NSArray
                let aCertDict = certArr[0] as! NSDictionary
                let certCount = "\(aCertDict.value(forKey: "certificate_count")!)"
                
                if certCount == "0" {
                    certificatesView.isHidden = true
                    btnViewAllCertificates.isHidden = true
                }else{
                    
                    let certID = "\(aCertDict.value(forKey: "id")!)"
                    let certAssessment = "\(aCertDict.value(forKey: "assessment")!)"
                    let certEmail = "\(aCertDict.value(forKey: "email")!)"
                    let certCreatedOn = "\(aCertDict.value(forKey: "created_on")!)"
                    let certMobile = "\(aCertDict.value(forKey: "mobile")!)"
                    let certTelCode = "\(aCertDict.value(forKey: "telcode")!)"
                    let certMobileWithTelCode = certTelCode + certMobile
                    let certScore = "\(aCertDict.value(forKey: "score")!)"
                    
                    let certCount = Int(certScore)
                    if certCount == 1{
                        certificatesView.isHidden = false
                        btnViewAllCertificates.isHidden = true
                    }else if certCount! > 1{
                        certificatesView.isHidden = false
                        btnViewAllCertificates.isHidden = false
                    }
                    lblCertificationName.text = certAssessment.uppercased()
                    
                    lblEmail.text = certEmail
                    lbldate.text = certCreatedOn
//                    lblCount.text =
                    if certMobile == "" {
                        lblCertificationName.text = Language.notAvailable()
                    }else{
                        lblCertificationName.text = certMobileWithTelCode
                    }
                    
                    lblScore.text = certScore + "%"
                }
                
                /*
                loginType=[userDict valueForKey:@"login_type"];
                userId=[userDict valueForKey:@"id"];
                userName=[userDict valueForKey:@"username"];
                userTelcode=[userDict valueForKey:@"telcode"];
                userMobileNo=[userDict valueForKey:@"phone"];
                userEmail=[userDict valueForKey:@"email"];
                userType=[userDict valueForKey:@"usertype"];
                userTypeId=[userDict valueForKey:@"usertype_id"];
                userMobVerifyStatus=[userDict valueForKey:@"mobile_verify"];
                userActive=[userDict valueForKey:@"active"];*/
                
                
                let loginType = "\(userDataDict.value(forKey: "login_type")!)"
                let userId = "\(userDataDict.value(forKey: "id")!)"
                let userName = "\(userDataDict.value(forKey: "username")!)"
                let userTelcode = "\(userDataDict.value(forKey: "telcode")!)"
                let userMobileNo  = "\(userDataDict.value(forKey: "phone")!)"
                let userEmail = "\(userDataDict.value(forKey: "email")!)"
                let userType = "\(userDataDict.value(forKey: "usertype")!)"
                let userTypeId = "\(userDataDict.value(forKey: "usertype_id")!)"
                let userMobVerifyStatus = "\(userDataDict.value(forKey: "mobile_verify")!)"
                let userActive = "\(userDataDict.value(forKey: "active")!)"
                

                var userProfilePic : String? = nil
                if loginType == "fb_login" {
                    userProfilePic = "\(userDataDict.value(forKey: "photo_user_fb")!)"
                }else{
                    userProfilePic = "\(userDataDict.value(forKey: "photo_user")!)"
                }
                
                let expiry = "\(userDataDict.value(forKey: "user_expiry")!)"
                if expiry == "<null>" {
                    lblExpiryDate.isHidden = true
                    
                }else{
                    lblExpiryDate.isHidden = false
                    lblExpiryDate.text = "Your subscription expires on \(expiry)"
                }
               
                if couponNameArr.count > 0 {
                    viewAllSubscriptionBtn.isHidden = false
                }else{
                    viewAllSubscriptionBtn.isHidden = true
                }
                
                let userEmailVerify = "\(userDataDict.value(forKey: "email_verify")!)"
                if loginType == "fb_login" {
                    btnEditProfile.isHidden = true
                    if userProfilePic == nil {
                        profileImg.image = UIImage.init(named: "userprofile")
                    }else{
                        //let sd = SDWebImageManager.init()
                        profileImg.sd_setImage(with: URL(string: userProfilePic! ), placeholderImage: UIImage(named: "userprofile"), options: .highPriority) { (img, err, cacheType, imageUrl) in
                                print("Image Downloaded by SD_WEB")
//                                self.myLoader.isHidden = true
//                                self.myLoader.stopAnimating()
                            
                        }
                        if (profileImg.image == nil) {
                            profileImg.image = UIImage.init(named: "userprofile")
                        }
                        
                    }
                }else{
                    btnEditProfile.isHidden = false
                    if userProfilePic == nil {
                        profileImg.image = UIImage.init(named: "userprofile")
                    }else{
                        let theURL = BASE_URL + "/" + userProfilePic!
                        profileImg.sd_setImage(with: URL(string: theURL ), placeholderImage: UIImage(named: "userprofile"), options: .highPriority) { (img, err, cacheType, imageUrl) in
                                print("Image Downloaded by SD_WEB")
//                                self.myLoader.isHidden = true
//                                self.myLoader.stopAnimating()
                            
                        }
                        if (profileImg.image == nil) {
                            profileImg.image = UIImage.init(named: "userprofile")
                        }
                    }
                }
                
                profileImg.layer.cornerRadius = profileImg.frame.size.height/2;
                profileImg.layer.masksToBounds = true
                profileImg.layer.borderWidth = 3.0
                profileImg.layer.borderColor = UIColor.white.cgColor //[UIColor whiteColor].CGColor;
                txtUserName.text = userName;
                
                if userMobileNo == "" {
                    txtMobileNumber.text = Language.notAvailable()
                }else {
                    txtMobileNumber.text = userTelcode + userMobileNo
                }
                
                if userMobVerifyStatus == "NO" {
                    mobileVerifiedImg.isHidden = true
                }else{
                    
                }
                
                if userEmail == "" {
                    txtEmail.text = Language.notAvailable()
                    lblEmailVerify.isHidden = true
                }else{
                    txtEmail.text = userEmail
                    lblEmailVerify.isHidden = false
                    if userEmailVerify == "NO" || userEmailVerify == "" {
                        lblEmailVerify.text = Language.notAvailable()
                    }else{
                        lblEmailVerify.text = "Verified"
                    }
                }
            }
        })
    }
    
    func configureNavigationBar() {
        self.title = Language.myProfile()
        
        if let font = UIFont(name: "Roboto-Regular", size: 14) {
            navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: font
            ]
        }
    }
    
    
    @IBAction func btnMenuTapped(_ sender: UIBarButtonItem) {
        
        view.endEditing(true)
        self.frostedViewController.view.endEditing(true)
        self.frostedViewController.presentMenuViewController()
        
    }
    
    
    @IBAction func editProfileBtnTapped(_ sender: UIButton) {
        let editProfileVCObj = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVCSBID") as! EditProfileVC
        self.navigationController?.pushViewController(editProfileVCObj, animated: true)
    }
    
    
//    @available(iOS 13.0, *)
    @IBAction func viewAllSubscriptionBtnTapped(_ sender: UIButton) {
        let popinVC = self.storyboard?.instantiateViewController(withIdentifier: "PromoCodesViewController") as! PromoCodesViewController
        popinVC.view.frame = CGRect(x: 0, y: 0, width: 300, height: 260)
        self.presentPopUp(popinVC)
    }
    
    //@available(iOS 13.0, *)
    @IBAction func btnViewAllCertificatesTapped(_ sender: UIButton) {
        let miniCertVCObj = self.storyboard?.instantiateViewController(withIdentifier: "MiniCertificatesListViewController") as! MiniCertificatesListViewController
        miniCertVCObj.usrId = strUserId
        self.navigationController?.pushViewController(miniCertVCObj, animated: true)
    }
}

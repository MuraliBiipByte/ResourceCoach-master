//
//  EditProfileVC.swift
//  Resource Coach
//
//  Created by Apple on 14/12/20.
//  Copyright © 2020 Biipmi. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {

    var backGroundView: UIView? = nil
    var loadingView: HYCircleLoadingView?
    var img: UIImageView?
    
    var chosenImage : UIImage? = nil
    
    @IBOutlet weak var txtUserName: RPFloatingPlaceholderTextField!
    @IBOutlet weak var txtMobileNumber: RPFloatingPlaceholderTextField!
    @IBOutlet weak var txtCountryCode: RPFloatingPlaceholderTextField!
    @IBOutlet weak var txtEmail: RPFloatingPlaceholderTextField!
    
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var btnProfile: UIButton!
    
    @IBOutlet weak var alertIconUserName : UIImageView!
    @IBOutlet weak var alertIconEmail: UIImageView!
    @IBOutlet weak var btnEmailVerify: UIButton!
    @IBOutlet weak var btnMobileVerify: UIButton!
    @IBOutlet weak var alertImgUserName: UIImageView!
    @IBOutlet weak var alertLabelUserName: UILabel!
    @IBOutlet weak var alertLabelEmail: UILabel!
    @IBOutlet weak var alertImgEmail: UIImageView!
    @IBOutlet weak var emailVerifiedImg: UIImageView!
    @IBOutlet weak var mobileVerifiedImg: UIImageView!
    
    @IBOutlet weak var btnSaveProfile: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var verifyNow : String? = nil
    var  Ok: String? = nil
    var  Cancel: String? = nil
    var  cancel: String? = nil
    var  gallery: String? = nil
    var  camera: String? = nil
    var  appSettingsAlert: String? = nil
    var  selectDepartment: String? = nil
    
    
    var strUserId : String? = nil
    var userName : String? = nil
    var userTelcode : String? = nil
    var  userMobileNo: String? = nil
    var  userEmail: String? = nil
    var  userType: String? = nil
    var  userTypeId: String? = nil
    var  userProfilePic: String? = nil
    var  userMobVerifyStatus: String? = nil
    var  userActive: String? = nil
    var  userEmailVerify: String? = nil
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtUserName.placeholder = Language.fullName()
        txtMobileNumber.placeholder = Language.mobileNumber()
        txtCountryCode.placeholder = Language.code()
        txtEmail.placeholder = Language.email()
        
        alertLabelUserName.text = Language.fullNamecannotbeempty()
        alertLabelEmail.text = Language.invalidEmail()
        
        
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
        
        
        alertIconUserName.isHidden = true
        alertImgUserName.isHidden = true
        alertLabelUserName.isHidden = true
        alertIconEmail.isHidden = true
        alertImgEmail.isHidden = true
        alertLabelEmail.isHidden = true
        
        txtCountryCode.isEnabled = false
        txtMobileNumber.isEnabled = false
        
        let defaults = UserDefaults.standard
        strUserId =  defaults.object(forKey: "id") as? String
        
        getTheUserProfileDetails()
        
        btnMobileVerify.isHidden = true
        btnEmailVerify.isHidden = true
        emailVerifiedImg.isHidden = true
        mobileVerifiedImg.isHidden = true
        
        configureNavigationBar()
        
        
        profileImg.layer.cornerRadius = profileImg.frame.size.height/2;
        profileImg.layer.masksToBounds = true
        profileImg.layer.borderWidth = 3.0
        profileImg.layer.borderColor = UIColor.white.cgColor
    }
    
    func configureNavigationBar() {
        /* self.title = Language.myProfile()
        
        if let font = UIFont(name: "Roboto-Regular", size: 14) {
            navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: font
            ]
        } */
        
        let defaults = UserDefaults.standard
        let language1 = defaults.value(forKey: "language")
        
        if language1 != nil {
            if language1 as! String  == "2" {
                let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
                label.text = Language.editProfile()
                label.textColor = UIColor.white
                label.textAlignment = .center
                view.addSubview(label)
                navigationItem.titleView = view
                label.font = UIFont(name: "Roboto-Regular", size: 14)
                
                verifyNow = Language.verifyNow()
                Ok = Language.ok()
//                Cancel = Language.cancel()
//                cancel = Language.cancel()
                gallery = Language.gallary()
//                camer = Language.camera()
                appSettingsAlert = Language.appSettings()
                selectDepartment = Language.selectDepartment()
                
                btnSaveProfile.setTitle(Language.save(), for: .normal)
                
                
                
            }else if language1 as! String == "3"{
                verifyNow="အခုတော့ Verify";
                Ok="အိုကေ";
                Cancel="ဖျက်သိမ်း";
                cancel="ပရိုဖိုင်းကို";
                gallery="ပြခန်း";
                camera="ကင်မရာ";
                appSettingsAlert="> Iphone က Settings> Privacy> ကင်မရာ DedaaBox: DedaaBox access ကိုမှသွား enable သင့်ရဲ့ Camera.To မှဝင်ရောက်ခွင့်ရှိသည်ပါဘူး";
                selectDepartment="ဦးစီးဌာနကို Select လုပ်ပါ";
                btnSaveProfile.setTitle("Profile ကို Save", for: .normal)
                
                let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
                label.text = "သင့်ရဲ့ကိုယ့်ရေးကိုယ်တာကိုပြုပြင်ရန်";
                label.textColor = UIColor.white
                label.textAlignment = .center
                view.addSubview(label)
                navigationItem.titleView = view
                label.font = UIFont(name: "Roboto-Regular", size: 14)
                
            }else{
                self.title="Edit Profile";
                verifyNow="Verify Now";
                Ok="ok";
                Cancel="cancel";
                cancel="cancel";
                gallery="Gallery";
                camera="Camera";
                appSettingsAlert="Resource Coach does not have access to your Camera.To enable access go to: Iphone Settings > Privacy > Camera > Resource Coach";
                selectDepartment="Select Department";
    //            [btnUpdateProfile setTitle:@"Save Profile" forState:UIControlStateNormal];
            }
        }else{
            self.title="Edit Profile";
            verifyNow="Verify Now";
            Ok="ok";
            Cancel="cancel";
            cancel="cancel";
            gallery="Gallery";
            camera="Camera";
            appSettingsAlert="Resource Coach does not have access to your Camera.To enable access go to: Iphone Settings > Privacy > Camera > Resource Coach";
            selectDepartment="Select Department";
        }
       
        if let font = UIFont(name: "Roboto-Regular", size: 14) {
            navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: font
            ]
        }
    }
   
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        defaults.setValue("ProfileEdit", forKey: "Controller")
    }
    
    func getTheUserProfileDetails(){
        backGroundView?.isHidden = false
        self.loadingView?.startAnimation()
        self.loadingView?.isHidden = false
        self.img?.isHidden = false
        
        APIManager.sharedInstance()?.getUserProfileDetails(withUserId: strUserId, andComplete: { [self] (success, result) in
            
            self.backGroundView?.isHidden = true
            self.loadingView?.stopAnimation()
            self.loadingView?.isHidden = true
            self.img?.isHidden = true
            if (!success){
                
                return
            }else{
                
                let resultDict = result as! NSDictionary
                let dataDict = resultDict.value(forKey: "data") as! NSDictionary
                
                let userDataDict = dataDict.value(forKey: "userdata") as! NSDictionary
                
                self.strUserId = "\(userDataDict.value(forKey: "id")!)"
                self.userName = "\(userDataDict.value(forKey: "username")!)"
                self.userTelcode = "\(userDataDict.value(forKey: "telcode")!)"
                self.userMobileNo = "\(userDataDict.value(forKey: "phone")!)"
                self.userEmail = "\(userDataDict.value(forKey: "email")!)"
                self.userType = "\(userDataDict.value(forKey: "usertype")!)"
                self.userTypeId = "\(userDataDict.value(forKey: "usertype_id")!)"
                self.userProfilePic = "\(userDataDict.value(forKey: "photo_user")!)"
                self.userMobVerifyStatus = "\(userDataDict.value(forKey: "mobile_verify")!)"
                self.userActive = "\(userDataDict.value(forKey: "active")!)"
                self.userEmailVerify = "\(userDataDict.value(forKey: "email_verify")!)"
               
                if self.userProfilePic == "" || self.userProfilePic == nil{
                    self.profileImg.image = UIImage.init(named: "userprofile")
                }else{
                    let theURL = BASE_URL + "/" + userProfilePic!
                    profileImg.sd_setImage(with: URL(string: theURL ), placeholderImage: UIImage(named: "userprofile"), options: .highPriority) { (img, err, cacheType, imageUrl) in
                            print("Image Downloaded by SD_WEB")
                            chosenImage = img
                    }
                    if (profileImg.image == nil) {
                        profileImg.image = UIImage.init(named: "userprofile")
                    }
                }
                
                
                profileImg.layer.cornerRadius = profileImg.frame.size.height/2;
                profileImg.layer.masksToBounds = true
                profileImg.layer.borderWidth = 3.0
                profileImg.layer.borderColor = UIColor.white.cgColor //[UIColor whiteColor].CGColor;
                self.txtUserName.text = userName;
                txtCountryCode.text = userTelcode
                txtMobileNumber.text = userMobileNo
                
                if self.userMobVerifyStatus == "NO"{
                    btnMobileVerify.isHidden = false
                    btnMobileVerify.setTitle(verifyNow, for: .normal)
                }else{
                    btnMobileVerify.isEnabled = false
                    mobileVerifiedImg.isHidden=true
                }
                
                if userEmail == "" || userEmail == nil {
                    btnEmailVerify.isHidden = true
                }else{
                    let emailDefaults = UserDefaults.standard
                    emailDefaults.setValue(userEmail, forKey: "email")
                    emailDefaults.setValue(userTypeId, forKey: "usertypeid")
                    txtEmail.text = userEmail
                    btnEmailVerify.isHidden = false
                    emailVerifiedImg.isHidden = true
                    if userEmailVerify == "NO"{
                        btnEmailVerify.setTitleColor(UIColor.white, for: .normal)
                        btnEmailVerify.setTitle(verifyNow, for: .normal)
                        btnEmailVerify.layer.cornerRadius = 8
                    }else{
                        btnEmailVerify.isHidden = true
                        emailVerifiedImg.isHidden = true
                    }
                }
            }
        })
    }
    
    @IBAction func btnProfileTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                    self.openCamera()
                }))

                alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                    self.openGallery()
                }))

                alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

                self.present(alert, animated: true, completion: nil)
    }

    @IBAction func btnEmailVerifiedTapped (_ sender: UIButton) {
    }
    @IBAction func btnMobileVerifiedTapped(_ sender: UIButton) {
    }
    
    @IBAction func btnNavigationBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    //@available(iOS 13.0, *)
    @IBAction func saveProfileTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        
        let alert = SCLAlertView(newWindow: ())
        alert?.horizontalButtons = true
        
        if txtUserName.text?.count == 0 {
            alert?.showSuccess(AppName, subTitle: Language.fullNamecannotbeempty(), closeButtonTitle: "Cancel", duration: 0.0)
            
            txtUserName.becomeFirstResponder()
            return
        }
        if txtEmail.text!.count > 0 {
            if !Utility.validateEmail(txtEmail.text) {
                alert?.showSuccess(AppName, subTitle: Language.invalidEmail(), closeButtonTitle: Language.ok(), duration: 0.0)
                txtEmail.becomeFirstResponder()
                return
            }
        }
        
        
        let user = User()
        user.userId = strUserId as NSString?
        user.userName = txtUserName.text;
        user.usertelCode = userTelcode;
        user.userPhoneNumber = userMobileNo;
        user.userEmail = txtEmail.text;
        
        self.backGroundView?.isHidden = false
        self.loadingView?.startAnimation()
        self.loadingView?.isHidden = false
        self.img?.isHidden = false
        
        APIManager.sharedInstance()?.updateUserProfile(user, andWithProfileImage: chosenImage, andComplete: { (success, result) in
            
            self.backGroundView?.isHidden = true
            self.loadingView?.stopAnimation()
            self.loadingView?.isHidden = true
            self.img?.isHidden = true
            
            if (!success){
                let alert = SCLAlertView(newWindow: ())
                alert?.horizontalButtons = true
                alert?.showSuccess(AppName, subTitle: result as? String, closeButtonTitle: Language.ok(), duration: 0.0)
                return
            }else{
                
                let resultDict = result as! NSDictionary
                let dataDict = resultDict.value(forKey: "data") as! NSDictionary
                
                let userDataDict = dataDict.value(forKey: "userdata") as! NSDictionary
                let errorMsg = "\(resultDict.value(forKey: "message")!)"
                
//                var verifyNow : String? = nil
                 var userId, userName1, userTelcode1, userMobileNo1, userEmail1, userType1, userTypeId1, userProfilePic1, userMobVerifyStatus1, userActive1, userDeptId : String //? = nil
                
                userId = "\(userDataDict.value(forKey: "id")!)"
                userName1 = "\(userDataDict.value(forKey: "username")!)"
                userTelcode1 = "\(userDataDict.value(forKey: "telcode")!)"
                userMobileNo1 = "\(userDataDict.value(forKey: "phone")!)"
                userEmail1 = "\(userDataDict.value(forKey: "email")!)"
                userType1 = "\(userDataDict.value(forKey: "usertype")!)"
                userTypeId1 = "\(userDataDict.value(forKey: "usertype_id")!)"
                userProfilePic1 = "\(userDataDict.value(forKey: "photo_user")!)"
                userMobVerifyStatus1 = "\(userDataDict.value(forKey: "mobile_verify")!)"
                userActive1 = "\(userDataDict.value(forKey: "active")!)"
                //userDeptId = "\(userDataDict.value(forKey: "department_id")!)"
                
                if userMobVerifyStatus1 == "YES" {
                    let alert = SCLAlertView(newWindow: ())
                    alert?.horizontalButtons = true
                    alert?.addButton(Language.ok(), actionBlock: {
                        let defaults = UserDefaults.standard
                        defaults.setValue(userId, forKey:"id")
                        defaults.setValue(userName1, forKey:"name")
                        defaults.setValue(userType1, forKey:"usertype")
                        defaults.setValue(userTypeId1, forKey:"usertypeid")
                        defaults.setValue(userTelcode1, forKey:"telcode")
                        defaults.setValue(userMobileNo1, forKey:"phone")
//                        defaults.setValue(userDeptId, forKey:"deptid")
                        
                        if userEmail1 == "" {
                            defaults.setValue("", forKey: "email")
                        }else{
                            defaults.setValue(userEmail1, forKey: "email")
                        }
                        
                        if userProfilePic1 == ""  {
                            defaults.setValue("", forKey: "profileimage")
                        }else{
                            defaults.setValue(userProfilePic1, forKey: "profileimage")
                        }
                        defaults.synchronize()
//                        let rootVC = self.storyboard?.instantiateViewController(identifier: "RootViewController") as! RootViewController
                        
                        let rootVC = self.storyboard?.instantiateViewController(withIdentifier: "RootViewController") as! RootViewController
                        self.present(rootVC, animated: true, completion: nil)
                        
                    })
                    
                    alert?.showSuccess(AppName, subTitle: errorMsg, closeButtonTitle: "Cancel", duration: 0.0)
                }else{
                    
                    let alert = SCLAlertView(newWindow: ())
                    alert?.horizontalButtons = true
                    alert?.showSuccess(AppName, subTitle: errorMsg, closeButtonTitle: Language.ok(), duration: 0.0)
                    return
                }
            }
            
            
            
            
        })
        
        
    }
}

extension EditProfileVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtUserName {
            if txtUserName.text?.count == 0 && alertIconUserName.isHidden == false {
                alertImgUserName.isHidden = false
                alertLabelUserName.isHidden = false
            }else{
                alertImgUserName.isHidden = true
                alertLabelUserName.isHidden = true
            }
        }
        if textField == txtEmail {
            if txtEmail.text?.count == 0 && alertIconEmail.isHidden == false {
                alertImgEmail.isHidden = false
                alertLabelEmail.isHidden = false
                alertImgUserName.isHidden = true
                alertLabelUserName.isHidden = true
            }else{
                alertImgEmail.isHidden = true
                alertLabelEmail.isHidden = true
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
//        let str = textField.text?.replacingCharacters(in: range, with: string)
        
        let str1 = textField.text as NSString?
          let str = str1?.replacingCharacters(in: range, with: string)
        
        if textField == txtUserName {
            if (str!.count > 0) {
                alertIconUserName.isHidden = true
                alertImgUserName.isHidden = true
                alertLabelEmail.isHidden = true
            }
            
        }
        if textField == txtEmail {
            if (str!.count > 0) {
                alertIconEmail.isHidden = true
                alertImgEmail.isHidden = true
                alertLabelEmail.isHidden = true
            }
        }
        
        return true
    }
}
extension EditProfileVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery()
   {
       if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
           let imagePicker = UIImagePickerController()
           imagePicker.delegate = self
           imagePicker.allowsEditing = true
           imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
           self.present(imagePicker, animated: true, completion: nil)
       }
       else
       {
           let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           self.present(alert, animated: true, completion: nil)
       }
   }
    
    //MARK:-- ImagePicker delegate
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            let correctedImage = pickedImage.upOrientationImage()
            
            //uploadImage(selectedImg: correctedImage!)
            profileImg.image = correctedImage
            chosenImage = correctedImage
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}

//
//  AssessmentVC.swift
//  Resource Coach
//
//  Created by Apple on 08/01/21.
//  Copyright © 2021 Biipmi. All rights reserved.
//

import UIKit

class AssessmentVC: UIViewController {

    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var theContainerTV: UITableView!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @objc var articleId : String? = nil
    @objc var strAuthoreId : String? = nil
    @objc var quizOrResult : String? = nil
    
    var backGroundView: UIView? = nil
    var loadingView: HYCircleLoadingView?
    var img: UIImageView?
    
    var userId = "",UserType = ""
    
    
    @IBOutlet weak var lblQuizFailMessage: UILabel!
    @IBOutlet weak var lblPercentage: UILabel!
    @IBOutlet weak var lblTotalMarks: UILabel!
    @IBOutlet weak var lblMarks: UILabel!
    
    var dataDict : NSDictionary? = nil
    var arrOfQuizStruct = [QuizDataStruct]()
    
    var selectionImg = UIImage()
    var unSelectionImg = UIImage()
    var correctImg = UIImage()
    var wrongImg = UIImage()
    
    var arrQuestionsAnswered = [String]()
    var arrQuestionId = [String]()
    var arrCorrectAnswer = [String]()
    var strPaasStatus : String? = nil
    
    var roundedPercentage : Double? = nil

    @IBAction func btnResultTapped(_ sender: UIButton) {
        resultView.isHidden = true
        //btnSubmit.isHidden = true
        btnSubmit.isEnabled = quizOrResult == "quiz" ? false : true
        
    }
    
    fileprivate func calculateResult() {
        resultView.isHidden = false
        
        var score : Int = 0
        for aStruct in arrOfQuizStruct {
            if (aStruct.answer == aStruct.selectedAnswer){
                score = score + 1
            }
        }
        print("score = ",score)
        
        lblTotalMarks.text = "\(arrOfQuizStruct.count)" // quizOrResult == "quiz" ? "\(arrQuestionsAnswered.count)" : arrOfQuizStruct.count
        lblMarks.text = "\(score)"
        if score == 0 {
            lblPercentage.text = "0 %"
            strPaasStatus = "fail"
            lblQuizFailMessage.isHidden = false
            lblQuizFailMessage.textColor = UIColor.red
        }else{
            //                roundedPercentage = round(Double((score/arrQuestionsAnswered.count) * 100))
            
            
            roundedPercentage = Double(((score*100)/arrOfQuizStruct.count)).rounded(toPlaces: 2) //round(Double(((score*100)/arrOfQuizStruct.count)))
            
            lblPercentage.text =  "\(roundedPercentage ?? 0)%"
            
            if (roundedPercentage! >= 80) {
                strPaasStatus = "pass"
                lblQuizFailMessage.isHidden = true
            }else{
                strPaasStatus = "fail"
                lblQuizFailMessage.isHidden = false
                lblQuizFailMessage.textColor = UIColor.red
            }
        }
    }
    
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        
        
        if quizOrResult == "quiz"{
            if arrQuestionsAnswered.count == arrOfQuizStruct.count {
                    quizOrResult = "result"
                    theContainerTV.reloadData()
                    
                    
                    arrQuestionId.removeAll()
                    arrCorrectAnswer.removeAll()
                    for aStruct in arrOfQuizStruct {
                        arrQuestionId.append(aStruct.id)
                        arrCorrectAnswer.append(aStruct.answer)
                    }
                    calculateResult()
                    APIManager.sharedInstance()?.saveQuiz(withUserId: userId, withassementId: self.articleId, withQuestionsId: arrQuestionId, withAnswers: arrCorrectAnswer, withResult: strPaasStatus, andwithScore: "\(roundedPercentage ?? 0)", andComplete: { [self] (success, result) in
                        
                        if(!success){
                            return
                        }
                        
                        let resultDict = result as! NSDictionary
                        let dataDict = resultDict.value(forKey: "data") as! NSDictionary
                        let arrMiniCert = dataDict.value(forKey: "mini_certification") as! NSArray
                        
                        let aMiniCertDict = arrMiniCert[0] as! NSDictionary
                        strPaasStatus = "\(aMiniCertDict.value(forKey: "result_status")!)"
                        let similarAssesmentId = "\(aMiniCertDict.value(forKey: "similar_assesment_id")!)"
                        let similarCount = Int("\(aMiniCertDict.value(forKey: "similar_assesment_count")!)")
                        if strPaasStatus == "fail" && similarCount! >= 1 {
                            let alert = UIAlertController(
                                title: AppName,
                                message: "This Authore has similar type of assessments Would you like to take the quizzes now?",
                                preferredStyle: .alert)
                            
                            
                            
                            let ok = UIAlertAction(
                                title: "OK",
                                style: .default,
                                handler: { [self] action in


                                    if similarCount! == 1 {
                                        let courseDetails = self.storyboard?.instantiateViewController(withIdentifier: "CourseDetailsViewController") as? CourseDetailViewController
                                        courseDetails?.miniCertificateId = similarAssesmentId as NSString
                                        if let courseDetails = courseDetails {
                                            navigationController?.pushViewController(courseDetails, animated: true)
                                        }
                                    } else if similarCount! > 1 {
                                        let miniCer = self.storyboard?.instantiateViewController(withIdentifier: "MiniCertificateViewController") as? MiniCertificateViewController

                                        if let miniCer = miniCer {
                                            navigationController?.pushViewController(miniCer, animated: true)
                                        }
                                    }

                                })
        //                    let Remind = UIAlertAction(title: "REMAINED ME LATER", style: .default
                                                       
                            let Remind = UIAlertAction(title: "REMAINED ME LATER", style: .default) { (
                            action) in
                                
                                Utility.showLoading(self)
                                APIManager.sharedInstance()?.remainedMeLater(withUserId: userId, andWithAssessmentId: self.articleId, andWithAuthorId: strAuthoreId, andComplete: { (success, result) in
                                    
                                    Utility.hideLoading(self)
                                    if(!success){
                                        return
                                    }else{
                                        
                                    }
                                })
                            }
                            
                            let skip = UIAlertAction(
                                title: "SKIP",
                                style: .default,
                                handler: { action in
                                    /// What we write here???????? *
                                    print("you pressed No, thanks button")
                                    // call method whatever u need
                                })
                            
                            alert.addAction(ok)
                            alert.addAction(Remind)
                            alert.addAction(skip)
                            
                            
                        }else if strPaasStatus == "fail" && similarCount == 0{
                            let alert = UIAlertController(
                                title: AppName,
                                message: "Would you like us to remind you for Newly added Mini-Certification",
                                preferredStyle: .alert)
                            
                            
                            
                            
                            let ok = UIAlertAction(
                                title: "OK",
                                style: .default,
                                handler: { [self] action in


                                    if similarCount! == 1 {
                                        let courseDetails = self.storyboard?.instantiateViewController(withIdentifier: "CourseDetailsViewController") as? CourseDetailViewController
                                        courseDetails?.miniCertificateId = similarAssesmentId as NSString
                                        if let courseDetails = courseDetails {
                                            navigationController?.pushViewController(courseDetails, animated: true)
                                        }
                                    } else if similarCount! > 1 {
                                        let miniCer = self.storyboard?.instantiateViewController(withIdentifier: "MiniCertificateViewController") as? MiniCertificateViewController

                                        if let miniCer = miniCer {
                                            navigationController?.pushViewController(miniCer, animated: true)
                                        }
                                    }

                                })
                            
                            
                            let Remind = UIAlertAction(title: "REMAINED ME LATER", style: .default) { (
                            action) in
                                
                                Utility.showLoading(self)
                                APIManager.sharedInstance()?.remainedMeLater(withUserId: userId, andWithAssessmentId: self.articleId, andWithAuthorId: strAuthoreId, andComplete: { (success, result) in
                                    
                                    Utility.hideLoading(self)
                                    if(!success){
                                        return
                                    }else{
                                        
                                    }
                                })
                            }
                            
                            let skip = UIAlertAction(
                                title: "SKIP",
                                style: .default,
                                handler: { action in
                                    /// What we write here???????? *
                                    print("you pressed No, thanks button")
                                    // call method whatever u need
                                })
                            
                            alert.addAction(Remind)
                            alert.addAction(skip)
                            
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                        
                    })
                
                
                    
                
                
                
                
                
                
                
                
            }else{
                resultView.isHidden = true
                let alert = SCLAlertView.init(newWindow: ())
                alert?.horizontalButtons = true
                alert?.showSuccess(AppName, subTitle: "Please Attempt all the Questions", closeButtonTitle: "OK", duration: 0.0)
                
                
            }

        }else{
            calculateResult()
        }
            
            
                   }
        
        
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = UserDefaults.standard
        userId = (defaults.value(forKey: "id") as? String)!
        UserType = defaults.value(forKey: "usertype") as! String
        
        selectionImg = UIImage(named: "radioCheck")!
        unSelectionImg = UIImage(named: "radioUncheck")!
        
        correctImg = UIImage(named: "checkMark")!
        wrongImg = UIImage(named: "redRadiobutton")!
        
        configureNavigationBar()
        resultView.isHidden = true
        
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
        
        resultView.layer.cornerRadius = 4.0
        lblQuizFailMessage.isHidden = true
        
        if quizOrResult == "quiz" {
            btnSubmit.setTitle("Submit", for: .normal)
            getAllAssessment()
        }else{
            btnSubmit.setTitle("View Result", for: .normal)
            callAnswerService()
        }
        
        
        theContainerTV.register(UINib(nibName: "QuestionCell", bundle: nil), forCellReuseIdentifier: "QuestionCellID" )
        theContainerTV.separatorStyle = .none
        theContainerTV.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        checkUserType()
    }
    func checkUserType(){
        APIManager.sharedInstance()?.checkingUserType(userId, andComplete: { [self] (success, result) in
            
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
    
    
    func configureNavigationBar() {
        let defaults = UserDefaults.standard
        let language1 = defaults.value(forKey: "language")
        
        if language1 != nil {
            if language1 as! String  == "2" {
//                self.title="文章详情"
                
               
                //lblCorrect.text="အဖြေမှန်:"
                if let font = UIFont(name: "Roboto-Regular", size: 14) {
                    navigationController?.navigationBar.titleTextAttributes = [
                        NSAttributedString.Key.foregroundColor: UIColor.white,
                        NSAttributedString.Key.font: font
                    ]
                }

                let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
                label.text = "အကဲဖြတ်"
                label.textColor = UIColor.white
                label.textAlignment = .center
                view.addSubview(label)
                navigationItem.titleView = view
                label.font = UIFont(name: "Roboto-Regular", size: 14)
                
                
            }else if language1 as! String == "3"{
                
                let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
                label.text = "အကဲဖြတ်"
                label.textColor = UIColor.white
                label.textAlignment = .center
                view.addSubview(label)
                navigationItem.titleView = view
                label.font = UIFont(name: "Roboto-Regular", size: 14)
                
                
            }else{
                
                self.title="Assessments"
                if let font = UIFont(name: "Roboto-Regular", size: 14) {
                    navigationController?.navigationBar.titleTextAttributes = [
                        NSAttributedString.Key.foregroundColor: UIColor.white,
                        NSAttributedString.Key.font: font
                    ]
                }
                
               
            }
        }else{
            self.title="Assessments";
            
            if let font = UIFont(name: "Roboto-Regular", size: 14) {
                navigationController?.navigationBar.titleTextAttributes = [
                    NSAttributedString.Key.foregroundColor: UIColor.white,
                    NSAttributedString.Key.font: font
                ]
            }
        }
        


       
        
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "BackArrow"), style: .plain, target: self, action: #selector(backBtnTapped(_:)))
        navigationItem.leftBarButtonItem = barButtonItem
       
        
    }

    @objc func backBtnTapped(_ sender: Any?) {
        navigationController?.popViewController(animated: true)
    }
    func callAnswerService(){
        backGroundView!.isHidden = false
        loadingView!.startAnimation()
        loadingView!.isHidden = false
        img!.isHidden = false
        
        APIManager.sharedInstance()?.viewAnswerwithUserId(self.userId, andWithMinCerID: self.articleId!, andComplete: { [self] (success, result) in
            
            loadingView?.stopAnimation()
            backGroundView!.isHidden = true
            loadingView!.isHidden = true
            
            if(!success){
                let alert = SCLAlertView.init(newWindow: ())
                alert?.horizontalButtons = true
                alert?.showSuccess(AppName, subTitle: result as? String, closeButtonTitle: Language.ok(), duration: 0.0)
                return
            }
            
//            let resultDict = result as! NSDictionary
//            let arrQuizData = resultDict.value(forKey: "quiz_data") as! NSArray
            
            let resultDict = result as! NSDictionary
            let quizArr : NSArray = resultDict.value(forKey: "quiz_data") as? NSArray ?? NSArray()
            
            self.arrOfQuizStruct.removeAll()
            for aDict in quizArr {
                var aStruct = QuizDataStruct()
                let tempDict = aDict as! NSDictionary
                aStruct.id = (tempDict.value(forKey: "id") as! String)
                aStruct.question = (tempDict.value(forKey: "question") as! String)
                aStruct.option1 = (tempDict.value(forKey: "option1") as! String)
                aStruct.option2 = (tempDict.value(forKey: "option2") as! String)
                aStruct.option3 = (tempDict.value(forKey: "option3") as! String)
                aStruct.option4 = (tempDict.value(forKey: "option4") as! String)
                aStruct.answer = (tempDict.value(forKey: "answer") as! String)
                aStruct.reason = (tempDict.value(forKey: "reason") as! String)
                aStruct.question_no = "\(tempDict.value(forKey: "question_no")!)"
                aStruct.selectedAnswer = "\(tempDict.value(forKey: "user_answer")!)"
                //(tempDict.value(forKey: "question_no") as! String)
                
                aStruct.isOption1Tapped = false
                aStruct.isOption2Tapped = false
                aStruct.isOption3Tapped = false
                aStruct.isOption4Tapped = false
                
                switch aStruct.selectedAnswer {
                case aStruct.option1:
                    aStruct.isOption1Tapped = true
                    break
                case aStruct.option2:
                    aStruct.isOption2Tapped = true
                    break
                case aStruct.option3:
                    aStruct.isOption3Tapped = true
                    break
                case aStruct.option4:
                    aStruct.isOption4Tapped = true
                    break
                default:
                    break
                }
                
                self.arrOfQuizStruct.append(aStruct)
            }
            
            theContainerTV.reloadData()
            
        })
    }
    
    func getAllAssessment(){
        backGroundView!.isHidden = false
        loadingView!.startAnimation()
        loadingView!.isHidden = false
        img!.isHidden = false
        
        APIManager.sharedInstance()?.getAssementDetails(withArticleId: articleId, andComplete: { [self] (success, result) in
            
            loadingView?.stopAnimation()
            backGroundView!.isHidden = true
            loadingView!.isHidden = true
            
            if(!success){
                let alert = SCLAlertView.init(newWindow: ())
                alert?.horizontalButtons = true
                alert?.showSuccess(AppName, subTitle: result as? String, closeButtonTitle: Language.ok(), duration: 0.0)
                return
            }
            
            let resultDict = result as! NSDictionary
            dataDict = resultDict.value(forKey: "data") as? NSDictionary
            
            let quizArr : NSArray = dataDict!.value(forKey: "quiz_data") as? NSArray ?? NSArray()
            
            self.arrOfQuizStruct.removeAll()
            for aDict in quizArr {
                var aStruct = QuizDataStruct()
                let tempDict = aDict as! NSDictionary
                aStruct.id = (tempDict.value(forKey: "id") as! String)
                aStruct.question = (tempDict.value(forKey: "question") as! String)
                aStruct.option1 = (tempDict.value(forKey: "option1") as! String)
                aStruct.option2 = (tempDict.value(forKey: "option2") as! String)
                aStruct.option3 = (tempDict.value(forKey: "option3") as! String)
                aStruct.option4 = (tempDict.value(forKey: "option4") as! String)
                aStruct.answer = (tempDict.value(forKey: "answer") as! String)
                aStruct.reason = (tempDict.value(forKey: "reason") as! String)
                aStruct.question_no = "\(tempDict.value(forKey: "question_no")!)" //(tempDict.value(forKey: "question_no") as! String)
                
                aStruct.isOption1Tapped = false
                aStruct.isOption2Tapped = false
                aStruct.isOption3Tapped = false
                aStruct.isOption4Tapped = false
                
                self.arrOfQuizStruct.append(aStruct)
            }
            
            
            theContainerTV.reloadData()
        })
    }
    
    
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension AssessmentVC : UITableViewDelegate ,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfQuizStruct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCellID", for: indexPath) as! QuestionCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        cell.delegate = self
        
        let aQuizStruct = self.arrOfQuizStruct[indexPath.row]
        cell.questionLbl.text = aQuizStruct.question
        cell.option1Lbl.text = aQuizStruct.option1
        cell.option2Lbl.text = aQuizStruct.option2
        cell.option3Lbl.text = aQuizStruct.option3
        cell.option4Lbl.text = aQuizStruct.option4
        cell.reasonLbl.text = aQuizStruct.reason //"find specified service"
        cell.correctAnswerLbl.text = aQuizStruct.answer
        cell.QuestionNoLbl.text = "Q." + aQuizStruct.question_no
        
        if quizOrResult == "quiz"{
            cell.correctAnswerStaticLblHeight.constant = 0
            cell.reasonStaticLblHeight.constant = 0
            cell.reasonLbl.text = ""
        }else{
            
            if aQuizStruct.answer == aQuizStruct.selectedAnswer {
                cell.correctAnswerStaticLblHeight.constant = 0
            }else{
                cell.correctAnswerStaticLblHeight.constant = 20
            }
            
            cell.reasonStaticLblHeight.constant = 20
        }
    
        cell.option1Btn.tag = indexPath.row
        cell.option1Btn.accessibilityHint = "1"
        if aQuizStruct.isOption1Tapped {
            cell.option1Btn.setImage(selectionImg, for: .normal)
        }else{
            cell.option1Btn.setImage(unSelectionImg, for: .normal)
        }
        
        if quizOrResult == "result"{
            cell.answerImgView.isHidden = false
            if self.arrOfQuizStruct[indexPath.row].answer == self.arrOfQuizStruct[indexPath.row].selectedAnswer {
                cell.answerImgView.image = self.correctImg
            }else{
                cell.answerImgView.image = self.wrongImg
            }
        }
        
        if quizOrResult == "quiz"{
            cell.option1Btn.addTarget(self, action: #selector(option1Tapped(sender:)), for: .touchUpInside)
        }
        
        cell.option2Btn.tag = indexPath.row
        cell.option2Btn.accessibilityHint = "2"
        if aQuizStruct.isOption2Tapped {
            cell.option2Btn.setImage(selectionImg, for: .normal)
        }else{
            cell.option2Btn.setImage(unSelectionImg, for: .normal)
        }
        if quizOrResult == "quiz"{
            cell.option2Btn.addTarget(self, action: #selector(option2Tapped(sender:)), for: .touchUpInside)
        }
        
        
        cell.option3Btn.tag = indexPath.row
        cell.option3Btn.accessibilityHint = "3"
        if aQuizStruct.isOption3Tapped {
            cell.option3Btn.setImage(selectionImg, for: .normal)
        }else{
            cell.option3Btn.setImage(unSelectionImg, for: .normal)
        }
        if quizOrResult == "quiz"{
            cell.option3Btn.addTarget(self, action: #selector(option3Tapped(sender:)), for: .touchUpInside)
        }
        
        
        cell.option4Btn.tag = indexPath.row
        cell.option4Btn.accessibilityHint = "4"
        if quizOrResult == "quiz"{
            cell.option4Btn.addTarget(self, action: #selector(option4Tapped(sender:)), for: .touchUpInside)
        }
        
        if aQuizStruct.isOption4Tapped {
            cell.option4Btn.setImage(selectionImg, for: .normal)
        }else{
            cell.option4Btn.setImage(unSelectionImg, for: .normal)
        }
        return cell
    }
    
    @objc func option1Tapped(sender: UIButton){
        let buttonTag = sender.tag
        print("cell index is ",buttonTag)
        print("option1 tapped")
        
        if self.arrOfQuizStruct[buttonTag].isOption1Tapped {
//            self.arrOfQAStruct[buttonTag].isOption1Tapped = false
        }else{
            self.arrOfQuizStruct[buttonTag].isOption1Tapped = true
            self.arrOfQuizStruct[buttonTag].isOption2Tapped = false
            self.arrOfQuizStruct[buttonTag].isOption3Tapped = false
            self.arrOfQuizStruct[buttonTag].isOption4Tapped = false
            
            self.arrOfQuizStruct[buttonTag].selectedAnswer = self.arrOfQuizStruct[buttonTag].option1
            
            self.arrQuestionsAnswered.append(self.arrOfQuizStruct[buttonTag].option1)
        }
        updateTheCell(cellIndex: buttonTag, sender: sender)
        
    }
    @objc func option2Tapped(sender: UIButton){
        let buttonTag = sender.tag
        print("cell index is ",buttonTag)
        print("option1 tapped")
        
        if self.arrOfQuizStruct[buttonTag].isOption2Tapped {
//            self.arrOfQAStruct[buttonTag].isOption2Tapped = false
        }else{
            self.arrOfQuizStruct[buttonTag].isOption2Tapped = true
            self.arrOfQuizStruct[buttonTag].isOption1Tapped = false
            self.arrOfQuizStruct[buttonTag].isOption3Tapped = false
            self.arrOfQuizStruct[buttonTag].isOption4Tapped = false
            
            self.arrOfQuizStruct[buttonTag].selectedAnswer = self.arrOfQuizStruct[buttonTag].option2
            
            self.arrQuestionsAnswered.append(self.arrOfQuizStruct[buttonTag].option2)
        }
        updateTheCell(cellIndex: buttonTag, sender: sender)
        
    }
    
    @objc func option3Tapped(sender: UIButton){
        let buttonTag = sender.tag
        print("cell index is ",buttonTag)
        print("option1 tapped")
        
        if self.arrOfQuizStruct[buttonTag].isOption3Tapped {
//            self.arrOfQAStruct[buttonTag].isOption3Tapped = false
        }else{
            self.arrOfQuizStruct[buttonTag].isOption3Tapped = true
            self.arrOfQuizStruct[buttonTag].isOption1Tapped = false
            self.arrOfQuizStruct[buttonTag].isOption2Tapped = false
            self.arrOfQuizStruct[buttonTag].isOption4Tapped = false
            
            self.arrOfQuizStruct[buttonTag].selectedAnswer = self.arrOfQuizStruct[buttonTag].option3
            
            self.arrQuestionsAnswered.append(self.arrOfQuizStruct[buttonTag].option3)
        }
        updateTheCell(cellIndex: buttonTag, sender: sender)
        
    }
    
    @objc func option4Tapped(sender: UIButton){
        let buttonTag = sender.tag
        print("cell index is ",buttonTag)
        print("option1 tapped")
        
        if self.arrOfQuizStruct[buttonTag].isOption4Tapped {
//            self.arrOfQAStruct[buttonTag].isOption4Tapped = false
        }else{
            self.arrOfQuizStruct[buttonTag].isOption4Tapped = true
            self.arrOfQuizStruct[buttonTag].isOption1Tapped = false
            self.arrOfQuizStruct[buttonTag].isOption2Tapped = false
            self.arrOfQuizStruct[buttonTag].isOption3Tapped = false
            
            self.arrOfQuizStruct[buttonTag].selectedAnswer = self.arrOfQuizStruct[buttonTag].option4
            
            self.arrQuestionsAnswered.append(self.arrOfQuizStruct[buttonTag].option4)
        }
        updateTheCell(cellIndex: buttonTag, sender: sender)
        
    }
    
    func updateTheCell(cellIndex : Int,sender : UIButton){
        
        let selectedIndexPath = IndexPath(row: cellIndex, section: 0)
        let cell = self.theContainerTV.cellForRow(at: selectedIndexPath as IndexPath) as! QuestionCell
        
        switch sender.accessibilityHint {
            case "1":
                if self.arrOfQuizStruct[cellIndex].isOption1Tapped {
                    cell.option1Btn.setImage(selectionImg, for: .normal)
                    cell.option2Btn.setImage(unSelectionImg, for: .normal)
                    cell.option3Btn.setImage(unSelectionImg, for: .normal)
                    cell.option4Btn.setImage(unSelectionImg, for: .normal)
                    
                }else{
//                    cell.option1Btn.setImage(unSelectionImg, for: .normal)
                }
                break
        case "2":
            if self.arrOfQuizStruct[cellIndex].isOption2Tapped {
                cell.option2Btn.setImage(selectionImg, for: .normal)
                cell.option1Btn.setImage(unSelectionImg, for: .normal)
                cell.option3Btn.setImage(unSelectionImg, for: .normal)
                cell.option4Btn.setImage(unSelectionImg, for: .normal)
            }else{
//                cell.option2Btn.setImage(unSelectionImg, for: .normal)
            }
            break
        case "3":
            if self.arrOfQuizStruct[cellIndex].isOption3Tapped {
                cell.option3Btn.setImage(selectionImg, for: .normal)
                cell.option1Btn.setImage(unSelectionImg, for: .normal)
                cell.option2Btn.setImage(unSelectionImg, for: .normal)
                cell.option4Btn.setImage(unSelectionImg, for: .normal)
                
            }else{
//                cell.option3Btn.setImage(unSelectionImg, for: .normal)
            }
            break
        case "4":
            if self.arrOfQuizStruct[cellIndex].isOption4Tapped {
                cell.option4Btn.setImage(selectionImg, for: .normal)
                cell.option1Btn.setImage(unSelectionImg, for: .normal)
                cell.option2Btn.setImage(unSelectionImg, for: .normal)
                cell.option3Btn.setImage(unSelectionImg, for: .normal)
                
            }else{
//                cell.option4Btn.setImage(unSelectionImg, for: .normal)
            }
            break
            
        /* case "5" :
            if self.arrOfQuizStruct[cellIndex].isSubmitBtnTapped {
                
                cell.answerImgView.isHidden = false
                if self.arrOfQuizStruct[cellIndex].actualAnwser  == self.arrOfQuizStruct[cellIndex].selectedAnswer {
                    cell.answerImgView.image = self.correctImg
                    cell.correctAnswerLbl.isHidden = true
                }else{
                    cell.answerImgView.image = self.wrongImg
                    cell.correctAnswerLbl.isHidden = false
                    cell.correctAnswerLbl.text = "Correct answer : \(self.arrOfQuizStruct[cellIndex].actualAnwser!)"
                }
            }else{
                cell.answerImgView.isHidden = true
            }
            break */
            
        default:
            break
        }
    }
    
}
extension AssessmentVC : QuestionCellDelegate{
    
}
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

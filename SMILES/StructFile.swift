//
//  StructFile.swift
//  Muknow
//
//  Created by Apple on 15/11/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit



struct QAStruct {
    var Question : String!
    var answer1 : String!
    var answer2 : String!
    var answer3 : String!
    var answer4 : String!
    
    var isOption1Tapped : Bool!
    var isOption2Tapped : Bool!
    var isOption3Tapped : Bool!
    var isOption4Tapped : Bool!
    
    var isAnswerImgViewHidden : Bool!
    var isSubmitBtnTapped : Bool!
    
    var actualAnwser : String!
    var selectedAnswer : String!
    
}

struct QuizDataStruct {
    var answer: String!
    var id: String!
    var option1: String!
    var option2: String!
    var option3: String!
    var option4: String!
    var question: String!
    var question_no: String!
    var reason: String!
    var timer: String!
//    var user_answer: String!
    
    var isOption1Tapped : Bool!
    var isOption2Tapped : Bool!
    var isOption3Tapped : Bool!
    var isOption4Tapped : Bool!
    
    var selectedAnswer : String!
    
    
}

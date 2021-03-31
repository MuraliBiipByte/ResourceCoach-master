//
//  ViewAnswerTableViewCell.h
//  DedaaBox
//
//  Created by Biipmi on 15/8/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewAnswerTableViewCell : UITableViewCell
//Sequence
@property (weak, nonatomic) IBOutlet UILabel *lblSequenceName;
@property (weak, nonatomic) IBOutlet UILabel *lblPostedDate;

//Sequence Details
@property (weak, nonatomic) IBOutlet UILabel *lblSequenceDetailName;

//Assessment
@property (weak, nonatomic) IBOutlet UILabel *lblQuestionName;
@property (weak, nonatomic) IBOutlet UILabel *lblOption1;
@property (weak, nonatomic) IBOutlet UILabel *lblOption2;
@property (weak, nonatomic) IBOutlet UILabel *lblOption3;
@property (weak, nonatomic) IBOutlet UILabel *lblOption4;
@property (weak, nonatomic) IBOutlet UIButton *btnOption1;
@property (weak, nonatomic) IBOutlet UIButton *btnOption2;
@property (weak, nonatomic) IBOutlet UIButton *btnOption3;
@property (weak, nonatomic) IBOutlet UIButton *btnOption4;
@property (weak, nonatomic) IBOutlet UIImageView *corectImg;
@property (weak, nonatomic) IBOutlet UILabel *lblQuestionNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblAnswer;
@property (weak, nonatomic) IBOutlet UILabel *answerText;

//share group objects
@property (strong, nonatomic) IBOutlet UIView *bkgView;
@property (strong, nonatomic) IBOutlet UIImageView *subUserImg;
@property (strong, nonatomic) IBOutlet UILabel *subUserName;

//Assessment
@property (strong, nonatomic) IBOutlet UIView *assBackgroundView;
@property (strong, nonatomic) IBOutlet UILabel *lblAssmentTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblAssesmentCreated;
@property (weak, nonatomic) IBOutlet UIButton *btnAssesment;

//Articles
@property (strong, nonatomic) IBOutlet UILabel *lblArticleTitlel;
@property (weak, nonatomic) IBOutlet UIButton *btnSelect;
@end

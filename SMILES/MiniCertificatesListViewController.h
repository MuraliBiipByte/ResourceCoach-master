//
//  MiniCertificatesListViewController.h
//  certifications
//
//  Created by Biipmi on 12/10/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYCircleLoadingView.h"

@interface MiniCertificatesListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tblCertificates;
@property (nonatomic, retain) IBOutlet NSMutableArray *arrCertificateID;
@property (nonatomic, retain) IBOutlet NSMutableArray *arrCertificateName;
@property (nonatomic, retain) IBOutlet NSMutableArray *arrPercentage;
@property (nonatomic, retain) IBOutlet NSMutableArray *arrEmailId;
@property (nonatomic, retain) IBOutlet NSMutableArray *arrDate;
@property (nonatomic, retain) IBOutlet NSMutableArray *arrAttemptCount;

@property (nonatomic, retain) IBOutlet NSMutableArray *arrMobileNumbers;
@property (nonatomic, retain) IBOutlet NSMutableArray *arrTelecodes;
@property (nonatomic, retain) IBOutlet NSString *usrId;

@end

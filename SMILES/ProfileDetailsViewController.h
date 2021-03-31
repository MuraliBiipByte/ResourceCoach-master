//
//  ProfileDetailsViewController.h
//  SMILES
//
//  Created by BiipByte Technologies on 20/09/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblExpairyDate;
@property (weak, nonatomic) IBOutlet UIView *certificatesView;
@property (weak, nonatomic) IBOutlet UILabel *lblScore;
@property (weak, nonatomic) IBOutlet UILabel *lblCertificationName;
@property (weak, nonatomic) IBOutlet UILabel *lblEmai;
@property (weak, nonatomic) IBOutlet UILabel *lbldate;
@property (weak, nonatomic) IBOutlet UILabel *lblCount;
@property (weak, nonatomic) IBOutlet UIButton *btnViewAllCertificates;
@property (weak, nonatomic) IBOutlet UIImageView *imgCertificate;
@property (weak, nonatomic) IBOutlet UILabel *lblCertificateMobileNumber;



@end

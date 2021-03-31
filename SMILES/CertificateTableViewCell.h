//
//  CertificateTableViewCell.h
//  certifications
//
//  Created by Biipmi on 12/10/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CertificateTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblCertificateName;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblAttemptCount;
@property (weak, nonatomic) IBOutlet UILabel *lblPercentage;
@property (weak, nonatomic) IBOutlet UILabel *lblMobileNumberWithTelecode;

@end

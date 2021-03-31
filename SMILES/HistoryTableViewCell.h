//
//  HistoryTableViewCell.h
//  DedaaBox
//
//  Created by BiipByte on 8/16/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *videoImage;

@property (weak, nonatomic) IBOutlet UILabel *lblAuthorName;
@property (weak, nonatomic) IBOutlet UILabel *lblShortDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblVideoName;

@property (weak, nonatomic) IBOutlet UIImageView *imglockHistory;
@property (weak, nonatomic) IBOutlet UIImageView *VideoPlayImg;


@property (weak, nonatomic) IBOutlet UILabel *lblRating;
@property (weak, nonatomic) IBOutlet UILabel *lblRatingCount;

@property (weak, nonatomic) IBOutlet UILabel *lblViews;
@property (weak, nonatomic) IBOutlet UILabel *lblBgRate;
@property (weak, nonatomic) IBOutlet UILabel *lblDuration;


@end

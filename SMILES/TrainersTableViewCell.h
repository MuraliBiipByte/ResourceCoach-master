//
//  TrainersTableViewCell.h
//  DedaaBox
//
//  Created by BiipByte on 24/07/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrainersTableViewCell : UITableViewCell

//Outlets
//ImageViews
@property (nonatomic,weak) IBOutlet UIImageView *imgSmallProfile;

//Labels
@property (nonatomic,weak) IBOutlet UILabel *lblSmallAuthorName;
@property (nonatomic,weak) IBOutlet UILabel *lblArticleDescription;
@property (nonatomic,weak) IBOutlet UILabel *lblBackground;
@property (weak, nonatomic) IBOutlet UIButton *btnFav;

@end

//
//  LessonsTableViewCell.h
//  DedaaBox
//
//  Created by BiipByte on 04/08/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LessonsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblArticleTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDuration;
@property (weak, nonatomic) IBOutlet UIImageView *imgLock;

@end

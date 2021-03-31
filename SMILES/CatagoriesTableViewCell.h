//
//  CatagoriesTableViewCell.h
//  DedaaBox
//
//  Created by BiipByte on 01/08/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatagoriesTableViewCell : UITableViewCell

//CatagoriesArticle
@property (weak, nonatomic) IBOutlet UIImageView *catagoriesArticleImg;
@property (weak, nonatomic) IBOutlet UILabel *catagoriesArticleLabel;
@property (weak, nonatomic) IBOutlet UILabel *lblcatagoriesOverlay;
@property (weak, nonatomic) IBOutlet UIImageView *catagoriesVideoImg;

@end

//
//  RecomendedCollectionViewCell.h
//  DedaaBox
//
//  Created by BiipByte on 07/08/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecomendedCollectionViewCell : UICollectionViewCell

//Recomended
@property (weak, nonatomic) IBOutlet UIImageView *recomendedarticleImg;
@property (weak, nonatomic) IBOutlet UILabel *recomendedlblArticleTitle;
@property (weak, nonatomic) IBOutlet UIImageView *recomendedvideoImg;
@property (weak, nonatomic) IBOutlet UILabel *recomendedlblArticleDuration;
@property (weak, nonatomic) IBOutlet UIImageView *recomendedlatestLockImg;

@end

//
//  TrainerVideosCollectionViewCell.h
//  DedaaBox
//
//  Created by BiipByte on 24/07/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrainerVideosCollectionViewCell : UICollectionViewCell

//Outlets

//ImageViews
@property (nonatomic,weak) IBOutlet UIImageView *imageViewAuthorVideos;
@property (nonatomic,weak) IBOutlet UIImageView *imageViewLogoAuthorVideos;

//Labesl
@property (nonatomic,weak) IBOutlet UILabel *lblDurationAuthorVideos;
@property (nonatomic,weak) IBOutlet UILabel *lblTitleAuthorVideos;
@property (nonatomic,weak) IBOutlet UILabel *lblOverlayAuthorVideos;
@property (weak, nonatomic) IBOutlet UIImageView *ImgLock;

@end

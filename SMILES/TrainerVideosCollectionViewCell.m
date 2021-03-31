//
//  TrainerVideosCollectionViewCell.m
//  DedaaBox
//
//  Created by BiipByte on 24/07/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import "TrainerVideosCollectionViewCell.h"

@implementation TrainerVideosCollectionViewCell
@synthesize lblTitleAuthorVideos,lblDurationAuthorVideos,lblOverlayAuthorVideos,imageViewAuthorVideos,imageViewLogoAuthorVideos;

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    imageViewAuthorVideos.layer.cornerRadius=05.0f;
    imageViewAuthorVideos.layer.masksToBounds=YES;
    lblOverlayAuthorVideos.layer.cornerRadius=05.0f;
    lblOverlayAuthorVideos.layer.masksToBounds=YES;

    
}

@end

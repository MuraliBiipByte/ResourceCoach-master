//
//  TrainerDetailsViewController.h
//  DedaaBox
//
//  Created by BiipByte on 24/07/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrainerDetailsViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

//Outlets

//CollectionViews

@property (nonatomic,weak) IBOutlet UICollectionView *collectionViewAuthorVideos;

//View
@property (nonatomic,weak) IBOutlet UIView *videosLabelView;
@property (nonatomic,weak) IBOutlet UIView *authordetailsView;
@property (nonatomic,weak) IBOutlet UIView *videosView;


//labels
@property (nonatomic,retain)  IBOutlet UILabel *lblAuthoursName;
@property (nonatomic,retain)  IBOutlet UILabel *lblAuthoursDescription;


//Strings
@property (nonatomic,retain)   NSString *authorsID;
@property (nonatomic,retain)   NSString *authorsName;
@property (nonatomic,retain)   NSString *authorsDescription;


//ImageViews
@property (nonatomic,retain)  IBOutlet UIImageView *imgAuthour;
@property (nonatomic,weak) IBOutlet UIView *overlayImageView;

@property (weak, nonatomic) IBOutlet UIButton *btnAuthoreImg;
@property (weak, nonatomic) IBOutlet UIButton *btnAuthoreName;
@property (weak, nonatomic) IBOutlet UIButton *btnFav;

@end

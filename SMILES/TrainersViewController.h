//
//  TrainersViewController.h
//  DedaaBox
//
//  Created by BiipByte on 24/07/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrainersViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>


//Outlets

//CollectionViews

@property (nonatomic,weak) IBOutlet UICollectionView *collectionViewAuthors;
@property (nonatomic,weak) IBOutlet UITableView *tableViewViewAuthors;
@property (weak, nonatomic) IBOutlet UIView *viewFav;
@property (weak, nonatomic) IBOutlet UIView *viewFavTrainer;
@property (weak, nonatomic) IBOutlet UIView *viewTrainers;


//Arrays

@property (nonatomic,retain)  NSMutableArray *arrFavAuthoursName;
@property (nonatomic,retain)  NSMutableArray *arrAuthoursName;
@property (nonatomic,retain)  NSMutableArray *arrFavAuthoursImages;
@property (nonatomic,retain)  NSMutableArray *arrAuthorsImages;
@property (nonatomic,retain)  NSMutableArray *arrAuthorsIds;
@property (nonatomic,retain)  NSMutableArray *arrFavAuthorsIds;
@property (nonatomic,retain)  NSMutableArray *arrAuthorsDescription;
@property (nonatomic,retain)  NSMutableArray *arrFavAuthorsDescription;


@property (nonatomic,retain)  NSMutableArray *arrArticleTitles;
@property (nonatomic,retain)  NSMutableArray *arrArticleDescription;

//Boolean
@property (nonatomic,assign) BOOL disablePanGesture;


@end

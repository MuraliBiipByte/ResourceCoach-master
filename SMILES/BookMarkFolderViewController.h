//
//  BookMarkFolderViewController.h
//  Resource Coach
//
//  Created by Admin on 09/09/1939 Saka.
//  Copyright © 1939 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookMarkFolderViewController : UIViewController
@property (nonatomic,assign) BOOL disablePanGesture;
@property (weak, nonatomic) IBOutlet UICollectionView *folderCollectionView;
@property (weak, nonatomic) IBOutlet UIView *viewFolders;
@end

//
//  BookMarkCollectionViewCell.h
//  BookMarksPage
//
//  Created by Admin on 09/09/1939 Saka.
//  Copyright © 1939 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookMarkCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgFolder;
@property (weak, nonatomic) IBOutlet UILabel *folderTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;

@end

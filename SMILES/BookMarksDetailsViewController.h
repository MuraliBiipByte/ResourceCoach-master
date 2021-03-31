//
//  BookMarksDetailsViewController.h
//  Resource Coach
//
//  Created by Admin on 10/09/1939 Saka.
//  Copyright © 1939 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookMarksDetailsViewController : UIViewController
@property (weak, nonatomic) NSString *strFolderId;
@property (weak, nonatomic) IBOutlet UITableView *tblBookMarkArticles;
@property (weak, nonatomic) IBOutlet UIButton *btnBookMarkDelete;
@end

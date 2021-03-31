//
//  MiniCertificateViewController.h
//  DedaaBox
//
//  Created by Biipmi on 3/8/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKSTableView.h"
@interface MiniCertificateViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SKSTableViewDelegate>
@property (nonatomic,weak) IBOutlet SKSTableView *miniLessonsTable;
@end

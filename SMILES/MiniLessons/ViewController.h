//
//  ViewController.h
//  MiniLessons
//
//  Created by Biipmi on 2/8/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKSTableView.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SKSTableViewDelegate>

//Outlets

@property (nonatomic,weak) IBOutlet SKSTableView *miniLessonsTable;


@end


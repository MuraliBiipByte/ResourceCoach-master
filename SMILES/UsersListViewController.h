//
//  UsersListViewController.h

//
//  Created by BiipByte on 15/06/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;


@interface UsersListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain)NSString *articleId;
@property (nonatomic, readonly, strong) FIRDatabaseReference * ref;
@end

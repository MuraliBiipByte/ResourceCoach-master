//
//  UsersListViewController.m

//
//  Created by BiipByte on 15/06/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import "UsersListViewController.h"
#import "UIImageView+WebCache.h"
#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "APIDefineManager.h"
#import "Utility.h"
#import "ChatingViewController.h"


@interface UsersListViewController ()
{
    NSMutableArray *allSnaps;
    FIRDataSnapshot *snapshot1;
    MessageTableViewCell *cell;
}

@property (weak, nonatomic) IBOutlet UITableView *tbleUsersList;
@end

@implementation UsersListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    allSnaps=[[NSMutableArray alloc]init];
    [self getAllChatUsers];

  
    [self navigationConfiguration];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
   }
#pragma mark - Navigation Configuration
-(void)navigationConfiguration{
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnTapped:)];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
   
    self.title=@"Chats";
    
    
}
-(void)getAllChatUsers
{
    [Utility showLoading:self];
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    NSLog(@"Article id is %@",self.articleId);
    
    [[[ref child:@"article_user"] child:[NSString stringWithFormat:@"-%@",self.articleId]]observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot)
     {
         [allSnaps removeAllObjects];
          NSMutableDictionary *dict = snapshot.value;
         if ([dict isEqual:[NSNull null]]) {
               [Utility hideLoading:self];
            
             UILabel *messageLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,
                                                                             _tbleUsersList.bounds.size.width,
                                                                             _tbleUsersList.bounds.size.height)];
             messageLbl.text = @"No data is available";
             messageLbl.textAlignment = NSTextAlignmentCenter;
             [messageLbl sizeToFit];
            _tbleUsersList.backgroundView = messageLbl;
            _tbleUsersList.separatorStyle = UITableViewCellSeparatorStyleNone;
         }
         else
         {
         for (snapshot in snapshot.children)
         {
             
             [allSnaps addObject:snapshot];
             
             [_tbleUsersList reloadData];
             [Utility hideLoading:self];

         }
         }
         
         
         
//         if ([allSnaps count]>0)
//         {
//             [self.chatTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:allSnaps.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//             
//         }
         
     } withCancelBlock:^(NSError * _Nonnull error)
    {
        
          [Utility hideLoading:self];
         NSLog(@"%@", error.localizedDescription);
     }];
    //[self updateTableView];

}
-(void)backBtnTapped:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
//    if ([allSnaps count]==0) {
//        _tbleUsersList.hidden=YES;
//        UILabel *lblNochats=[[UILabel alloc]init];
//        lblNochats.text=@"No Chats Available";
//        [lblNochats setCenter:self.view.center];
//        [self.view addSubview:lblNochats];
//    }
    

    return [allSnaps count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MessageTableViewCell";
     snapshot1 = [allSnaps objectAtIndex:indexPath.row];
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier] ;
    
    
    if (cell == nil)
    {
        cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    cell.lblUserName.text=snapshot1.value[@"sender_name"];
    cell.useImage.layer.cornerRadius = cell.useImage.frame.size.height/2;
    cell.useImage.layer.masksToBounds = YES;
    cell.contemtBackgroundView.layer.cornerRadius=20;
    cell.contemtBackgroundView.layer.masksToBounds=YES;
    
    [cell.useImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",BASE_URL,snapshot1.value[@"sender_image"]]] placeholderImage:[UIImage imageNamed:@"userprofile"]];
    if (!cell.useImage.image) {
        cell.useImage.image=[UIImage imageNamed:@"userprofile"];
    }
   
    
          return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     snapshot1 = [allSnaps objectAtIndex:indexPath.row];
    
    ChatingViewController *message=[self.storyboard instantiateViewControllerWithIdentifier:@"ChatingViewController"];
   // MessageViewController *message=[self.storyboard instantiateViewControllerWithIdentifier:@"MessageViewController"];
    message.authorName=snapshot1.value[@"sender_name"];
    message.authorId=snapshot1.value[@"sender_id"];
    message.authoreImage=snapshot1.value[@"sender_image"];
    message.articleId=self.articleId;
    [self.navigationController pushViewController:message animated:YES];
}

@end

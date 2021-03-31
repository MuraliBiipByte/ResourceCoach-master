//
//  BookMarkFolderViewController.m
//  Resource Coach
//
//  Created by Admin on 09/09/1939 Saka.
//  Copyright © 1939 Biipmi. All rights reserved.
//

#import "BookMarkFolderViewController.h"
#import "BookMarkCollectionViewCell.h"
#import "REFrostedViewController.h"
#import "Utility.h"
#import "APIDefineManager.h"
#import "APIManager.h"
#import "HYCircleLoadingView.h"
#import "BookMarksDetailsViewController.h"
@interface BookMarkFolderViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSString *uID,*UserType;
    NSMutableArray *arrNames;
    NSMutableArray *arrIds;
  NSMutableArray *arrBookMarkData;
    
     UIView *backGroundView;
}
@property (nonatomic, strong) HYCircleLoadingView *loadingView;
@property(nonatomic,retain)UIImageView *img;
@end

@implementation BookMarkFolderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrNames = [[NSMutableArray alloc]init];
    arrIds = [[NSMutableArray alloc]init];
    arrBookMarkData=[[NSMutableArray alloc]init];
    
    backGroundView=[[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:backGroundView];
    backGroundView.backgroundColor= [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.20];
    backGroundView.hidden=NO;
   
    
    self.loadingView = [[HYCircleLoadingView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30,self.view.frame.size.height/2-30 , 60, 60)];
    self.img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2+15-38, self.view.frame.size.height/2+15-38, 45, 45)];
    self.img.image=[UIImage imageNamed:@"loading"];
    //[self.view addSubview:self.img];
    [backGroundView addSubview:self.img];
    [self.img setHidden:YES];
    [self.loadingView setHidden:YES];
    // [self.view addSubview:self.loadingView];
    [backGroundView addSubview:self.loadingView];
    [self.view bringSubviewToFront:backGroundView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *usercheckup=[NSUserDefaults standardUserDefaults];
    uID=[usercheckup valueForKey:@"id"];
    UserType=[usercheckup valueForKey:@"usertype"];
    [self getFolders];
    [self navigationConfiguration];
}
#pragma mark - Navigation Configuration
-(void)navigationConfiguration
{
    
    self.title=@"My BookMarks";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:14]}];
    UIBarButtonItem *menu = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Menu"] style:UIBarButtonItemStylePlain target:self action:@selector(menuTapped)];
    [self.navigationItem setLeftBarButtonItem:menu];
}

#pragma mark -Button Mennu Tapped
-(void)menuTapped
{
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}
- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    if (_disablePanGesture)
    {
        return;
    }
    [self.frostedViewController panGestureRecognized:sender];
}
-(void)getFolders{
    [arrIds removeAllObjects];
    [arrNames removeAllObjects];
   
    [self.loadingView startAnimation];
    [self.loadingView setHidden:NO];
    [self.img setHidden:NO];
    [[APIManager sharedInstance]getUserFoldersWithUserId:uID andCompleteBlock:^(BOOL success, id result)
    {
        [self.loadingView stopAnimation];
        backGroundView.hidden=YES;
        [self.loadingView setHidden:YES];
        [self.img setHidden:YES];
        if (!success)
        {
            UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100)];
            img.image=[UIImage imageNamed:@"nodataimg"];
            UILabel *lblass=[[UILabel alloc] initWithFrame:CGRectMake(8, img.frame.origin.y+108, self.view.frame.size.width-16, 21)];
            lblass.textAlignment=NSTextAlignmentCenter;
            lblass.textColor=[UIColor lightGrayColor];
            lblass.font=[UIFont fontWithName:@"Roboto-Regular" size:14];
            lblass.text=@"No BookMarks Found";
            [self.view addSubview:img];
            [self.view addSubview:lblass];
            return ;
        }
        arrBookMarkData=[result valueForKey:@"bookmark_data"];
        
        if ([arrBookMarkData count]==0)
        {
            _viewFolders.hidden =YES;
            UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100)];
            img.image=[UIImage imageNamed:@"nodataimg"];
            UILabel *lblass=[[UILabel alloc] initWithFrame:CGRectMake(8, img.frame.origin.y+108, self.view.frame.size.width-16, 21)];
            lblass.textAlignment=NSTextAlignmentCenter;
            lblass.textColor=[UIColor lightGrayColor];
            lblass.font=[UIFont fontWithName:@"Roboto-Regular" size:14];
            lblass.text=@"No BookMarks Found";
            [self.view addSubview:img];
            [self.view addSubview:lblass];
        }
        else
        {
         _viewFolders.hidden =NO;
        for (int z=0; z<[arrBookMarkData count];z++)
        {
            [arrIds addObject:[[arrBookMarkData objectAtIndex:z]valueForKey:@"folder_id"]];
            [arrNames addObject:[[arrBookMarkData objectAtIndex:z]valueForKey:@"folder_name"]];
        }
        [_folderCollectionView reloadData];
        }
    }];
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [arrIds count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BookMarkCollectionViewCell *cell = (BookMarkCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"BookMarkCollectionViewCell" forIndexPath:indexPath];
    
    cell.folderTitle.text=[NSString stringWithFormat:@"%@",[arrNames objectAtIndex:indexPath.row]];
     [cell.btnDelete addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
-(void)deleteAction:(id)sender
{
    
    
    
    
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:AppName
                                 message:@"Are you sure you want to delete this folder, deleting this folder will also delete all article inside it."
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    BookMarkCollectionViewCell *clickedCell = (BookMarkCollectionViewCell*)[[sender superview] superview];
                                    NSIndexPath *indexPathCell = [_folderCollectionView indexPathForCell:clickedCell];
                                    NSLog(@"selected Index %ld",(long)indexPathCell.row);
                                    
                                    NSString *strFolderId = [NSString stringWithFormat:@"%@",[arrIds objectAtIndex:indexPathCell.row]];
                                    [[APIManager sharedInstance]deleteBookMarkFolderWithUserId:uID andWithFolderName:strFolderId andCompleteBlock:^(BOOL success, id result) {
                                        if(!success)
                                        {
                                            return ;
                                        }
                                        [self getFolders];
                                    }];
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle no, thanks button
                               }];
    
    //Add your buttons to alert controller
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
    
    
    
    
    
  
    
    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:   (UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"width is %f",self.view.frame.size.width/4);
    return CGSizeMake(self.view.frame.size.width/4, 100);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BookMarksDetailsViewController *bookMarkDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"BookMarksDetailsViewController"];
    bookMarkDetails.strFolderId =[NSString stringWithFormat:@"%@",[arrIds objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:bookMarkDetails animated:YES];
}
@end

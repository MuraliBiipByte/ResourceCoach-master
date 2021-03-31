//
//  SKSTableViewCell.h
//  SKSTableView
//
//  Created by Sakkaras on 26/12/13.
//  Copyright (c) 2013 Sakkaras. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  SKSTableViewCell is a custom table view cell class extended from UITableViewCell class. This class is used to represent the
 *  expandable rows of the SKSTableView object.
 */

@interface SKSTableViewCell : UITableViewCell

/**
 * The boolean value showing the receiver is expandable or not. The default value of this property is NO.
 */
@property (nonatomic, assign, getter = isExpandable) BOOL expandable;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCategory;
@property (weak, nonatomic) IBOutlet UILabel *lblCategoryName;
@property (weak, nonatomic) IBOutlet UILabel *lblSubCount;
@property (weak, nonatomic) IBOutlet UIView *viewBG;
@property (weak, nonatomic) IBOutlet UIImageView *downArrowImg;
@property (weak, nonatomic) IBOutlet UILabel *lblNewArticleCount;

//for Groups
@property (weak, nonatomic) IBOutlet UIImageView *groupImage;
@property (weak, nonatomic) IBOutlet UIButton *btnGroupTitle;
@property (weak, nonatomic) IBOutlet UIView *opacityView;

//for Assesment
@property (strong, nonatomic) IBOutlet UIImageView *assesmentGroupImg;
@property (strong, nonatomic) IBOutlet UILabel *lblAssGrpName;
@property (strong, nonatomic) IBOutlet UIView *viewBackGround;
@property (strong, nonatomic) IBOutlet UIView *assOpacityView;


//MiniCertification Objects...
@property (weak, nonatomic) IBOutlet UILabel *lblCount;
@property (weak, nonatomic) IBOutlet UIImageView *imgAuthore;
@property (weak, nonatomic) IBOutlet UILabel *lblAuthoreName;
@property (weak, nonatomic) IBOutlet UILabel *lblAboutAuthore;
@property (weak, nonatomic) IBOutlet UIButton *btnReadMoreAboutAuthore;
@property (weak, nonatomic) IBOutlet UIButton *btnAuthoreNameTapped;
@property (weak, nonatomic) IBOutlet UIButton *btnAuthoreImageTapped;
@property (weak, nonatomic) IBOutlet UIImageView *imgMiniLock;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImgView;







/**
 * The boolean value showing the receiver is expanded or not. The default value of this property is NO.
 */
@property (nonatomic, assign, getter = isExpanded) BOOL expanded;

/**
 * Adds an indicator view into the receiver when the relevant cell is expanded.
 */
- (void)addIndicatorView;

/**
 * Removes the indicator view from the receiver when the relevant cell is collapsed.
 */
- (void)removeIndicatorView;

/**
 * Returns a boolean value showing if the receiver contains an indicator view or not.
 *
 *  @return The boolean value for the indicator view.
 */
- (BOOL)containsIndicatorView;

- (void)accessoryViewAnimation;

@end

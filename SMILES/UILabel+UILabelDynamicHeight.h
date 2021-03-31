//
//  UILabel+UILabelDynamicHeight.h
//  FoodApp
//
//  Created by Hoang Le Huy on 7/15/15.
//  Copyright (c) 2015 Hoang Le Huy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (UILabelDynamicHeight)
#pragma mark - Calculate the size the Multi line Label
/*====================================================================*/

/* Calculate the size of the Multi line Label */

/*====================================================================*/
/**
 *  Returns the size of the Label
 *
 *  @param aLabel To be used to calculte the height
 *
 *  @return size of the Label
 */
-(CGSize)sizeOfMultiLineLabel;

@end

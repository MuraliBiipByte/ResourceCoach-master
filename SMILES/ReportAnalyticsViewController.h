//
//  ReportAnalyticsViewController.h
//  SMILES
//
//  Created by BiipByte on 06/03/17.
//  Copyright © 2017 Biipmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarChartView.h"

@interface ReportAnalyticsViewController : UIViewController

@property (strong, nonatomic) IBOutlet BarChartView *barChart;
@property (strong, nonatomic)  NSString *assessmentId;

@end

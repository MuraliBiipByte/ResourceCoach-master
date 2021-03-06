//
//  StarRatingControl.h
//  RouteMonitor
//


#import <UIKit/UIKit.h>

@protocol StarRatingDelegate;

@interface StarRatingControl : UIControl

- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame andStars:(NSUInteger)_numberOfStars;

@property (strong) UIImage *star;
@property (strong) UIImage *highlightedStar;
@property (assign) NSUInteger rating;
@property (weak) IBOutlet NSObject<StarRatingDelegate> *delegate;

@end

@protocol StarRatingDelegate

@optional
- (void)starRatingControl:(StarRatingControl *)control didUpdateRating:(NSUInteger)rating;
- (void)starRatingControl:(StarRatingControl *)control willUpdateRating:(NSUInteger)rating;

@end

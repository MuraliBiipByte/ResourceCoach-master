//
//  AKTagTextFieldCell.m
//
//  Created by Andrey Kadochnikov on 30.05.14.
//  Copyright (c) 2014 Andrey Kadochnikov. All rights reserved.
//

#import "AKTagTextFieldCell.h"
@implementation AKTagTextFieldCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _textField = [[AKTextField alloc] initWithFrame:self.contentView.bounds];
		_textField.frame = CGRectInset(_textField.frame, 0, 5);
		_textField.autoresizingMask = UIViewAutoresizingFlexibleHeight  | UIViewAutoresizingFlexibleWidth;
        NSUserDefaults* defaults=[NSUserDefaults standardUserDefaults];
        NSString* language=[defaults valueForKey:@"language"];
        
        
        if ([language isEqualToString:@"2"]) {
            _textField.buttonPlaceholder = @"+ 添加代号";
        }
        else if ([language isEqualToString:@"3"]){
            _textField.buttonPlaceholder = @"+ Tag ကို Add";
        }
        else{
            _textField.buttonPlaceholder = @"+ Add Tag";
        }
		_textField.autocorrectionType = UITextAutocorrectionTypeNo;
		[self.contentView addSubview:_textField];
    }
    return self;
}
@end

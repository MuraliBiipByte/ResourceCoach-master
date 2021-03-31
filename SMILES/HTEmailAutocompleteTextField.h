//
//  HTEmailAutocompleteTextField.h
//  HTTextFieldAutocompletionExample
//  HygieneWatch
//
//  Created by Biipmi on 12/5/16.
//  Copyright © 2016 Biipmi. All rights reserved.
//
#import "HTAutocompleteTextField.h"

@interface HTEmailAutocompleteTextField : HTAutocompleteTextField <HTAutocompleteDataSource>

/*
 * A list of email domains to suggest
 */
@property (nonatomic, copy) NSArray *emailDomains; // modify to use your own custom list of email domains

@end

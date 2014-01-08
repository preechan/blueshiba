//
//  blsRegisterUserViewController.h
//  blueshibaTest
//
//  Created by Preethi Chandrasekhar on 1/7/14.
//  Copyright (c) 2014 Indian Moms Connect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface blsRegisterUserViewController : UIViewController

@property (nonatomic,retain) IBOutlet UITextField *username;
@property (nonatomic,retain) IBOutlet UITextField *city;
@property (nonatomic,retain) IBOutlet UISwitch *isMutable;

-(IBAction)register:(id)sender;
- (NSData*)encodeDictionary:(NSDictionary*)dictionary;
@end

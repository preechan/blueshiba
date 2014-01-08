//
//  blsUpdateUserViewController.h
//  blueshibaTest
//
//  Created by Preethi Chandrasekhar on 1/7/14.
//  Copyright (c) 2014 Indian Moms Connect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface blsUpdateUserViewController : UIViewController

@property(nonatomic,retain)  NSDictionary *user;
@property(nonatomic,retain) IBOutlet UITextField *username;
@property(nonatomic,retain) IBOutlet UITextField *city;
@end

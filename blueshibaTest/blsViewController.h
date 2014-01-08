//
//  blsViewController.h
//  blueshibaTest
//
//  Created by Preethi Chandrasekhar on 1/7/14.
//  Copyright (c) 2014 Indian Moms Connect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface blsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property IBOutlet UITableView *tableView;
@property NSArray *users;
@end

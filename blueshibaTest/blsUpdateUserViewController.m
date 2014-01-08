//
//  blsUpdateUserViewController.m
//  blueshibaTest
//
//  Created by Preethi Chandrasekhar on 1/7/14.
//  Copyright (c) 2014 Indian Moms Connect. All rights reserved.
//

#import "blsUpdateUserViewController.h"

@interface blsUpdateUserViewController ()

@end

@implementation blsUpdateUserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"user %@",self.user);
    self.navigationItem.title = [self.user valueForKey:@"username"];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Update"
                                                                                style:UIBarButtonItemStyleBordered
                                                                               target:self
                                                                               action:@selector(updateUser:)]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateUser:(id)sender{
  
    NSString *dataString = [NSString stringWithFormat:@"userid=%@&username=%@&city=%@&is_mutable=1",[self.user valueForKey:@"user_id"],[self.username text] ,[self.city text]];
    NSError *error = nil;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://blueshiba.com/testAPI/user/%@",[self.user valueForKey:@"user_id"]]]];
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[NSData dataWithBytes:[dataString UTF8String] length:strlen([dataString UTF8String])]];
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSLog(@"request %@",[request description]);
    NSLog(@"response %@",[response description]);
    
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:data
                          
                          options:kNilOptions
                          error:&error];
    
    NSLog(@"json %@",json);
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end

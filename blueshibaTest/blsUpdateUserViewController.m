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
    [self.username setText:[self.user valueForKey:@"username"]];
    [self.city setText:[self.user valueForKey:@"city"]];
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
  
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[self.user valueForKey:@"user_id"] forKey:@"user_id"];
    [dict setValue:[self.username text] forKey:@"username"];
    [dict setValue:[self.city text] forKey:@"city"];
    
    NSError *error = nil;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://blueshiba.com/testAPI/user/%@",[self.user valueForKey:@"user_id"]]]];
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[self encodeDictionary:dict]];
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(error){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else{
        NSDictionary *json = [NSJSONSerialization
                              JSONObjectWithData:data
                              
                              options:kNilOptions
                              error:&error];
        NSLog(@"json response to update %@",json);
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}



@end

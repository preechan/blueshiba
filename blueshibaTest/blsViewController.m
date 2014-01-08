//
//  blsViewController.m
//  blueshibaTest
//
//  Created by Preethi Chandrasekhar on 1/7/14.
//  Copyright (c) 2014 Indian Moms Connect. All rights reserved.
//

#import "blsViewController.h"
#import "blsUpdateUserViewController.h"

@interface blsViewController ()

@end

@implementation blsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://blueshiba.com/testAPI/user"]]];
    [request setHTTPMethod:@"GET"];
    [request setValue:0 forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"text/html; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    NSURLResponse *response;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:data
                          
                          options:kNilOptions
                          error:&error];
    
     NSLog(@"json %@",json);
    self.users = [[json valueForKey:@"_embedded"] valueForKey:@"user"];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CellID";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [[self.users objectAtIndex:indexPath.row] valueForKey:@"username"];
    if([[[self.users objectAtIndex:indexPath.row] valueForKey:@"is_mutable"] boolValue]){
        //set Accessory View
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"[self.users count] %d",[self.users count]);
    return [self.users count];
}


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
           
        blsUpdateUserViewController *vc = (blsUpdateUserViewController *)[segue destinationViewController];
       vc.user = [self.users objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    NSLog(@"user %@",vc.user);
        
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                                 style:UIBarButtonItemStyleBordered
                                                                                target:nil
                                                                                action:nil];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     if([[[self.users objectAtIndex:indexPath.row] valueForKey:@"is_mutable"] boolValue]){
         [self performSegueWithIdentifier:@"UpdateUser" sender:(id)self];
     }
     else{
         [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
     }
}
@end

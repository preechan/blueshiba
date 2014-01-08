//
//  imcNetworkHelper.h
//  IMC
//
//  Created by Preethi Chandrasekhar on 10/20/13.
//  Copyright (c) 2013 Preethi Chandrasekhar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "imcParentViewController.h"

@interface imcNetworkHelper : NSObject
@property (nonatomic, strong, readwrite) NSURLConnection * connection;
@property(nonatomic,strong,readwrite) NSString *urlText;
@property (nonatomic, assign, readwrite ) NSUInteger     networkOperationCount;  // observable
@property (nonatomic, retain,readwrite) NSMutableData *activeDownload;
@property (nonatomic, retain,readwrite) NSDictionary* json;
@property (nonatomic, retain,readwrite) NSMutableArray *dataArray;
@property (nonatomic, retain,readwrite) imcParentViewController *delegate;
- (void)startReceive;
@end

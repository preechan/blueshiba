//
//  imcNetworkHelper.m
//  IMC
//
//  Created by Preethi Chandrasekhar on 10/20/13.
//  Copyright (c) 2013 Preethi Chandrasekhar. All rights reserved.
//

#import "imcNetworkHelper.h"

@implementation imcNetworkHelper
@synthesize json,dataArray,delegate;



- (void)startReceive
// Starts a connection to download the current URL.
{
    BOOL                success;
    NSURL *             url;
    NSURLRequest *      request;
    
    assert(self.connection == nil);         // don't tap receive twice in a row!
        // ditto
    
    self.activeDownload = [NSMutableData data];
    // First get and check the URL.
    
    url = [self smartURLForString:self.urlText];
    success = (url != nil);
    
    // If the URL is bogus, let the user know.  Otherwise kick off the connection.
    
    if ( ! success) {
        //self.statusLabel.text = @"Invalid URL";
    } else {
     
        // Open a connection for the URL.
        
        request = [NSURLRequest requestWithURL:url];
        assert(request != nil);
        
        self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
        assert(self.connection != nil);
        
        
        [self didStartNetworkOperation];
    }
}

- (NSURL *)smartURLForString:(NSString *)str
{
    NSURL *     result;
    NSString *  trimmedStr;
    NSRange     schemeMarkerRange;
    NSString *  scheme;
    
    assert(str != nil);
    
    result = nil;
    
    trimmedStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ( (trimmedStr != nil) && (trimmedStr.length != 0) ) {
        schemeMarkerRange = [trimmedStr rangeOfString:@"://"];
        
        if (schemeMarkerRange.location == NSNotFound) {
            result = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", trimmedStr]];
        } else {
            scheme = [trimmedStr substringWithRange:NSMakeRange(0, schemeMarkerRange.location)];
            assert(scheme != nil);
            
            if ( ([scheme compare:@"http"  options:NSCaseInsensitiveSearch] == NSOrderedSame)
                || ([scheme compare:@"https" options:NSCaseInsensitiveSearch] == NSOrderedSame) ) {
                result = [NSURL URLWithString:trimmedStr];
            } else {
                // It looks like this is some unsupported URL scheme.
            }
        }
    }
    
    return result;
}



- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)data
// A delegate method called by the NSURLConnection as data arrives.  We just
// write the data to the file.
{
        [self.activeDownload appendData:data];
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error
// A delegate method called by the NSURLConnection if the connection fails.
// We shut down the connection and display the failure.  Production quality code
// would either display or log the actual error.
{
    self.activeDownload = nil;
    self.connection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection
// A delegate method called by the NSURLConnection when the connection has been
// done successfully.  We shut down the connection with a nil status, which
// causes the image to be displayed.
{

    NSError *error;
    json = [NSJSONSerialization
                          JSONObjectWithData:self.activeDownload
                          
                          options:kNilOptions
                          error:&error];
    
   // NSLog(@"json %@",json);
   // [[NSNotificationCenter defaultCenter] postNotificationName:@"Reload" object:nil];
    [delegate reloadData];
    self.dataArray = [json valueForKey:@"posts"];
}



- (void)didStartNetworkOperation
{
    // If you start a network operation off the main thread, you'll have to update this code
    // to ensure that any observers of this property are thread safe.
    assert([NSThread isMainThread]);
    self.networkOperationCount += 1;
}

- (void)didStopNetworkOperation
{
    // If you stop a network operation off the main thread, you'll have to update this code
    // to ensure that any observers of this property are thread safe.
    assert([NSThread isMainThread]);
    assert(self.networkOperationCount > 0);
    self.networkOperationCount -= 1;
}

@end

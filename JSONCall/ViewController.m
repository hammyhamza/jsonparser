//
//  ViewController.m
//  JSONCall
//
//  Created by Hamza Ansari on 10/02/16.
//  Copyright © 2016 Hamza Ansari. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize jsonTextView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)getJSONFromURL:(id)sender{
    
    NSString *URLString = @"http://date.jsontest.com/";
    NSURL *url = [NSURL URLWithString:URLString];

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // Instantiate a session object.
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    // Create a data task object to perform the data downloading.
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error != nil) {
            // If any error occurs then just display its description on the console.
            NSLog(@"%@", [error localizedDescription]);
        }
        else{
            NSError *error;
            NSMutableDictionary *returnedDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
            }else{
                NSLog(@"%@",returnedDict);
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    jsonTextView.text = returnedDict.debugDescription;
                }];

            }

        }
    }];
    
    // Resume the task.
    [task resume];

}


@end

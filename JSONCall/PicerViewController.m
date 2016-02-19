//
//  PicerViewController.m
//  JSONCall
//
//  Created by Hamza Ansari on 19/02/16.
//  Copyright © 2016 Hamza Ansari. All rights reserved.
//

#import "PicerViewController.h"

@interface PicerViewController ()

@end

@implementation PicerViewController
@synthesize cities;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
    NSString *URLString = @"http://fitnapp.in/dummy/splash.php";
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
                    cities = returnedDict[@"data"][@"city"];
                    [[self pickerView] reloadAllComponents];
                }];
                
            }
            
        }
    }];
    
    // Resume the task.
    [task resume];
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return cities.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return cities[row][@"cname"];
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

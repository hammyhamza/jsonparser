//
//  TableViewController.m
//  JSONCall
//
//  Created by Hamza Ansari on 17/02/16.
//  Copyright © 2016 Hamza Ansari. All rights reserved.
//

#import "TableViewController.h"
#import "CategoryTableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController
@synthesize cities;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data from Server

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
                    [[self tableView] reloadData];
                }];
                
            }
            
        }
    }];
    
    // Resume the task.
    [task resume];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return cities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell" forIndexPath:indexPath];
    cell.textLabel.text = cities[indexPath.row][@"cname"];
        
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedRow = indexPath.row;
    [self performSegueWithIdentifier:@"showCategory" sender:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showCategory"]) {
        NSArray *categories = cities[selectedRow][@"category"];
        CategoryTableViewController *destinationVC = (CategoryTableViewController *)[segue destinationViewController];
        destinationVC.categories = categories;
    }
}


@end

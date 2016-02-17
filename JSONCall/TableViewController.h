//
//  TableViewController.h
//  JSONCall
//
//  Created by Hamza Ansari on 17/02/16.
//  Copyright © 2016 Hamza Ansari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController

{
    NSInteger selectedRow;
}

@property(strong,nonatomic) NSArray *cities;

@end

//
//  PicerViewController.h
//  JSONCall
//
//  Created by Hamza Ansari on 19/02/16.
//  Copyright © 2016 Hamza Ansari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicerViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property(strong,nonatomic) NSArray *cities;

@end

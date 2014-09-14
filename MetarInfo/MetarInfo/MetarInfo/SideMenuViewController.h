//
//  SideMenuViewController.h
//  MetarInfo
//
//  Created by Mario Bento on 03/03/14.
//  Copyright (c) 2014 Cinhos.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>{
    UIPickerView *pickerViewFrom;
    UIPickerView *pickerViewTo;
    NSMutableArray *dataArray;

}

@property (nonatomic, retain) UIPickerView *pickerViewFrom;
@property (nonatomic, retain) UIPickerView *pickerViewTo;
@property (nonatomic, retain) NSMutableArray *dataArray;

@end

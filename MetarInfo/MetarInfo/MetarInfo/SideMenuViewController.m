//
//  SideMenuViewController.m
//  MetarInfo
//
//  Created by Mario Bento on 03/03/14.
//  Copyright (c) 2014 Cinhos.com. All rights reserved.
//

#import "SideMenuViewController.h"
#import "Constants.h"

@interface SideMenuViewController ()

@end

@implementation SideMenuViewController

@synthesize pickerViewFrom;
@synthesize pickerViewTo;
@synthesize dataArray;

NSString * ROW1;
NSString * ROW2;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIColor * backColor = [UIColor colorWithRed:12/255.0f green:28/255.0f blue:65/255.0f alpha:1.0f];
    self.view.backgroundColor = backColor;
    
    UIButton * closeBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBTN.frame = CGRectMake(272, 0, 48, 48);
    [closeBTN setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [closeBTN setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateHighlighted];
    [closeBTN addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBTN];
    
    UIButton * goBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    goBTN.frame = CGRectMake(250, 100, 64, 64);
    [goBTN setImage:[UIImage imageNamed:@"Ball-go-64.png"] forState:UIControlStateNormal];
    [goBTN setImage:[UIImage imageNamed:@"Ball-go-64.png"] forState:UIControlStateHighlighted];
    [goBTN addTarget:self action:@selector(goPath) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBTN];

    
    // Init the data array.
    dataArray = [[NSMutableArray alloc] init];
    
    // Add some data for demo purposes.
    [dataArray addObject:@"PICK ONE"];
    [dataArray addObject:@"LPVZ"];
    [dataArray addObject:@"LPSE"];
    [dataArray addObject:@"LPCO"];
    [dataArray addObject:@"LPSO"];
    [dataArray addObject:@"LPCS"];
    [dataArray addObject:@"LPPT"];
    [dataArray addObject:@"LPMT"];
    [dataArray addObject:@"LPPT"];
    [dataArray addObject:@"LPST"];
    
    
    // Init the picker view.
    pickerViewFrom = [[UIPickerView alloc] init];
    [pickerViewFrom setDataSource: self];
    [pickerViewFrom setDelegate: self];
    [pickerViewFrom setFrame: CGRectMake(0, 0, 100, 25)];
    pickerViewFrom.showsSelectionIndicator = YES;
    //  [pickerViewFrom selectRow:2 inComponent:0 animated:YES];
    [self.view addSubview: pickerViewFrom];
    
    
    pickerViewTo = [[UIPickerView alloc] init];
    [pickerViewTo setDataSource: self];
    [pickerViewTo setDelegate: self];
    [pickerViewTo setFrame: CGRectMake(130, 0, 100, 50)];
    pickerViewTo.showsSelectionIndicator = YES;
    //  [pickerViewFrom selectRow:2 inComponent:0 animated:YES];
    [self.view addSubview: pickerViewTo];
    
    ROW1 = @"0";
    ROW2 = @"0";
    
    }


// Number of components.
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// Total rows in our component.
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [dataArray count];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    // Get the text of the row.
    NSString *rowItem = [dataArray objectAtIndex: row];
    
    // Create and init a new UILabel.
    // We must set our label's width equal to our picker's width.
    // We'll give the default height in each row.
    UILabel *lblRow = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView bounds].size.width, 44.0f)];
    
    // Center the text.
    [lblRow setTextAlignment:NSTextAlignmentCenter];
    
    // Make the text color red.
    [lblRow setTextColor: [UIColor whiteColor]];
    
    // Add the text.
    [lblRow setText:rowItem];
    
    // Clear the background color to avoid problems with the display.
    [lblRow setBackgroundColor:[UIColor clearColor]];
    
    // Return the label.
    return lblRow;
}

// Do something with the selected row.
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (pickerView == pickerViewFrom) {
        NSLog(@"FROM HERE: %@", [dataArray objectAtIndex: row]);
        
        ROW1 = [NSString stringWithFormat:@"%d", row];
        NSLog(@"ROW1::: %@", ROW1);
        
    } else if (pickerView == pickerViewTo){
        
        NSLog(@"TO HERE: %@", [dataArray objectAtIndex: row]);
        
        ROW2 = [NSString stringWithFormat:@"%d", row];
        NSLog(@"ROW2::: %@", ROW2);
        
        
    }


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)close{
    [UIView transitionWithView:self.view duration:0.3f options:UIViewAnimationOptionCurveEaseIn animations:^(void) { self.view.frame = CGRectMake (-320, (IS_WIDESCREEN? 400:(400-88)), 320, (IS_WIDESCREEN? 168:168));}
                    completion:^(BOOL finished) {
                        // Do nothing
                    }];
    


}

-(void) goPath{
    
    if ([ROW1 isEqualToString:@"0"]) {
        
        [ILAlertView showWithTitle:@"ALERT"
                           message:@"The departure AD can not be nil"
                  closeButtonTitle:@"OK"
                 secondButtonTitle:nil
                tappedSecondButton:nil];
        
        
    } else if ([ROW2 isEqualToString:@"0"]){
        
        [ILAlertView showWithTitle:@"ALERT"
                           message:@"The arrival AD can not be nil"
                  closeButtonTitle:@"OK"
                 secondButtonTitle:nil
                tappedSecondButton:nil];
        
    }
    
    
    
    
}

@end

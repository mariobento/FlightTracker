//
//  AgendaViewController.m
//  MetarInfo
//
//  Created by Mario Bento on 30/12/13.
//  Copyright (c) 2013 Cinhos.com. All rights reserved.
//

#import "AgendaViewController.h"
#import "Constants.h"

@interface AgendaViewController ()

@end

@implementation AgendaViewController

UITextField *_1;
UITextField *_2;
UITextField *_3;
UITextField *_4;
UITextField *_5;
UITextField *_6;
UITextField *_7;
UITextField *_8;
UITextField *_9;
UITextField *_10;
UITextField *_11;


-(void) viewWillAppear:(BOOL)animated{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *load1 = [defaults objectForKey:@"1save"];
    NSString *load2 = [defaults objectForKey:@"2save"];
    NSString *load3 = [defaults objectForKey:@"3save"];
    NSString *load4 = [defaults objectForKey:@"4save"];
    NSString *load5 = [defaults objectForKey:@"5save"];
    NSString *load6 = [defaults objectForKey:@"6save"];
    NSString *load7 = [defaults objectForKey:@"7save"];
    NSString *load8 = [defaults objectForKey:@"8save"];
    NSString *load9 = [defaults objectForKey:@"9save"];
    NSString *load10 = [defaults objectForKey:@"10save"];
    NSString *load11 = [defaults objectForKey:@"11save"];
    
    
    [_1 setText:load1];
    [_2 setText:load2];
    [_3 setText:load3];
    [_4 setText:load4];
    [_5 setText:load5];
    [_6 setText:load6];
    [_7 setText:load7];
    [_8 setText:load8];
    [_9 setText:load9];
    [_10 setText:load10];
    [_11 setText:load11];


}

-(void) viewWillDisappear:(BOOL)animated{
    
    
    NSString *save1 = _1.text;
    NSString *save2 = _2.text;
    NSString *save3 = _3.text;
    NSString *save4 = _4.text;
    NSString *save5 = _5.text;
    NSString *save6 = _6.text;
    NSString *save7 = _7.text;
    NSString *save8 = _8.text;
    NSString *save9 = _9.text;
    NSString *save10 = _10.text;
    NSString *save11 = _11.text;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:save1 forKey:@"1save"];
    [defaults setObject:save2 forKey:@"2save"];
    [defaults setObject:save3 forKey:@"3save"];
    [defaults setObject:save4 forKey:@"4save"];
    [defaults setObject:save5 forKey:@"5save"];
    [defaults setObject:save6 forKey:@"6save"];
    [defaults setObject:save7 forKey:@"7save"];
    [defaults setObject:save8 forKey:@"8save"];
    [defaults setObject:save9 forKey:@"9save"];
    [defaults setObject:save10 forKey:@"10save"];
    [defaults setObject:save11 forKey:@"11save"];
    [defaults synchronize];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
   
    
    if([[UIScreen mainScreen]bounds].size.height == 568)
    {
        
        UIImageView* bgImageView=[[UIImageView alloc] initWithFrame:CGRectMake(-25, 0, kDeviceWidth, 129)];
        bgImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"GAir_logo_full"]];
        [self.view addSubview:bgImageView];
        
        UIImageView* frame=[[UIImageView alloc] initWithFrame:CGRectMake(10, 180, 600/2, 720/2)];
        frame.backgroundColor =[UIColor lightGrayColor];
        [self.view addSubview:frame];
        
        CALayer * l = [frame layer];
        [l setMasksToBounds:YES];
        [l setCornerRadius:10.0];
    }
    else
    {
        UIImageView* bgImageView=[[UIImageView alloc] initWithFrame:CGRectMake(-25, 0, kDeviceWidth, 129)];
        bgImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"GAir_logo_full"]];
        [self.view addSubview:bgImageView];
        
        UIImageView* frame=[[UIImageView alloc] initWithFrame:CGRectMake(10, 180, 600/2, 277)];
        frame.backgroundColor =[UIColor lightGrayColor];
        [self.view addSubview:frame];
        
        CALayer * l = [frame layer];
        [l setMasksToBounds:YES];
        [l setCornerRadius:10.0];
        
    }
    
    UILabel *contactLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(0, 0, 285, 40) ];
    contactLabel.textAlignment =  NSTextAlignmentLeft;
    contactLabel.textColor = [UIColor whiteColor];
    contactLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(16)];
    contactLabel.text = [NSString stringWithFormat: @"Portugal Ops Tel: +351 214 457 500"];
    contactLabel.center = CGPointMake(self.view.frame.size.width/2, 160);
    contactLabel.userInteractionEnabled = YES;
    [self.view addSubview:contactLabel];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap)];
    [contactLabel addGestureRecognizer:tapGesture];
    
    /////////Container
    
    //Container size (10, 180, 600/2, 720/2)
    CGRect frame = CGRectMake(10, 180, 600/2, (IS_WIDESCREEN?360:280));
    UIView *container = [[UIView alloc] initWithFrame:frame];
    [container setBackgroundColor:[UIColor darkGrayColor]];
    [self.view addSubview:container];
    
   
    
    CALayer * l = [container layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:10.0];

    _1 = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    _1.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    _1.backgroundColor=[UIColor lightGrayColor];
    _1.delegate = self;
    _1.keyboardType = UIKeyboardTypeDefault;
    [container addSubview:_1];
    
    _2 = [[UITextField alloc] initWithFrame:CGRectMake(0, 31, 300, 30)];
    _2.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    _2.backgroundColor=[UIColor lightGrayColor];
    _2.delegate = self;
    _2.keyboardType = UIKeyboardTypeDefault;
    [container addSubview:_2];
    
    _3 = [[UITextField alloc] initWithFrame:CGRectMake(0, 62, 300, 30)];
    _3.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    _3.backgroundColor=[UIColor lightGrayColor];
    _3.delegate = self;
    _3.keyboardType = UIKeyboardTypeDefault;
    [container addSubview:_3];
    
    _4 = [[UITextField alloc] initWithFrame:CGRectMake(0, 93, 300, 30)];
    _4.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    _4.backgroundColor=[UIColor lightGrayColor];
    _4.delegate = self;
    _4.keyboardType = UIKeyboardTypeDefault;
    [container addSubview:_4];
    
    _5 = [[UITextField alloc] initWithFrame:CGRectMake(0, 124, 300, 30)];
    _5.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    _5.backgroundColor=[UIColor lightGrayColor];
    _5.delegate = self;
    _5.keyboardType = UIKeyboardTypeDefault;
    [container addSubview:_5];

    _6 = [[UITextField alloc] initWithFrame:CGRectMake(0, 155, 300, 30)];
    _6.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    _6.backgroundColor=[UIColor lightGrayColor];
    _6.delegate = self;
    _6.keyboardType = UIKeyboardTypeDefault;
    [container addSubview:_6];
    
    _7 = [[UITextField alloc] initWithFrame:CGRectMake(0, 186, 300, 30)];
    _7.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    _7.backgroundColor=[UIColor lightGrayColor];
    _7.delegate = self;
    _7.keyboardType = UIKeyboardTypeDefault;
    [container addSubview:_7];
    
    _8 = [[UITextField alloc] initWithFrame:CGRectMake(0, 217, 300, 30)];
    _8.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    _8.backgroundColor=[UIColor lightGrayColor];
    _8.delegate = self;
    _8.keyboardType = UIKeyboardTypeDefault;
    [container addSubview:_8];
    
    _9 = [[UITextField alloc] initWithFrame:CGRectMake(0, 248, 300, 30)];
    _9.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    _9.backgroundColor=[UIColor lightGrayColor];
    _9.delegate = self;
    _9.keyboardType = UIKeyboardTypeDefault;
    [container addSubview:_9];

    _10 = [[UITextField alloc] initWithFrame:CGRectMake(0, 279, 300, 30)];
    _10.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    _10.backgroundColor=[UIColor lightGrayColor];
    _10.delegate = self;
    _10.keyboardType = UIKeyboardTypeDefault;
    [container addSubview:_10];
    
    _11 = [[UITextField alloc] initWithFrame:CGRectMake(0, 310, 300, 30)];
    _11.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    _11.backgroundColor=[UIColor lightGrayColor];
    _11.delegate = self;
    _11.keyboardType = UIKeyboardTypeDefault;
    [container addSubview:_11];
    
    UITextField *_12 = [[UITextField alloc] initWithFrame:CGRectMake(0, 341, 300, 30)];
    _12.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    _12.backgroundColor=[UIColor lightGrayColor];
    _12.delegate = self;
    _12.keyboardType = UIKeyboardTypeDefault;
     _12.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    [_12 setText:@" EX.CS-DDO 151430Z LPCSLPST"];
    [_12 setEnabled:NO];
    [container addSubview:_12];
    
    ////////Container
    
    
    //BTN BACK
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(272, (IS_WIDESCREEN? (432+88):432), 48, 48);
    [button setImage:[UIImage imageNamed:kBackToImageN] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:kBackToImageH] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(backToWork) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

/*- (void)loadView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 460.0) style:UITableViewStylePlain];
    self.tableView = tableView;
    
    [self.view addSubview:tableView];
    
    self.tableView.dataSource = self;
} */


-(void) backToWork{
    
    //[self.view removeFromSuperview];
    
    [UIView animateWithDuration:0.4
                     animations:^{self.view.alpha = 0.0;}
                     completion:^(BOOL finished){ [self.view removeFromSuperview]; }];
    
}

-(void) labelTap{
    
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] ) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://+351214457500"]]];
    } else {
        UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"ALERT" message:@"Your device doesn't support phone calls." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Notpermitted show];
    }
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {

     [self animateTextField: textField up: NO];
    
    NSLog(@"======%@===", textField.text);

}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 170; // tweak as needed
    const float movementDuration = 0.2f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
	[textField resignFirstResponder];
    
	return YES;
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 26) ? NO : YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

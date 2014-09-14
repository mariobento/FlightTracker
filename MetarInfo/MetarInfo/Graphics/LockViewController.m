//
//  LockViewController.m
//  MetarInfo
//
//  Created by Mario Bento on 23/01/14.
//  Copyright (c) 2014 Cinhos.com. All rights reserved.
//

#import "LockViewController.h"
#import "Constants.h"


@interface LockViewController ()

@end

@implementation LockViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if([[UIScreen mainScreen]bounds].size.height == 568)
    {
        
     /*   UIImageView* bgImageView=[[UIImageView alloc] initWithFrame:CGRectMake(-25, 0, kDeviceWidth, 129)];
        bgImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"GAir_logo_full"]];
        [self.view addSubview:bgImageView];
        
        UIImageView* frame=[[UIImageView alloc] initWithFrame:CGRectMake(10, 180, 600/2, 720/2)];
        frame.backgroundColor =[UIColor lightGrayColor];
        [self.view addSubview:frame];
        
        CALayer * l = [frame layer];
        [l setMasksToBounds:YES];
        [l setCornerRadius:10.0]; */
    }
    else
    {
      /*  UIImageView* bgImageView=[[UIImageView alloc] initWithFrame:CGRectMake(-25, 0, kDeviceWidth, 129)];
        bgImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"GAir_logo_full"]];
        [self.view addSubview:bgImageView];
        
        UIImageView* frame=[[UIImageView alloc] initWithFrame:CGRectMake(10, 180, 600/2, 580/2)];
        frame.backgroundColor =[UIColor lightGrayColor];
        [self.view addSubview:frame];
        
        
        CALayer * l = [frame layer];
        [l setMasksToBounds:YES];
        [l setCornerRadius:10.0]; */
        
    }
    
    
    /*UILabel *contactLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(0, 0, 285, 40) ];
    contactLabel.textAlignment =  NSTextAlignmentLeft;
    contactLabel.textColor = [UIColor whiteColor];
    contactLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(16)];
    contactLabel.text = [NSString stringWithFormat: @"Portugal Ops Tel: +351 214 457 500"];
    contactLabel.center = CGPointMake(self.view.frame.size.width/2, 160);
    contactLabel.userInteractionEnabled = YES;
    [self.view addSubview:contactLabel]; */
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bkg.png"]];
    
    
    UIColor* mainColor = [UIColor colorWithRed:40.0/255 green:148.0/255 blue:248.0/255 alpha:1.0f];
    UIColor* darkColor = [UIColor colorWithRed:10.0/255 green:78.0/255 blue:108.0/255 alpha:1.0f];
    
    CGRect frame = CGRectMake(0, 0, 300, 250);
    UIView *container = [[UIView alloc] initWithFrame:frame];
    [container setBackgroundColor:mainColor];
    [container setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2+100)];
    [self.view addSubview:container];
    
    CALayer * l = [container layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:10.0];
    
    UILabel *good = [ [UILabel alloc ] initWithFrame:CGRectMake(0, 0, 300, 40) ];
    good.textAlignment =  NSTextAlignmentCenter;
    good.textColor = [UIColor whiteColor];
    good.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:(20)];
    good.text = [NSString stringWithFormat: @"GOOD TO SEE YOU"];
    good.userInteractionEnabled = NO;
    [container addSubview:good];
    
    UILabel *welcome = [ [UILabel alloc ] initWithFrame:CGRectMake(0, 25, 300, 40) ];
    welcome.textAlignment =  NSTextAlignmentCenter;
    welcome.textColor = [UIColor whiteColor];
    welcome.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:(10)];
    welcome.text = [NSString stringWithFormat: @"Welcome back Captain, please login below"];
    welcome.userInteractionEnabled = YES;
    [container addSubview:welcome];
    
    
    UITextField * user = [[UITextField alloc] initWithFrame:CGRectMake(container.frame.size.width/2-75, 60, 150, 30)];
    user.backgroundColor = [UIColor whiteColor];
    user.layer.cornerRadius = 3;
    user.placeholder = @"Username";
    user.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:16];
    user.delegate = self;
    user.keyboardType = UIKeyboardTypeDefault;
    [container addSubview:user];
    
    UITextField * pass = [[UITextField alloc] initWithFrame:CGRectMake(container.frame.size.width/2-75, 95, 150, 30)];
    pass.backgroundColor = [UIColor whiteColor];
    pass.layer.cornerRadius = 3;
    pass.placeholder = @"Password";
    pass.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:16];
    pass.delegate = self;
    pass.keyboardType = UIKeyboardTypeDefault;
    pass.secureTextEntry = YES;
    [container addSubview:pass];
    
    UIButton * logBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logBtn.frame = CGRectMake(container.frame.size.width/2-75, 150, 150, 50);
    logBtn.backgroundColor = darkColor;
    logBtn.layer.cornerRadius = 3;
    [logBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logBtn.titleLabel.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:18];
    [logBtn setTitle:@"LOGIN HERE" forState:UIControlStateNormal];
    [logBtn addTarget:self action:@selector(LOGIN) forControlEvents:UIControlEventTouchUpInside];
    [logBtn setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
    [container addSubview:logBtn];
    
    
    UIButton * get = [UIButton buttonWithType:UIButtonTypeCustom];
    get.frame = CGRectMake(0, 0, 70, 20);
    get.backgroundColor = [UIColor clearColor];
    get.layer.cornerRadius = 3;
    [get setTitleColor:darkColor forState:UIControlStateNormal];
    get.titleLabel.font = [UIFont fontWithName:@"Optima-ExtraBlack" size:10];
    [get setTitle:@"GET ACCESS" forState:UIControlStateNormal];
    [get setCenter:CGPointMake(container.frame.size.width/2, container.frame.size.height/2+110)];
    [get addTarget:self action:@selector(GET) forControlEvents:UIControlEventTouchUpInside];
    [get setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
    [container addSubview:get];

    

   /* UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap)];
    [contactLabel addGestureRecognizer:tapGesture];
    
    
    
    
    CGRect frame = CGRectMake(10, 180, 600/2, 720/2);
    UIView *container = [[UIView alloc] initWithFrame:frame];
    //[container setBackgroundColor:[UIColor darkGrayColor]];
    [self.view addSubview:container];
    
    CALayer * l = [container layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:10.0];
    */
    
    
    //BTN BACK
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(272, (IS_WIDESCREEN? (432+88):432), 48, 48);
    [button setImage:[UIImage imageNamed:kBackToImageN] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:kBackToImageH] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(backToMap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    
    
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



-(void) backToMap{
    
    [UIView animateWithDuration:0.4
                     animations:^{self.view.alpha = 0.0;}
                     completion:^(BOOL finished){ [self.view removeFromSuperview]; }];
}


-(void)LOGIN{}
-(void)GET{}


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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

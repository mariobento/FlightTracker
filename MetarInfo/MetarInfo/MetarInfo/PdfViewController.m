//
//  PdfViewController.m
//  MetarInfo
//
//  Created by Mario Bento on 19/12/13.
//  Copyright (c) 2013 Cinhos.com. All rights reserved.
//

#import "PdfViewController.h"
#import "Constants.h"

@interface PdfViewController ()

@end

@implementation PdfViewController

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
        
        UIImageView* frame=[[UIImageView alloc] initWithFrame:CGRectMake(10, 180, 600/2, 580/2)];
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
    contactLabel.text = [NSString stringWithFormat: @"Base Portugal Tel: +351 214 457 500"];
    contactLabel.center = CGPointMake(self.view.frame.size.width/2, 160);
    contactLabel.userInteractionEnabled = YES;
    [self.view addSubview:contactLabel];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CASCAIS" ofType:@"pdf"];
    NSURL *targetURL = [NSURL fileURLWithPath:path];
   // NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, (IS_WIDESCREEN? 568:480))];
    web.delegate = self;
    [web loadRequest:[NSURLRequest requestWithURL:targetURL]];
    [web setScalesPageToFit:YES];
    [self.view addSubview:web];

    //BTN BACK
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(272, (IS_WIDESCREEN? (432+88):432), 48, 48);
    [button setImage:[UIImage imageNamed:kBackToImageN] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:kBackToImageH] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(backToWork) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];


}

-(void) backToWork{
    
    //[self.view removeFromSuperview];
    
    [UIView animateWithDuration:0.4
                     animations:^{self.view.alpha = 0.0;}
                     completion:^(BOOL finished){ [self.view removeFromSuperview]; }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  PlaneViewController.m
//  MetarInfo
//
//  Created by Mario Bento on 19/12/13.
//  Copyright (c) 2013 Cinhos.com. All rights reserved.
//

#import "PlaneViewController.h"
#import "Constants.h"

@interface PlaneViewController ()

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) UIWebView *web;

@end

@implementation PlaneViewController


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
    contactLabel.text = [NSString stringWithFormat: @"Portugal Ops Tel: +351 214 457 500"];
    contactLabel.center = CGPointMake(self.view.frame.size.width/2-10, 160);
    contactLabel.userInteractionEnabled = YES;
    [self.view addSubview:contactLabel];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap)];
    [contactLabel addGestureRecognizer:tapGesture];
    
  //  NSString * gair = [NSString stringWithFormat:@"http://www.mariobento.wix.com/gair"];
  //  NSURL * gairg = [NSURL URLWithString:gair];
    
    NSString * gair = @"https://www.google.com/fusiontables/embedviz?viz=GVIZ&t=TABLE&q=select+col0%2C+col1%2C+col2%2C+col3+from+1NyaCTq8FdhQx4MdOL4jZwczNHVLihx0ns1G-qog&containerId=googft-gviz-canvas";
    
     NSURL * gairg = [NSURL URLWithString:gair];
    
    http://www.ustream.tv/embed/12619575?v=3&wmode=direct
    
    _web = [[UIWebView alloc] initWithFrame:CGRectMake(10, 180, 600/2, (IS_WIDESCREEN?720/2:300))];
    _web.delegate = self;
    [_web loadRequest:[NSURLRequest requestWithURL:gairg]];
    [_web setScalesPageToFit:YES];
    [self.view addSubview:_web];
    
    CALayer * l = [_web layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:10.0];
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-50, 340, 100,100)];
    [_activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [_activityIndicator setHidesWhenStopped:YES];
    [self.view addSubview:_activityIndicator];


    //BTN REFRESH
    UIButton *refresh = [UIButton buttonWithType:UIButtonTypeCustom];
    refresh.frame = CGRectMake(265, 130, 64, 64);
    [refresh setImage:[UIImage imageNamed:@"refresh_32.png"] forState:UIControlStateNormal];
    [refresh setImage:[UIImage imageNamed:@"refresh_32.png"] forState:UIControlStateHighlighted];
    [refresh addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refresh];

    
    
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

-(void) labelTap{
    
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] ) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://+351214457500"]]];
    } else {
        UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"ALERT" message:@"Your device doesn't support phone calls." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Notpermitted show];
    }
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    [_activityIndicator startAnimating];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [_activityIndicator stopAnimating];
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [_activityIndicator startAnimating];
    
}

-(void) refresh{
    
    NSString * gair = @"https://www.google.com/fusiontables/embedviz?viz=GVIZ&t=TABLE&q=select+col0%2C+col1%2C+col2%2C+col3+from+1NyaCTq8FdhQx4MdOL4jZwczNHVLihx0ns1G-qog&containerId=googft-gviz-canvas";
    NSURL * gairg = [NSURL URLWithString:gair];
    [_web loadRequest:[NSURLRequest requestWithURL:gairg]];
    [_web reload];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

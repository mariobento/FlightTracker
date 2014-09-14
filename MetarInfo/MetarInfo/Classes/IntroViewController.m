//
//  IntroViewController.m
//  MetarInfo
//
//  Created by Mario Bento on 20/11/13.
//  Copyright (c) 2013 Cinhos.com. All rights reserved.
//

#import "IntroViewController.h"
#import "AppDelegate.h"
#import "Constants.h"


@implementation IntroViewController

NSTimer * timerNet;

- (void)viewDidLoad
{
[super viewDidLoad];
    

    //self.view.backgroundColor= [UIColor greenColor];
    
    //[self.view setBackgroundColor:[UIColor blackColor]];
    
    NSLog(@"Current identifier: %@", [[NSBundle mainBundle] bundleIdentifier]);
    
    
    
    if ([[UIScreen mainScreen]bounds].size.height == 568) {
        
        UIImageView* black=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 568)];
        black.backgroundColor = [UIColor blackColor];
        //black.center = CGPointMake(self.view.bounds.size.width/2-25, self.view.bounds.size.height/2);
        [self.view addSubview:black];

        
        
        UIImageView* bgImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 129)];
        bgImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"GAir_logo_full"]];
        bgImageView.center = CGPointMake(self.view.bounds.size.width/2-25, self.view.bounds.size.height/2);
        [self.view addSubview:bgImageView];

        
    } else if ([[UIScreen mainScreen]bounds].size.height == 480) {
        
        UIImageView* black=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 480)];
        black.backgroundColor = [UIColor blackColor];
       //black.center = CGPointMake(self.view.bounds.size.width/2-25, self.view.bounds.size.height/2);
        [self.view addSubview:black];
        
        
        UIImageView* bgImageView2=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 129)];
        bgImageView2.image = [UIImage imageNamed:[NSString stringWithFormat:@"GAir_logo_full"]];
        bgImageView2.center = CGPointMake(self.view.bounds.size.width/2-25, self.view.bounds.size.height/2);
        [self.view addSubview:bgImageView2];

      
        
    }
	
	//set intro timer
	//[NSTimer scheduledTimerWithTimeInterval:kTimeIntro target:self selector:@selector(isNetworkAvailable) userInfo:nil repeats:NO];
    
    
    timerNet = [NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(isNetworkAvailable) userInfo:nil repeats:YES];
    
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

-(BOOL)isNetworkAvailable
{
    char *hostname;
    struct hostent *hostinfo;
    hostname = "google.com";
    hostinfo = gethostbyname (hostname);
    if (hostinfo == NULL){
        NSLog(@" -> NO CONNECTION \n");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"MeteoInfo" message:@"Connection failed: Please quit your app, check your network or WiFi connections and try again!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //[alert show];
        
        UILabel *quitLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(0, (IS_WIDESCREEN?self.view.bounds.size.height/2+50:self.view.bounds.size.height/2+85), 320, 30) ];
        quitLabel.textAlignment =  NSTextAlignmentCenter;
        quitLabel.textColor = [UIColor whiteColor];
        quitLabel.backgroundColor = [UIColor clearColor];
        quitLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(12)];
        quitLabel.lineBreakMode = NSLineBreakByWordWrapping;
        quitLabel.numberOfLines = 2;
        [self.view addSubview:quitLabel];
        quitLabel.text = [NSString stringWithFormat: @"Please, enable your network connection!"];
        
        
        //TESTE EM OFF
        [self IntroTimer_End];
        
        return NO;
    }
    else{
        
        
        NSLog(@" -> CONNECTION ESTABLISHED! \n");
        
        
        [timerNet invalidate];
        timerNet = nil;
        
        [self IntroTimer_End];
        return YES;
    }
}

-(void) refresh{
    [self isNetworkAvailable];
    
    

}


-(void)IntroTimer_End
{
	//NSLog(@"IntroTimer_End");
	[(AppDelegate *)[[UIApplication sharedApplication] delegate] GoToWorkArea];
	
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
        //exit(0);
        
    }
}

@end

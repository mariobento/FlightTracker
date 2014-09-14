//
//  DetailViewController.m
//  MetarInfo
//
//  Created by Mario Bento on 22/11/13.
//  Copyright (c) 2013 Cinhos.com. All rights reserved.
//

#import "DetailViewController.h"
#import "Constants.h"
#import "Social/Social.h"

@interface DetailViewController ()

@property (nonatomic, strong) UILabel *metarLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) NSString *string;

@property (nonatomic, strong) NSString*TEST;
@property (nonatomic, strong) NSString * result;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) UIWebView *web;


@end

@implementation DetailViewController{}



@synthesize ICAO;


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
    contactLabel.center = CGPointMake(self.view.frame.size.width/2, 160);
    contactLabel.userInteractionEnabled = YES;
    [self.view addSubview:contactLabel];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap)];
    [contactLabel addGestureRecognizer:tapGesture];

    
    
   // NSString *html = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:nil];
    
    
    //PARSE
    // http://rss.aviatorjoe.net/2/%@.rss
    _string = [NSString stringWithFormat:@"http://aviationweather.gov/adds/metars/?station_ids=%@&std_trans=translated&chk_metars=on&hoursStr=most+recent+only&submitmet=Submit", ICAO];
    NSURL *urlRequest = [NSURL URLWithString:_string];
    
    _web = [[UIWebView alloc] initWithFrame:CGRectMake(10, 180, 600/2, 720/2)];
    _web.delegate = self;
    [_web loadRequest:[NSURLRequest requestWithURL:urlRequest]];
    
    [self.view addSubview:_web];
    
    CALayer * l = [_web layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:10.0];
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-50, 340, 100,100)];
    [_activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [_activityIndicator setHidesWhenStopped:YES];
    [self.view addSubview:_activityIndicator];

    
    //BTN BACK
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(272, (IS_WIDESCREEN? (432+88):432), 48, 48);
    [button setImage:[UIImage imageNamed:kBackToImageN] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:kBackToImageH] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(backToMap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //BTN facebook
    UIButton *buttonFB = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonFB.frame = CGRectMake(222, (IS_WIDESCREEN? (435+88):435), 48, 48);
    [buttonFB setImage:[UIImage imageNamed:@"Facebook-48.png"] forState:UIControlStateNormal];
    [buttonFB setImage:[UIImage imageNamed:@"Facebook-48.png"] forState:UIControlStateHighlighted];
    [buttonFB addTarget:self action:@selector(shareFacebook) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonFB];
    
    //BTN twitter
    UIButton *buttonTW = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonTW.frame = CGRectMake(172, (IS_WIDESCREEN? (435+88):435), 48, 48);
    [buttonTW setImage:[UIImage imageNamed:@"Twitter-48.png"] forState:UIControlStateNormal];
    [buttonTW setImage:[UIImage imageNamed:@"Twitter-48.png"] forState:UIControlStateHighlighted];
    [buttonTW addTarget:self action:@selector(shareTwitter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonTW];
    
    UILabel *icaoLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(0, 0, 40, 15) ];
    icaoLabel.textAlignment =  NSTextAlignmentCenter;
    icaoLabel.textColor = [UIColor redColor];
    icaoLabel.backgroundColor = [UIColor greenColor];
    icaoLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(12)];
    //[self.view addSubview:icaoLabel];
    icaoLabel.text = [NSString stringWithFormat: @"%@", ICAO];
    
    
    
  //  NSLog(@"%@",html);
    
 /*  // Determine "<description>" location
    NSRange divRange = [html rangeOfString:@"<item>" options:NSCaseInsensitiveSearch];
    if (divRange.location != NSNotFound)
    {
        // Determine "</description>" location according to "<description>" location
        NSRange endDivRange;
        
        endDivRange.location = divRange.length + divRange.location;
        endDivRange.length   = [html length] - endDivRange.location;
        endDivRange = [html rangeOfString:@"</item>" options:0 range:endDivRange];
        
        
        if (endDivRange.location != NSNotFound)
        {
            // Tags found: retrieve string between them
            divRange.location += divRange.length;
            divRange.length = endDivRange.location - divRange.location;
            
            TEST = [html substringWithRange:divRange];
          // NSLog(@"%@",TEST);
            
        }
    }
    
    NSString *html2 = [NSString stringWithString:TEST];
    
    // Determine "<description>" location
    NSRange divRange2 = [html2 rangeOfString:@"<description>" options:NSCaseInsensitiveSearch];
    if (divRange2.location != NSNotFound)
    {
        // Determine "</description>" location according to "<description>" location
        NSRange endDivRange2;
        
        endDivRange2.location = divRange2.length + divRange2.location;
        endDivRange2.length   = [html2 length] - endDivRange2.location;
        endDivRange2 = [html2 rangeOfString:@"</description>" options:0 range:endDivRange2];
        
        
        if (endDivRange2.location != NSNotFound)
        {
            // Tags found: retrieve string between them
            divRange2.location += divRange2.length;
            divRange2.length = endDivRange2.location - divRange2.location;
            
            TEST = [html2 substringWithRange:divRange2];
            NSLog(@"%@",TEST);
            
        }
    }
    
    NSString *stringWithoutSpaces = [TEST stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"]; */
    
  /*  metarLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 558)];
    metarLabel.backgroundColor = [UIColor lightGrayColor];
    metarLabel.textAlignment = NSTextAlignmentNatural;
    metarLabel.textColor=[UIColor blackColor];
    metarLabel.numberOfLines=20;
    //metarLabel.lineBreakMode=NSLineBreakByWordWrapping;
    [metarLabel setFont:[UIFont fontWithName:@"AmericanTypewriter-Bold" size:8]];
    metarLabel.text = ;
    [self.view addSubview:metarLabel]; */
    
   
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

-(void)shareFacebook{

    if(isIOS6capable())
	{
        
        //UIImage *image = [(ClownBoothAppDelegate *)[[UIApplication sharedApplication] delegate] imageCreated];
        
        SLComposeViewController *fbController=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            SLComposeViewControllerCompletionHandler __block completionHandler=^(SLComposeViewControllerResult result){
                
                [fbController dismissViewControllerAnimated:YES completion:nil];
                
                switch(result){
                    case SLComposeViewControllerResultCancelled:
                    default:
                    {
                        //                        DLog(@"Cancelled.....");
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error uploading to Facebook" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil]; //@"Error uploading to Facebook"
                        [alert show];
                        
                    }
                        break;
                    case SLComposeViewControllerResultDone:
                    {
                        //                        DLog(@"Posted....");
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook upload successful" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil]; //@"Facebook upload successful"
                        [alert show];
                        
                    }
                        break;
                }};
            
            
            NSString* str = [NSString stringWithFormat:@"Check out the Metar for %@: %@ /GAir", ICAO, _string];
            [fbController setInitialText:str];
            [fbController setCompletionHandler:completionHandler];
            [self presentViewController:fbController animated:YES completion:nil];
        } else {
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Facebook not configured on this device." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
            
        }
        
        
        
	} else {
		
		UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Unavailable in this iOS version." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alertView show];
		
	}


}
-(void)shareTwitter{

    if(isIOS6capable())
	{
        
        
        SLComposeViewController *twitter = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        NSString* str = [NSString stringWithFormat:@"Check out the Metar for %@: %@ /GAir", ICAO, _string];
        [twitter setInitialText:str];

        
        [self presentViewController:twitter animated:YES completion:nil];
        
        twitter.completionHandler = ^(SLComposeViewControllerResult res) {
            
            if(res == SLComposeViewControllerResultDone)
            {
                
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Your tweet was posted succesfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [alertView show];
                
                
            }else if(res == SLComposeViewControllerResultCancelled)
            {
                
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Your tweet was not posted." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [alertView show];
                
            }
            
            [twitter dismissViewControllerAnimated:YES completion:nil];
            
        };
        
        
        
        
	} else {
		
		UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Unavailable in this iOS version." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alertView show];
		
	}
    
    
    
	


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
@end

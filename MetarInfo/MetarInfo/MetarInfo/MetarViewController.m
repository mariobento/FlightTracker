//
//  ViewController.m
//  MetarInfo
//
//  Created by Mario Bento on 20/11/13.
//  Copyright (c) 2013 Cinhos.com. All rights reserved.
//

#import "MetarViewController.h"
#import "IntroViewController.h"

@implementation MetarViewController

@synthesize introViewController, workAreaViewController;

- (void)viewDidLoad
{
    introViewController = [[IntroViewController alloc] init];
	[self.view addSubview:introViewController.view];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

-(void)GoToWorkArea
{
	//NSLog(@"MetarViewController GoToWorkArea");
    
    
	workAreaViewController = [[WorkAreaViewController alloc] init];
	[workAreaViewController.view setAlpha:0.0];
    
	[UIView beginAnimations:@"Intro" context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.4];
	[UIView setAnimationRepeatCount:1];
	[UIView setAnimationRepeatAutoreverses:NO];
	[UIView setAnimationDidStopSelector:@selector(IntroFadeOut_end)];
	
    
	[workAreaViewController.view setAlpha:1.0];
	
	[self.view addSubview:workAreaViewController.view];
	
	
	[UIView commitAnimations];
    
	
}

-(void)IntroFadeOut_end
{
	//NSLog(@"IntroFadeOut_end");
	[introViewController.view setAlpha:0.0];
}



@end

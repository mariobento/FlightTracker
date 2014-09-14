//
//  LocationViewController.m
//  MetarInfo
//
//  Created by Mario Bento on 09/01/14.
//  Copyright (c) 2014 Cinhos.com. All rights reserved.
//

#import "LocationViewController.h"
#import "Constants.h"
#import "Social/Social.h"
#import "GADBannerView.h"
#import "GADRequest.h"
#import "appID.h"
#import "SideMenuViewController.h"

@interface LocationViewController ()

-(void)makePolyline;

@end

@implementation LocationViewController



SideMenuViewController *sideMenuViewController;

@synthesize bannerView = bannerView_;
@synthesize bannerViewTop = bannerViewTop_;
@synthesize mapView_, locationManager;




static BOOL haveAlreadyReceivedCoordinates = NO;

CLLocation* location;
GMSMarker *pointMarker;

NSString * currentSpeed;
NSString * currentAlt;
NSString * currentMHdg;
NSString * currentTHdg;

UILabel * altLabel;
UILabel * speedLabel;
UILabel * mhdgLabel;
UILabel * thdgLabel;

UIView * startView;
UIView * containerView;
UIView * shareContainer;

UIButton *stopBTN;

UIButton *button;

NSTimer * timerCamera;

UIImage *screenShotImg;

UIButton *button2;

GMSPolyline *polyline;
GMSMutablePath *path;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // Set a movement threshold for new events.
    locationManager.distanceFilter = 10; // meters
    
    // [locationManager startUpdatingLocation];
    
    
    GMSCameraPosition * _portugal = [GMSCameraPosition cameraWithLatitude:39.55799468673596 longitude:-8.09417724609375 zoom:6.55];
    
    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 0, kDeviceWidth, (IS_WIDESCREEN? (kDeviceHeight+88):kDeviceHeight)) camera:_portugal];
    [self.view addSubview:mapView_];
    mapView_.accessibilityElementsHidden = YES;
    mapView_.delegate = self;
    
    
    
    [self.view addSubview:mapView_];
    mapView_.accessibilityElementsHidden = YES;
    mapView_.delegate = self;
    //mapView_.mapType = kGMSTypeHybrid;
    mapView_.mapType = kGMSTypeTerrain;
    mapView_.myLocationEnabled = NO;
    
    
    //BTN BACK
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(272, (IS_WIDESCREEN? (432+88):432), 48, 48);
    [button setImage:[UIImage imageNamed:kBackToImageN] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:kBackToImageH] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(backToWork) forControlEvents:UIControlEventTouchUpInside];
    // [self.view addSubview:button];
    
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(272, (IS_WIDESCREEN? (432+88):432), 48, 48);
    [button2 setImage:[UIImage imageNamed:kBackToImageN] forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:kBackToImageH] forState:UIControlStateHighlighted];
    [button2 addTarget:self action:@selector(backToWork) forControlEvents:UIControlEventTouchUpInside];
    
    [self enableLocation];
    
    // [locationManager startUpdatingHeading];
    
    timerCamera = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(lockCamera) userInfo:nil repeats:YES];
    
    NSTimer * timerSpeedAlt = [NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(tSpeedAlt) userInfo:nil repeats:YES];
    
    containerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,80)];
    containerView.backgroundColor=[UIColor lightGrayColor];
    //[self.view addSubview:containerView];
    
    
    speedLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(0, 0, 80, 40) ];
    speedLabel.textAlignment =  NSTextAlignmentCenter;
    speedLabel.textColor = [UIColor greenColor];
    speedLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(16)];
    speedLabel.text = [NSString stringWithFormat: @"0 kn"];
    speedLabel.userInteractionEnabled = NO;
    [speedLabel setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5f]];
    [containerView addSubview:speedLabel];
    
    mhdgLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(80, 0, 160, 40) ];
    mhdgLabel.textAlignment =  NSTextAlignmentCenter;
    mhdgLabel.textColor = [UIColor greenColor];
    mhdgLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(16)];
    mhdgLabel.text = [NSString stringWithFormat: @"0 º"];
    mhdgLabel.userInteractionEnabled = NO;
    [mhdgLabel setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5f]];
    [containerView addSubview:mhdgLabel];
    
    thdgLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(160, 0, 80, 40) ];
    thdgLabel.textAlignment =  NSTextAlignmentCenter;
    thdgLabel.textColor = [UIColor greenColor];
    thdgLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(16)];
    thdgLabel.text = [NSString stringWithFormat: @"0 º"];
    thdgLabel.userInteractionEnabled = NO;
    [thdgLabel setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5f]];
    //[mapView_ addSubview:thdgLabel];
    
    altLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(240, 0, 80, 40) ];
    altLabel.textAlignment =  NSTextAlignmentCenter;
    altLabel.textColor = [UIColor greenColor];
    altLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(16)];
    altLabel.text = [NSString stringWithFormat: @"0 ft"];
    altLabel.userInteractionEnabled = NO;
    [altLabel setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5f]];
    [containerView addSubview:altLabel];

    
    ///////////////////////////////
    
    UILabel * s1 = [ [UILabel alloc ] initWithFrame:CGRectMake(0, 40, 80, 10) ];
    s1.textAlignment =  NSTextAlignmentCenter;
    s1.textColor = [UIColor greenColor];
    s1.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(10)];
    s1.text = [NSString stringWithFormat: @"SPD"];
    s1.userInteractionEnabled = NO;
    [s1 setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5f]];
    [containerView addSubview:s1];
    
    UILabel * s2 = [ [UILabel alloc ] initWithFrame:CGRectMake(80, 40, 160, 10) ];
    s2.textAlignment =  NSTextAlignmentCenter;
    s2.textColor = [UIColor greenColor];
    s2.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(10)];
    s2.text = [NSString stringWithFormat: @"MAG. HDG"];
    s2.userInteractionEnabled = NO;
    [s2 setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5f]];
    [containerView addSubview:s2];
    
    UILabel * s3 = [ [UILabel alloc ] initWithFrame:CGRectMake(160, 40, 80, 10) ];
    s3.textAlignment =  NSTextAlignmentCenter;
    s3.textColor = [UIColor greenColor];
    s3.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(10)];
    s3.text = [NSString stringWithFormat: @"TRUE HDG"];
    s3.userInteractionEnabled = NO;
    [s3 setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5f]];
    //[mapView_ addSubview:s3];
    
    UILabel * s4 = [ [UILabel alloc ] initWithFrame:CGRectMake(240, 40, 80, 10) ];
    s4.textAlignment =  NSTextAlignmentCenter;
    s4.textColor = [UIColor greenColor];
    s4.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(10)];
    s4.text = [NSString stringWithFormat: @"ALT"];
    s4.userInteractionEnabled = NO;
    [s4 setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5f]];
    [containerView addSubview:s4];
    
    stopBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    stopBTN.frame = CGRectMake(240, 50, 80, 30);
    [stopBTN setImage:[UIImage imageNamed:@"stopBtn.png"] forState:UIControlStateNormal];
    [stopBTN setImage:[UIImage imageNamed:@"stopBtn.png"] forState:UIControlStateHighlighted];
    [stopBTN addTarget:self action:@selector(stopTap) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:stopBTN];
    
    
    UIButton * sideBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    sideBTN.frame = CGRectMake(0, 35, 128/2, 128/2);
    [sideBTN setImage:[UIImage imageNamed:@"swipeMenu.png"] forState:UIControlStateNormal];
    [sideBTN setImage:[UIImage imageNamed:@"swipeMenu.png"] forState:UIControlStateHighlighted];
    [sideBTN addTarget:self action:@selector(sideMenu) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:sideBTN];
    
    [self.view addSubview:containerView];
    
    startView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,(IS_WIDESCREEN? 568:480))];
    startView.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.85f];
    [self.view addSubview:startView];
    
    //BTN BACK STARTVIEW
    [startView addSubview:button2];
    
    //BTN START
    UIButton *buttonStart = [UIButton buttonWithType:UIButtonTypeCustom];
     buttonStart.frame = CGRectMake(0, 0, 72, 72);
    [buttonStart setImage:[UIImage imageNamed:@"start_128"] forState:UIControlStateNormal];
    [buttonStart setImage:[UIImage imageNamed:@"start_128"] forState:UIControlStateHighlighted];
    [buttonStart setCenter:CGPointMake(startView.frame.size.width/2, startView.frame.size.height/2)];
    [buttonStart addTarget:self action:@selector(startTrack) forControlEvents:UIControlEventTouchUpInside];
    [startView addSubview:buttonStart];
    
    ////////CONTAINER
    shareContainer = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,(IS_WIDESCREEN? 568:480))];
    shareContainer.backgroundColor=[UIColor clearColor];
    
    //BTN facebook
    UIButton *buttonFB = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonFB.frame = CGRectMake(222, (IS_WIDESCREEN? (435+88-32):435-32), 48, 48);
    [buttonFB setImage:[UIImage imageNamed:@"Facebook-48.png"] forState:UIControlStateNormal];
    [buttonFB setImage:[UIImage imageNamed:@"Facebook-48.png"] forState:UIControlStateHighlighted];
    [buttonFB addTarget:self action:@selector(shareFacebook) forControlEvents:UIControlEventTouchUpInside];
    [shareContainer addSubview:buttonFB];
    
    //BTN twitter
    UIButton *buttonTW = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonTW.frame = CGRectMake(172, (IS_WIDESCREEN? (435+88-32):435-32), 48, 48);
    [buttonTW setImage:[UIImage imageNamed:@"Twitter-48.png"] forState:UIControlStateNormal];
    [buttonTW setImage:[UIImage imageNamed:@"Twitter-48.png"] forState:UIControlStateHighlighted];
    [buttonTW addTarget:self action:@selector(shareTwitter) forControlEvents:UIControlEventTouchUpInside];
    [shareContainer addSubview:buttonTW];
    
    UIButton * bBack = [UIButton buttonWithType:UIButtonTypeCustom];
    bBack.frame = CGRectMake(272, (IS_WIDESCREEN? (432+88-30):432-30), 48, 48);
    [bBack setImage:[UIImage imageNamed:kBackToImageN] forState:UIControlStateNormal];
    [bBack setImage:[UIImage imageNamed:kBackToImageH] forState:UIControlStateHighlighted];
    [bBack addTarget:self action:@selector(backToWork) forControlEvents:UIControlEventTouchUpInside];
    [shareContainer addSubview:bBack];
    ///////////////////////////
    
    self.bannerViewTop = [[GADBannerView alloc] initWithFrame:CGRectMake(0, 0, GAD_SIZE_320x50.width, GAD_SIZE_320x50.height)];
    self.bannerViewTop.adUnitID = MyAdUnitID;
    self.bannerViewTop.delegate = self;
    [self.bannerViewTop setRootViewController:self];
    [startView addSubview:self.bannerViewTop];
    [self.bannerViewTop loadRequest:[self createRequest]];
    
    self.bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, (IS_WIDESCREEN?518:(518-88)), GAD_SIZE_320x50.width, GAD_SIZE_320x50.height)];
    self.bannerView.adUnitID = MyAdUnitID;
    self.bannerView.delegate = self;
    [self.bannerView setRootViewController:self];
    [startView addSubview:self.bannerView];
    [self.bannerView loadRequest:[self createRequest]];
    
    sideMenuViewController = [[SideMenuViewController alloc] init];
    sideMenuViewController.view.frame = CGRectMake(-320, (IS_WIDESCREEN? 400:(400-88)), 320, (IS_WIDESCREEN? 168:168));
    [self.view addSubview:sideMenuViewController.view];
    
    UISwipeGestureRecognizer *swipeLeft2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    // Setting the swipe direction.
    [swipeLeft2 setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    // Adding the swipe gesture on the view
    [sideMenuViewController.view addGestureRecognizer:swipeLeft2];
    [containerView addGestureRecognizer:swipeLeft];
    [containerView addGestureRecognizer:swipeRight];
    
    pointMarker = [GMSMarker markerWithPosition:(location.coordinate)];
    //pointMarker.icon = [UIImage imageNamed:@"circle_red.png"];
    pointMarker.groundAnchor = CGPointMake(.5, .5);
    pointMarker.appearAnimation = kGMSMarkerAnimationPop;
    pointMarker.icon = [UIImage imageNamed:@"circle_blue"];
    //pointMarker.map = mapView_;
    
}

-(GADRequest *)createRequest{

    GADRequest * request = [GADRequest request];
    request.testDevices = [NSArray arrayWithObjects:GAD_SIMULATOR_ID, nil];
    return request;

}

-(void) adViewDidReceiveAd:(GADBannerView *)adview{
    
    NSLog(@"Ad Received");
    
    [UIView animateWithDuration:.5 animations:^{
        button2.frame = CGRectMake(272, (IS_WIDESCREEN? (432+88):432)-53, 48, 48);
        
    }];
    
    /*  [UIView animateWithDuration:1.0 animations:^{
     adview.frame = CGRectMake(0, 518, adview.frame.size.width, adview.frame.size.height);
     
     }]; */
    
}

-(void) adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error{

    NSLog(@"Failed to receive ad due to: %@", [error localizedFailureReason]);
}

-(void) startTrack{

    [mapView_ addSubview:self.bannerView];
    
    [locationManager startUpdatingLocation];
    [locationManager startUpdatingHeading];
    
    [UIView animateWithDuration:0.4
                     animations:^{startView.alpha = 0.0;}
                     completion:^(BOOL finished){ [startView removeFromSuperview]; }];
}


- (void)locationManager:(CLLocationManager *)manager /*didUpdateLocations:(NSArray *)locations*/ didUpdateToLocation:(CLLocation*)newLocation
           fromLocation:(CLLocation*) oldLocation{
    // If it's a relatively recent event, turn off updates to save power.
    // location = [locations lastObject];
    location = newLocation;
    NSDate* eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 5.0) {
        
        // NSLog(@"===%f======%f", location.coordinate.latitude, location.coordinate.longitude);
        // Update your marker on your map using location.coordinate.latitude
        //and location.coordinate.longitude);
        
        if(haveAlreadyReceivedCoordinates) {
            return;
        }
        
        
        
        //DEFENIR AQUI O POINTMAKER PARA FAZER A COBRA
        
        pointMarker = [GMSMarker markerWithPosition:(location.coordinate)];
        //pointMarker.icon = [UIImage imageNamed:@"circle_red.png"];
        pointMarker.groundAnchor = CGPointMake(0.5, 0.5);
        pointMarker.appearAnimation = kGMSMarkerAnimationPop;
        pointMarker.icon = [UIImage imageNamed:@"circle_blue.png"];
        pointMarker.map = mapView_;
        
        pointMarker.position = location.coordinate;
        
        path = [GMSMutablePath path];
        [path addLatitude:oldLocation.coordinate.latitude longitude:oldLocation.coordinate.longitude];
        [path addLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
        polyline = [GMSPolyline polylineWithPath:path];
        polyline.strokeWidth = 10.f;
        polyline.geodesic = YES;
        
        int * i;
        // DEFENIR PARA A ALTITUDE COM VARIAS CORES! currentAlt
        i = [currentSpeed intValue];
        
        if (i <= 10) {
            polyline.strokeColor = [UIColor whiteColor];
        } else if (i <= 20) {
            polyline.strokeColor = [UIColor lightGrayColor];
        } else if (i <= 30){
            polyline.strokeColor = [UIColor yellowColor];
        } else if (i <= 40){
            polyline.strokeColor = [UIColor blueColor];
        } else {
        
            polyline.strokeColor = [UIColor redColor];
        
        }
        
        polyline.map = mapView_;
        
        
        NSLog(@"%@", currentSpeed);
        
    }
    
    }


- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
	//NSLog(@"New magnetic heading: %f", newHeading.magneticHeading);
	//NSLog(@"New true heading: %f", newHeading.trueHeading);
    
    currentMHdg = [NSString stringWithFormat: @"%.0f",   newHeading.magneticHeading];
    
    mhdgLabel.text = [NSString stringWithFormat:@"%@º", currentMHdg];
    
    currentTHdg = [NSString stringWithFormat: @"%.0f",   newHeading.trueHeading];
    
    thdgLabel.text = [NSString stringWithFormat:@"%@º", currentTHdg];

}

-(void) enableLocation{

  /*  pointMarker = [GMSMarker markerWithPosition:(location.coordinate)];
    //pointMarker.icon = [UIImage imageNamed:@"circle_red.png"];
    pointMarker.groundAnchor = CGPointMake(0.5, 0.5);
    pointMarker.appearAnimation = kGMSMarkerAnimationPop;
    pointMarker.icon = [UIImage imageNamed:@"circle_red.png"];
    pointMarker.map = mapView_; */
    
    
   /* GMSMutablePath *path = [GMSMutablePath path];
    [path addCoordinate:CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)];
    [path addCoordinate:CLLocationCoordinate2DMake(pointMarker.position.latitude, pointMarker.position.longitude)];
    
    GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
    rectangle.map = mapView_;*/
    
}

-(void) lockCamera{
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude zoom:mapView_.camera.zoom];
    
    [mapView_ animateToCameraPosition:camera];

}

-(void) tSpeedAlt{
    
    if(location.speed > 0) {
       currentSpeed = [NSString stringWithFormat:@"%.1f", (([location speed]*3.6)/1.852)];
        
        speedLabel.text = [NSString stringWithFormat:@"%@ kn", currentSpeed];
    } else{
    
        speedLabel.text = [NSString stringWithFormat: @"0 kn"];
    
    }
    
    currentAlt = [NSString stringWithFormat: @"%.3f",   (location.altitude*3.2808)];
    
    
    altLabel.text = [NSString stringWithFormat:@"%@ ft", currentAlt];
    
    
    //NSLog(@"ALTITUDE EM METROS ==== %@", currentAlt);
}


-(void) backToWork{
    
    //[self.view removeFromSuperview];
    
    [UIView animateWithDuration:0.4 animations:^{self.view.alpha = 0.0;} completion:^(BOOL finished){ [self.view removeFromSuperview];}];
    
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

-(void) stopTap{
    
    [ILAlertView showWithTitle:@"ALERT"
                       message:@"Are you sure you want to exit and stop the tracking?"
              closeButtonTitle:@"No"
             secondButtonTitle:@"Yes"
            tappedSecondButton:^{
                //[self STOP];
                [self performSelector:@selector(STOP) withObject:self afterDelay:1];
            }];
    
}

-(void)STOP{

    [locationManager stopUpdatingLocation];
    [locationManager stopUpdatingHeading];
    
    haveAlreadyReceivedCoordinates = YES;
    
    
    //REMOVE CONTAINER
    [UIView transitionWithView:containerView duration:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^(void) { containerView.frame = CGRectMake (0, -80, 320, 80);}
                    completion:^(BOOL finished) {
                        // Do nothing
                    }];
    //REMOVE BACK BUTTON
    [UIView transitionWithView:button duration:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^(void) { button.frame = CGRectMake (272, 570, 48, 48);}
                    completion:^(BOOL finished) {
                        // Do nothing
                    }];

    [UIView animateWithDuration:0.0
                     animations:^{self.bannerView.alpha = 0.0;}
                     completion:^(BOOL finished){ [self.bannerView removeFromSuperview]; }];

    [UIView transitionWithView:sideMenuViewController.view duration:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^(void) { sideMenuViewController.view.frame = CGRectMake (-320, 400, 320, (IS_WIDESCREEN? 168:80));}
                    completion:^(BOOL finished) {
                        // Do nothing
                    }];
    
    NSLog(@"STOOP");
    
    [self adjustPath];
    
}

-(void) adjustPath{
    
    [timerCamera invalidate];
    timerCamera = nil;
    
    CLLocationCoordinate2D myLocation = (pointMarker.position);
    
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:myLocation coordinate:myLocation];
    
    for (GMSMarker *marker in mapView_.markers){
        bounds = [bounds includingCoordinate:marker.position];
    }
    
    
    [mapView_ animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:15.0f]];
    
    UIImageView* overlayImg=[[UIImageView alloc] initWithFrame:CGRectMake(160, (IS_WIDESCREEN? 538:(538-88)), 160, 30)];
    overlayImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"overlay.png"]];
    [mapView_ addSubview:overlayImg];
    
    
    [self performSelector:@selector(screen) withObject:self afterDelay:2];
    
    
    
}

-(void)screen{
    
    //gerar screenshot
    UIImage* screenshot = [self imageWithView:self.view];
    
    // [self RemoveAllChildren];
    
    shareContainer.backgroundColor = [UIColor colorWithPatternImage:screenshot];;
    
    [self.view addSubview:shareContainer];


}




-(void) screenshot
{
    
    CGRect rect;
    rect=CGRectMake(0, 0, 320, (IS_WIDESCREEN? 568:480));
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    
    screenShotImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    shareContainer.alpha = 0;
    [UIView animateWithDuration: .4 animations: ^{
        shareContainer.alpha = 1.0;
    }];
    
    shareContainer.backgroundColor = [UIColor colorWithPatternImage:screenShotImg];
    
    [self.view addSubview:shareContainer];

    
    //UIImageWriteToSavedPhotosAlbum(screenShotImg, nil, nil, nil);
    
}

- (UIImage *)imageWithView:(UIView *)view{
    
    CGSize imageSize = CGSizeZero;
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        imageSize = [UIScreen mainScreen].bounds.size;
    } else {
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    }
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft) {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        } else if (orientation == UIInterfaceOrientationLandscapeRight) {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        } else {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)sideMenu{


    //[mapView_ addSubview:sideMenuViewController.view];
    
    [UIView transitionWithView:sideMenuViewController.view duration:0.5f options:UIViewAnimationOptionCurveEaseIn animations:^(void) { sideMenuViewController.view.frame = CGRectMake (0, (IS_WIDESCREEN? 400:(400-88)), 320, (IS_WIDESCREEN? 168:168));}
                    completion:^(BOOL finished) {
                        // Do nothing
                    }];
    
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe {
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"Left Swipe");
        
        [UIView transitionWithView:sideMenuViewController.view duration:0.3f options:UIViewAnimationOptionCurveEaseIn animations:^(void) { sideMenuViewController.view.frame = CGRectMake (-320, (IS_WIDESCREEN? 400:(400-88)), 320, (IS_WIDESCREEN? 168:168));}
                        completion:^(BOOL finished) {
                            // Do nothing
                        }];

    }
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"Right Swipe");
        
        [UIView transitionWithView:sideMenuViewController.view duration:0.5f options:UIViewAnimationOptionCurveEaseIn animations:^(void) { sideMenuViewController.view.frame = CGRectMake (0, (IS_WIDESCREEN? 400:(400-88)), 320, (IS_WIDESCREEN? 168:168));}
                        completion:^(BOOL finished) {
                            // Do nothing
                        }];

    }
    
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
                        //                       DLog(@"Cancelled.....");
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error uploading to Facebook" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil]; //@"Error uploading to Facebook"
                        [alert show];
                        
                    }
                        break;
                    case SLComposeViewControllerResultDone:
                    {
                        //                        DLog(@"Posted....");
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook upload successful" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil]; //@"Facebook upload successful"
                        [alert show];
                        
                        [self backToWork];
                        
                    }
                        break;
                }};
            
            
            NSString* str = [NSString stringWithFormat:@"Our flight today by www.GESTAIR.pt"];
            [fbController addImage:screenShotImg];
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
        
        
        NSString* str = [NSString stringWithFormat:@"Our flight today by www.GESTAIR.pt"];
        [twitter setInitialText:str];
        [twitter addImage:screenShotImg];
        
        
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
            
            [self backToWork];
            
        };
        
        
        
        
	} else {
		
		UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Unavailable in this iOS version." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alertView show];
		
	}
    
    
    
	
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  WorkAreaViewController.m
//  MetarInfo
//
//  Created by Mario Bento on 20/11/13.
//  Copyright (c) 2013 Cinhos.com. All rights reserved.
//

#import "WorkAreaViewController.h"
#import "Constants.h"
#import "AppDelegate.h"
#import "MapViewController.h"
#import "PdfViewController.h"
#import "AgendaViewController.h"
#import "LocationViewController.h"
#import "WebcamViewController.h"
#import "LockViewController.h"


@implementation WorkAreaViewController

//@synthesize mapViewController;

LockViewController * lockViewController;
MapViewController *mapViewController;
PlaneViewController * planeViewController;
PdfViewController * pdfViewController;
AgendaViewController * agendaViewController;
LocationViewController * locationViewController;
WebcamViewController * webcamViewController;


UIActionSheet* activityActionSheet;
UIToolbar* controlToolbar;
UIBarButtonItem* spacer;
//UIBarButtonItem* setButton;
UIBarButtonItem* cancelButton;

UIButton *btnNormal;
UIButton *btnSatelite;
UIButton *btnTerreno;
UIButton *btnHibrido;
UIImageView *imgView;

UILabel *timeLabel;
//@synthesize mapStatus;
//@synthesize setType;



- (void)viewDidLoad
{
    [super viewDidLoad];

    
    if([[UIScreen mainScreen]bounds].size.height == 568)
    {
        
        UIImageView* bgImageView=[[UIImageView alloc] initWithFrame:CGRectMake(-25, 0, kDeviceWidth, 129)];
        bgImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"GAir_logo_full"]];
        [self.view addSubview:bgImageView];
        
        UIImageView* frame=[[UIImageView alloc] initWithFrame:CGRectMake(10, 180, 600/2, 720/2)];
        frame.backgroundColor =[UIColor lightGrayColor];
        //frame.image = [UIImage imageNamed:[NSString stringWithFormat:@"backLINE.jpg"] ];
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
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UILabel *contactLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(0, 0, 285, 40) ];
    contactLabel.textAlignment =  NSTextAlignmentLeft;
    contactLabel.textColor = [UIColor whiteColor];
    contactLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(16)];
    contactLabel.text = [NSString stringWithFormat: @"Portugal Ops Tel: +351 214 457 500"];
    contactLabel.center = CGPointMake(self.view.frame.size.width/2, 160);
    contactLabel.userInteractionEnabled = YES;
    [self.view addSubview:contactLabel];
    
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap)];
    [contactLabel addGestureRecognizer:tapGesture];
    
    UILabel *vLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(295, 0, 35, 15) ];
    vLabel.textAlignment =  NSTextAlignmentLeft;
    vLabel.textColor = [UIColor whiteColor];
    //vLabel.backgroundColor = [UIColor whiteColor];
    vLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(8)];
    [self.view addSubview:vLabel];
    vLabel.text = [NSString stringWithFormat: @"v.%@", kVersion];
    
 /*   //BTN BACK
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(267, (IS_WIDESCREEN? (568-44-26):432), 48, 48);
    [button setImage:[UIImage imageNamed:kGoToImageN] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:kGoToImageH] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(GoToMap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button]; */
    
    //INFO
    UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    infoBtn.frame = CGRectMake(292, 10, 48/2, 48/2);
    [infoBtn setImage:[UIImage imageNamed:@"info_blue"] forState:UIControlStateNormal];
    [infoBtn setImage:[UIImage imageNamed:@"info_blue"] forState:UIControlStateHighlighted];
    [infoBtn addTarget:self action:@selector(popInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:infoBtn];
    
    
    //BTN CAL
    UIButton *buttonCall = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonCall.frame = CGRectMake(40, (IS_WIDESCREEN? (110+88):185), 128/1.5, 128/1.5);
    [buttonCall setImage:[UIImage imageNamed:@"gcall_128.png"] forState:UIControlStateNormal];
    [buttonCall setImage:[UIImage imageNamed:@"gcall_128.png"] forState:UIControlStateHighlighted];
    [buttonCall addTarget:self action:@selector(call) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonCall];
    
    
    //BTN PLANES
    UIButton *buttonPlane = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonPlane.frame = CGRectMake(190, (IS_WIDESCREEN? (95+88):170), 124/1.2, 128/1.2);
    [buttonPlane setImage:[UIImage imageNamed:@"gplane_124128"] forState:UIControlStateNormal];
    [buttonPlane setImage:[UIImage imageNamed:@"gplane_124128"] forState:UIControlStateHighlighted];
    [buttonPlane addTarget:self action:@selector(plane) forControlEvents:UIControlEventTouchUpInside];
    buttonPlane.transform = CGAffineTransformMakeRotation(M_PI / 4);
    [self.view addSubview:buttonPlane];
    //M_PI/4 = 45
    
    
    //BTN CLOUD
    UIButton *buttonCloud = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonCloud.frame = CGRectMake(30, (IS_WIDESCREEN? (220+88):260), 128/1.2, 128/1.2);
    [buttonCloud setImage:[UIImage imageNamed:@"gcloud_128"] forState:UIControlStateNormal];
    [buttonCloud setImage:[UIImage imageNamed:@"gcloud_128"] forState:UIControlStateHighlighted];
    [buttonCloud addTarget:self action:@selector(GoToCloud) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonCloud];
   
    
    //BTN PDF
    UIButton *buttonPdf = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonPdf.frame = CGRectMake(180, (IS_WIDESCREEN? (220+88):270), 128/1.2, 128/1.2);
    [buttonPdf setImage:[UIImage imageNamed:@"gpdf_128.png"] forState:UIControlStateNormal];
    [buttonPdf setImage:[UIImage imageNamed:@"gpdf_128.png"] forState:UIControlStateHighlighted];
    [buttonPdf addTarget:self action:@selector(Pdf) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonPdf];
   
    
    
    //BTN SAT
    UIButton *buttonSat = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSat.frame = CGRectMake(30, (IS_WIDESCREEN? (335+88):360), 128/1.2, 128/1.2);
    [buttonSat setImage:[UIImage imageNamed:@"sat_128.png"] forState:UIControlStateNormal];
    [buttonSat setImage:[UIImage imageNamed:@"sat_128.png"] forState:UIControlStateHighlighted];
    [buttonSat addTarget:self action:@selector(sat) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonSat];
    
    //BTN WEBCAM
    UIButton *buttonWebcam = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonWebcam.frame = CGRectMake(180, (IS_WIDESCREEN? (340+88):369), 128/1.2, 128/1.2);
    [buttonWebcam setImage:[UIImage imageNamed:@"webcam_1_128.png"] forState:UIControlStateNormal];
    [buttonWebcam setImage:[UIImage imageNamed:@"webcam_1_128.png"] forState:UIControlStateHighlighted];
    [buttonWebcam addTarget:self action:@selector(webcam) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonWebcam];
    
    timeLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(200, 55, 100, 20) ];
    timeLabel.textAlignment =  NSTextAlignmentCenter;
    timeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:(14)];
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:timeLabel];
    
    //BTN LOCK
    UIButton *lock = [UIButton buttonWithType:UIButtonTypeCustom];
    lock.frame = CGRectMake(150, 55, 32, 32);
    [lock setImage:[UIImage imageNamed:@"lock_32.png"] forState:UIControlStateNormal];
    [lock setImage:[UIImage imageNamed:@"lock_32.png"] forState:UIControlStateHighlighted];
    [lock addTarget:self action:@selector(lock) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lock];
    
   NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval: 0.2 target: self selector: @selector(setDateFormat)userInfo: nil repeats: YES];
    
    //[self setDateFormat];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void) GoToCloud{
    
    mapViewController = [[MapViewController alloc] init];
    
    
    mapViewController.view.alpha = 0;
    [UIView animateWithDuration: .4 animations: ^{
        mapViewController.view.alpha = 1.0;
    }];
[self.view addSubview:mapViewController.view];


}

/**-(void) mapType{

    activityActionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                      delegate:nil
                                             cancelButtonTitle:@""
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:nil];
    
    [activityActionSheet setActionSheetStyle:UIActionSheetStyleBlackOpaque];
    
    
    btnNormal = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnNormal addTarget:self action:@selector(activitySelected:) forControlEvents:UIControlEventTouchDown];
    CGRect frame1 = CGRectMake(0, 40, 160, 40);
    btnNormal.frame = frame1;
    btnNormal.tag = 0;
    [btnNormal setTitle:[NSString stringWithFormat:@"Hibrído"] forState:UIControlStateNormal];
    btnNormal.titleLabel.font = [UIFont systemFontOfSize:20];
    [activityActionSheet addSubview:btnNormal];
    
    
    btnSatelite = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnSatelite addTarget:self action:@selector(activitySelected:)forControlEvents:UIControlEventTouchDown];
    CGRect frame2 = CGRectMake(0, 80, 160, 40);
    btnSatelite.frame = frame2;
    btnSatelite.tag = 1;
    [btnSatelite setTitle:[NSString stringWithFormat:@"Satelite"] forState:UIControlStateNormal];
    btnSatelite.titleLabel.font = [UIFont systemFontOfSize:20];
    [activityActionSheet addSubview:btnSatelite];
    
    btnTerreno = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnTerreno addTarget:self action:@selector(activitySelected:)forControlEvents:UIControlEventTouchDown];
    CGRect frame3 = CGRectMake(0, 120, 160, 40);
    btnTerreno.frame = frame3;
    btnTerreno.tag = 2;
    [btnTerreno setTitle:[NSString stringWithFormat:@"Terreno"] forState:UIControlStateNormal];
    btnTerreno.titleLabel.font = [UIFont systemFontOfSize:20];
    [activityActionSheet addSubview:btnTerreno];
    
    btnHibrido = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnHibrido addTarget:self action:@selector(activitySelected:)forControlEvents:UIControlEventTouchDown];
    CGRect frame4 = CGRectMake(0, 160, 160, 40);
    btnHibrido.frame = frame4;
    btnHibrido.tag = 3;
    [btnHibrido setTitle:[NSString stringWithFormat:@"Normal"] forState:UIControlStateNormal];
    btnHibrido.titleLabel.font = [UIFont systemFontOfSize:20];
    [activityActionSheet addSubview:btnHibrido];
    
    
    CGRect toolbarFrame = CGRectMake(10, 0, 340, 44);
    controlToolbar = [[UIToolbar alloc] initWithFrame:toolbarFrame];
    
    [controlToolbar setBarStyle:UIBarStyleBlack];
    [controlToolbar sizeToFit];
    
    spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                           target:nil
                                                           action:nil];
    
   // setButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Set", nil)
     //                                            style:UIBarButtonItemStyleDone
       //                                         target:self
         //                                       action:@selector(dismissActivityActionSheet)];


    
    cancelButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"OK", nil)
                                                    style:UIBarButtonItemStyleBordered
                                                   target:self
                                                   action:@selector(cancelActivityActionSheet)];
    [controlToolbar setItems:[NSArray arrayWithObjects:spacer, cancelButton, nil]
                    animated:NO];
    [activityActionSheet addSubview:controlToolbar];
    
    [activityActionSheet showInView:self.view];
    [activityActionSheet setBounds:CGRectMake(0, 0, 340, 360)];
    
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(140, 50, 150, 150)];
    imgView.image = [UIImage imageNamed:@"hibrido.png"];
    imgView.contentMode = UIViewContentModeCenter;
    [activityActionSheet addSubview:imgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOut:)];
    tap.cancelsTouchesInView = NO;
    [activityActionSheet.window addGestureRecognizer:tap];

} */

-(void)setDateFormat
{
    NSDate *myDate = [NSDate date];//here it returns current date of device.
    //now set the timeZone and set the Date format to this date as you want.
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    [dateFormatter setTimeZone:timeZone];
    NSString *newDate = [dateFormatter stringFromDate:myDate];
    
    //NSLog(@"%@Z", newDate);
    // here you have new Date with desired format and TimeZone.
    
        timeLabel.text = [NSString stringWithFormat: @"%@ UTC", newDate];
}

-(void) plane{

    planeViewController = [[PlaneViewController alloc] init];
    
    
    planeViewController.view.alpha = 0;
    [UIView animateWithDuration: .4 animations: ^{
        planeViewController.view.alpha = 1.0;
    }];
    [self.view addSubview:planeViewController.view];

    
}
-(void) Pdf{

    pdfViewController = [[PdfViewController alloc] init];
    
    
    pdfViewController.view.alpha = 0;
    [UIView animateWithDuration: .4 animations: ^{
        pdfViewController.view.alpha = 1.0;
    }];
    [self.view addSubview:pdfViewController.view];


}


-(void) call{

    agendaViewController = [[AgendaViewController alloc] init];
    
    
    agendaViewController.view.alpha = 0;
    [UIView animateWithDuration: .4 animations: ^{
        agendaViewController.view.alpha = 1.0;
    }];
    [self.view addSubview:agendaViewController.view];



}

-(void) sat{

    locationViewController = [[LocationViewController alloc] init];
    
    
    locationViewController.view.alpha = 0;
    [UIView animateWithDuration: .4 animations: ^{
        locationViewController.view.alpha = 1.0;
    }];
    [self.view addSubview:locationViewController.view];

}
-(void) webcam{

    
    webcamViewController = [[WebcamViewController alloc] init];
    
    
    webcamViewController.view.alpha = 0;
    [UIView animateWithDuration: .4 animations: ^{
        webcamViewController.view.alpha = 1.0;
    }];
    [self.view addSubview:webcamViewController.view];

}



/*-(void)activitySelected:(UIButton *)button{

    //NSLog(@"Pressed Button: %i", button.tag);
    
   // [button setBackgroundColor:[UIColor yellowColor]];


    
    if (button.tag == 0) {
        
        imgView.image = [UIImage imageNamed:@"hibrido.png"];
        imgView.contentMode = UIViewContentModeCenter;
        [activityActionSheet addSubview:imgView];
        
        
    } else if (button.tag == 1){
        
        imgView.image = [UIImage imageNamed:@"satelite.png"];
        imgView.contentMode = UIViewContentModeCenter;
        [activityActionSheet addSubview:imgView];
        
    } else if (button.tag == 2){
        
        imgView.image = [UIImage imageNamed:@"terreno.png"];
        imgView.contentMode = UIViewContentModeCenter;
        [activityActionSheet addSubview:imgView];
        
    } else if (button.tag == 3){
        
        
        imgView.image = [UIImage imageNamed:@"normal.png"];
        imgView.contentMode = UIViewContentModeCenter;
        [activityActionSheet addSubview:imgView];
        
    }
        mapStatus = [NSString stringWithFormat:@"%d", button.tag];
    
}


//-(void)dismissActivityActionSheet{}
-(void)cancelActivityActionSheet{
    
    [activityActionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
    setType = mapStatus;
    
    mapViewController = [[MapViewController alloc]init];
    
    if ([setType isEqualToString:@"0"]) {
        mapViewController.mapView_.mapType = kGMSTypeHybrid;
    } else if ([setType isEqualToString:@"1"]){
        mapViewController.mapView_.mapType = kGMSTypeSatellite;
    
    } else if ([setType isEqualToString:@"2"]){
        mapViewController.mapView_.mapType = kGMSTypeTerrain;
        
    } else if ([setType isEqualToString:@"3"]){
        mapViewController.mapView_.mapType = kGMSTypeNormal;
        
    }


    
    
    NSLog(@"CENNNNAS:::: %@", setType);


}*/

-(void)lock{
    
    
    lockViewController = [[LockViewController alloc] init];
    
    
    lockViewController.view.alpha = 0;
    [UIView animateWithDuration: .4 animations: ^{
        lockViewController.view.alpha = 1.0;
    }];
    [self.view addSubview:lockViewController.view];


}

-(void) workAreaClose{
    
//[mapViewController.view setAlpha:0.0];

}

-(void) popInfo{

    [ILAlertView showWithTitle:@"GAir"
                       message:@"Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the Software), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE."
              closeButtonTitle:@"OK"
             secondButtonTitle:nil
            tappedSecondButton:nil];
    

}


-(void)tapOut:(UIGestureRecognizer *)gestureRecognizer {
   /* CGPoint p = [gestureRecognizer locationInView:self.actionSheet];
    if (p.y < 0) {
        [self actionPickerDone:nil];
    }*/
}

@end

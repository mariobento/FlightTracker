//
//  DetailViewController.h
//  MetarInfo
//
//  Created by Mario Bento on 22/11/13.
//  Copyright (c) 2013 Cinhos.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<NSXMLParserDelegate, UIWebViewDelegate>{
    NSString            *ICAO;

}


@property (nonatomic, retain) NSString  *ICAO;

@end

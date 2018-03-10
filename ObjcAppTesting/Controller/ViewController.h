//
//  ViewController.h
//  ObjcAppTesting
//
//  Created by MMDC on 09/03/18.
//  Copyright © 2018 Muh.Yusuf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import "MenuViewController.h"

typedef enum {
    HiddenFirstLogo = 1,
    ShowFirstLogo,
    HiddenSecondLogo,
    ShowSecondLogo,
    HiddenThirdLogo,
    ShowThirdLogo
} LogoImageEnum;

@interface ViewController : UIViewController {
    int currentVideo;
    BOOL isAdsOn;
    NSTimer *timer;
    NSTimer *logoTimer;
    NSString *statusImage;
}

@property (nonatomic, assign) LogoImageEnum logoImageEnum;
@property (nonatomic) AVPlayer *avPlayer;
@property (nonatomic) AVPlayer *avPlayerAds;
@property (nonatomic) AVPlayerLayer *avPlayerLayer;
@property (nonatomic) AVPlayerLayer *avPlayerLayerAds;
@property (strong, nonatomic) UIView *adsView;
@property (strong, nonatomic) UIImageView *logoImage;
@property (strong, nonatomic) UIButton *menuImageButton;

@end

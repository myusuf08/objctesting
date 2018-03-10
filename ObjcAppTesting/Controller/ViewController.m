//
//  ViewController.m
//  ObjcAppTesting
//
//  Created by MMDC on 09/03/18.
//  Copyright © 2018 Muh.Yusuf. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    [self initNotification];
    [self initGesture];
}

#pragma mark setViews

- (void)initViews {
    currentVideo = 1;
    isAdsOn = NO;
    self.logoImageEnum = ShowFirstLogo;
    [self onRequestPlayVideo:@"video1.mp4"];
    [self onSetTimerShowLogoImage];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)setAdsView {
    self.adsView = [[UIView alloc]init];
    CGRect screenSize = [UIScreen mainScreen].bounds;
    self.adsView.frame = CGRectMake(0, 0, screenSize.size.width, screenSize.size.height);
    self.adsView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.adsView];
}

- (void)setLogoImages:(NSString*)nameImage {
    self.logoImage = [[UIImageView alloc]init];
    CGRect screenSize = [UIScreen mainScreen].bounds;
    self.logoImage.frame = CGRectMake(screenSize.size.width, 30, 60, 60);
    self.logoImage.image = [UIImage imageNamed:nameImage];
    self.logoImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.logoImage];
    [self.view bringSubviewToFront:self.logoImage];
    [UIView animateWithDuration:1.0 animations:^{
        self.logoImage.frame = CGRectMake(screenSize.size.width - 120, 30, 60, 60);
    }];
}

- (void)setRemoveLogoImage {
    [self.logoImage removeFromSuperview];
}

- (void)setMenuImageButton {
    [self.menuImageButton removeFromSuperview];
    self.menuImageButton = [[UIButton alloc]init];
    self.menuImageButton.frame = CGRectMake(70, 30, 40, 40);
    [self.menuImageButton setImage:[UIImage imageNamed:@"menu"]
                          forState:UIControlStateNormal];
    [self.menuImageButton addTarget:self action:@selector(onMenuClicked)
                   forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.menuImageButton];
    [self.view bringSubviewToFront:self.menuImageButton];
}

#pragma mark setNotification

- (void)initNotification {
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(itemDidFinishPlaying:)
     name:AVPlayerItemDidPlayToEndTimeNotification
     object:nil];
}

- (void)itemDidFinishPlaying:(NSNotification *)notification {
    if (isAdsOn == true) {
        isAdsOn = false;
        [self onResetAdsVideoPlaying];
        return;
    }
    [self onRequestChangeVideoFile];
}

#pragma mark setGesture

- (void)initGesture {
    UISwipeGestureRecognizer * swipeleft = [[UISwipeGestureRecognizer alloc]
                                            initWithTarget:self action:@selector(onSwipe)];
    swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeleft];
    
    UISwipeGestureRecognizer * swiperight = [[UISwipeGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(onSwipe)];
    swiperight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swiperight];
}

#pragma mark setAction

- (void)onRequestPlayVideo:(NSString*)path {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:path ofType:nil];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    self.avPlayer = [AVPlayer playerWithURL:fileURL];
    self.avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    self.avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    self.avPlayerLayer.frame = self.view.bounds;
    self.avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.avPlayerLayer];
    [self.avPlayer play];
    [self onSetTimerShowAds];
    [self setMenuImageButton];
    self.view.userInteractionEnabled = YES;
    [self.view bringSubviewToFront:self.logoImage];
}

- (void)onRequestPlayVideoAds:(NSString*)path {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:path ofType:nil];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    self.avPlayerAds = [AVPlayer playerWithURL:fileURL];
    self.avPlayerAds.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    self.avPlayerLayerAds = [AVPlayerLayer playerLayerWithPlayer:self.avPlayerAds];
    self.avPlayerLayerAds.frame = self.view.bounds;
    self.avPlayerLayerAds.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.adsView.layer addSublayer:self.avPlayerLayerAds];
    [self.avPlayerAds play];
    [self.view bringSubviewToFront:self.logoImage];
    self.view.userInteractionEnabled = NO;
}

- (void)onResetVideoPlaying {
    [self.avPlayer pause];
    self.avPlayer = nil;
}

- (void)onResetAdsVideoPlaying {
    [self.avPlayerAds pause];
    self.avPlayerAds = nil;
    [self.adsView removeFromSuperview];
    [self.avPlayer play];
    self.view.userInteractionEnabled = YES;
}

- (void)onRequestChangeVideoFile {
    if (currentVideo == 1) {
        [self onResetVideoPlaying];
        [self onRequestPlayVideo:@"video2.mp4"];
        currentVideo = 2;
    } else {
        [self onResetVideoPlaying];
        [self onRequestPlayVideo:@"video1.mp4"];
        currentVideo = 1;
    }
}

- (void)onShowVideoAds {
    [self setAdsView];
    isAdsOn = YES;
    [self.avPlayer pause];
    [self onRequestPlayVideoAds:@"videoIklan.mp4"];
}

- (void)onSetTimerShowAds {
    [timer invalidate];
    timer = nil;
    timer = [NSTimer scheduledTimerWithTimeInterval:30
                                     target:self
                                   selector:@selector(onShowVideoAds)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)onSwipe {
    [self onRequestChangeVideoFile];
}

- (void)onShowLogoImage {
    switch (self.logoImageEnum) {
        case HiddenFirstLogo:
            [self setRemoveLogoImage];
            self.logoImageEnum = ShowFirstLogo;
            break;
        case ShowFirstLogo:
            [self setLogoImages:@"logo1"];
            self.logoImageEnum = HiddenSecondLogo;
            break;
        case HiddenSecondLogo:
            [self setRemoveLogoImage];
            self.logoImageEnum = ShowSecondLogo;
            break;
        case ShowSecondLogo:
            [self setLogoImages:@"logo2"];
            self.logoImageEnum = HiddenThirdLogo;
            break;
        case HiddenThirdLogo:
            [self setRemoveLogoImage];
            self.logoImageEnum = ShowThirdLogo;
            break;
        case ShowThirdLogo:
            [self setLogoImages:@"logo3"];
            self.logoImageEnum = HiddenFirstLogo;
            break;
    }
}

- (void)onSetTimerShowLogoImage {
    [logoTimer invalidate];
    logoTimer = nil;
    logoTimer = [NSTimer scheduledTimerWithTimeInterval:10
                                             target:self
                                           selector:@selector(onShowLogoImage)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)onMenuClicked {
    MenuViewController *menuViewController = [[MenuViewController alloc]init];
    [self.navigationController pushViewController:menuViewController animated:YES];
}

@end

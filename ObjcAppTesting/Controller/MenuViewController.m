//
//  MenuViewController.m
//  ObjcAppTesting
//
//  Created by MMDC on 09/03/18.
//  Copyright © 2018 Muh.Yusuf. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    [self setCollectionView];
}

#pragma mark setViews

- (void)initViews {
    isAlpha = YES;
    CGRect screenSize = [UIScreen mainScreen].bounds;
    self.topImage = [[UIImageView alloc]init];
    self.topImage.frame = CGRectMake(0, 0, screenSize.size.width, 110);
    self.topImage.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:self.topImage];
    
    self.separatorView = [[UIView alloc]init];
    self.separatorView.frame = CGRectMake(0, 103, screenSize.size.width/2, 3);
    self.separatorView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.separatorView];
    
    self.backButton = [[UIButton alloc]init];
    self.backButton.frame = CGRectMake(30, 20, 30, 30);
    [self.backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.view addSubview:self.backButton];
    [self.backButton addTarget:self action:@selector(onBackClicked)
              forControlEvents:UIControlEventTouchUpInside];
    
    self.alphaButton = [[UIButton alloc]init];
    self.alphaButton.frame = CGRectMake(0, 60, screenSize.size.width/2, 50);
    [self.alphaButton setTitle:@"TAB ALPHA" forState:UIControlStateNormal];
    [self.view addSubview:self.alphaButton];
    [self.alphaButton addTarget:self action:@selector(onAlphaClicked)
              forControlEvents:UIControlEventTouchUpInside];
    
    self.betaButton = [[UIButton alloc]init];
    self.betaButton.frame = CGRectMake(screenSize.size.width/2, 60, screenSize.size.width/2, 50);
    [self.betaButton setTitle:@"TAB BETA" forState:UIControlStateNormal];
    [self.view addSubview:self.betaButton];
    [self.betaButton addTarget:self action:@selector(onBetaClicked)
              forControlEvents:UIControlEventTouchUpInside];
}

- (void)setCollectionView {
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    CGRect screenSize = [UIScreen mainScreen].bounds;
    CGRect collectionViewFrame = CGRectMake(0,
                                            110,
                                            screenSize.size.width,
                                            screenSize.size.height-110);
    self.collectionView = [[UICollectionView alloc]
                           initWithFrame:collectionViewFrame
                           collectionViewLayout:layout];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    [self.collectionView registerClass:[MenuCollectionViewCell class]
            forCellWithReuseIdentifier:@"menuItemCellIdentifier"];
    [self.collectionView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self.view addSubview:self.collectionView];
    self.collectionView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
}

#pragma mark collectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:
                                @"menuItemCellIdentifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    if (isAlpha == true) {
        cell.countItemLabel.text = [NSString stringWithFormat:@"Alpha %ld",(long)indexPath.row];
    } else {
       cell.countItemLabel.text = [NSString stringWithFormat:@"Beta %ld",(long)indexPath.row];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout*)collectionViewLayout
                    sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    float cellWidth = screenWidth / 3.0;
    return CGSizeMake(cellWidth - 10, cellWidth);
}

#pragma mark setAction

- (void)onBackClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onAlphaClicked {
    CGRect screenSize = [UIScreen mainScreen].bounds;
    isAlpha = YES;
    [self.collectionView reloadData];
    [UIView animateWithDuration:0.33 animations:^{
        self.separatorView.frame = CGRectMake(0, 103, screenSize.size.width/2, 3);
    }];
    
}

- (void)onBetaClicked {
    CGRect screenSize = [UIScreen mainScreen].bounds;
    isAlpha = NO;
    [self.collectionView reloadData];
    [UIView animateWithDuration:0.33 animations:^{
        self.separatorView.frame = CGRectMake(screenSize.size.width/2,
                                              103,
                                              screenSize.size.width/2,
                                              3);
    }];
}

@end

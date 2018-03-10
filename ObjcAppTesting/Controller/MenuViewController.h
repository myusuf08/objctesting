//
//  MenuViewController.h
//  ObjcAppTesting
//
//  Created by MMDC on 09/03/18.
//  Copyright © 2018 Muh.Yusuf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuCollectionViewCell.h"

@interface MenuViewController : UIViewController<UICollectionViewDataSource,
                                            UICollectionViewDelegateFlowLayout> {
    BOOL isAlpha;
}

@property (strong,nonatomic) UIButton *backButton;
@property (strong,nonatomic) UIImageView *topImage;
@property (strong,nonatomic) UIButton *alphaButton;
@property (strong,nonatomic) UIButton *betaButton;
@property (strong,nonatomic) UIView *separatorView;
@property (strong,nonatomic) UICollectionView *collectionView;

@end

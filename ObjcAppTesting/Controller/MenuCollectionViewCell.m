//
//  MenuCollectionViewCell.m
//  ObjcAppTesting
//
//  Created by MMDC on 10/03/18.
//  Copyright © 2018 Muh.Yusuf. All rights reserved.
//

#import "MenuCollectionViewCell.h"

@implementation MenuCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bgView = [[UIView alloc]init];
        self.bgView.frame = CGRectMake(10,
                                       1,
                                       self.contentView.frame.size.width - 20,
                                       self.contentView.frame.size.height - 2);
        self.bgView.layer.borderWidth = 1;
        self.bgView.layer.borderColor = [UIColor blackColor].CGColor;
        [self.contentView addSubview:self.bgView];
        
        self.countItemLabel = [[UILabel alloc]init];
        self.countItemLabel.frame = CGRectMake(0,
                                               0,
                                               self.contentView.frame.size.width,
                                               self.contentView.frame.size.height);
        self.countItemLabel.font = [UIFont systemFontOfSize:16];
        self.countItemLabel.textColor = [UIColor blackColor];
        self.countItemLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.countItemLabel];
    }
    return self;
}

@end

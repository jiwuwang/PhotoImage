//
//  PhotoItemcell.h
//  Photptest
//
//  Created by jiwuwang on 15/11/29.
//  Copyright © 2015年 jiwuwang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)(UIButton* sender);

@interface PhotoItemcell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@property (weak, nonatomic) IBOutlet UIButton *markButton;

@property (nonatomic, copy) ClickBlock clickBlock;

- (void)setClickButton:(ClickBlock)clickBlock;


- (IBAction)buttonSelect:(UIButton *)sender;

@end

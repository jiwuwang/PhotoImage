//
//  PhotoViewController.h
//  Photptest
//
//  Created by jiwuwang on 15/11/29.
//  Copyright © 2015年 jiwuwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/ALAsset.h>

typedef NS_ENUM(NSInteger ,StateType)
{
    StateTypeNormal = 0,
    
    StateTypeSelected,
    
    StateTypeSure
};

typedef void(^StateChange)(StateType type);

@interface PhotoViewController : UIViewController

@property (nonatomic, assign) StateType type;

@property (nonatomic, copy) StateChange valueBlock;

- (void)setStateTypeChanged:(StateChange)valueBlock;

- (void)setImageAsset:(ALAsset *)asset;

@end

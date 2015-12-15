//
//  PhotoImageController.h
//  safety
//
//  Created by jiwuwang on 15/11/29.
//  Copyright © 2015年 jiwuwang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define kToolBarColor  RGBCOLOR(69, 184, 201)
@protocol UIPhotoImageDelegate <NSObject>

- (void)PhotoImageControllerDidDismiss;

- (void)PhotoImageControllerdidSelectImages:(NSArray *)images;

@end

@interface PhotoImageController : UINavigationController

@property (nonatomic, assign) id<UIPhotoImageDelegate> pDelegate;

@property (nonatomic, assign) BOOL allowsMultipleSelection;

@end

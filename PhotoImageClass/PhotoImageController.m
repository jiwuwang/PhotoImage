//
//  PhotoImageController.m
//  safety
//
//  Created by jiwuwang on 15/11/29.
//  Copyright © 2015年 jiwuwang. All rights reserved.
//

#import "PhotoImageController.h"

@interface PhotoImageController ()

@end

@implementation PhotoImageController

//使用storyboard时自动调用
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
//        if (IOS7) {
//            self.navigationBar.translucent = NO;
//            
//        }
        self.allowsMultipleSelection = YES;
        [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
        [self.navigationBar setTintColor:[UIColor whiteColor]];
        [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
        
        //[self.navigationBar setBarTintColor:kNavgationBarColor];
        
        [self.toolbar setTintColor:kToolBarColor];
        [self.toolbar setBackgroundColor:kToolBarColor];
        
        ///设置 状态栏背景
        //[self setStatusBarBackGround];
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

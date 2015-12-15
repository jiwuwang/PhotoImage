//
//  ViewController.m
//  PhotoImage
//
//  Created by jiwuwang on 15/12/15.
//  Copyright © 2015年 jiwuwang. All rights reserved.
//

#import "ViewController.h"

#import "PhotoImageController.h"

@interface ViewController ()<UIPhotoImageDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *imageViewa;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewb;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)openphotos:(id)sender {
    
    // 打开相簿
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PhotoImage" bundle:nil];
    
    PhotoImageController *pickerController = [storyboard instantiateViewControllerWithIdentifier:@"photonav"];
    
    //pickerController.allowsMultipleSelection = NO; ///单选
    pickerController.allowsMultipleSelection = YES;/// 多选
    pickerController.pDelegate = self;
    
    [self presentViewController:pickerController animated:YES completion:^{
        [ASSETHELPER clearData];
    }];
    
    
}

#pragma mark ----------UIPhotoImageDelegate
/// 选择好了图片
- (void)PhotoImageControllerdidSelectImages:(NSArray *)images
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
//    if (images) {
//        ALAsset *asset = [images lastObject];
//
//        UIImage *image = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
//    }
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    
    for (ALAsset *asset in images) {
        [array addObject:[UIImage imageWithCGImage:[asset.defaultRepresentation fullScreenImage]]];
    }
    [ASSETHELPER clearData];
    
    
    
    if (array.count >= 2) {
        
        self.imageViewa.image = array[array.count - 2];
        
        self.imageViewb.image = [array lastObject];
        
    }else
    {
        self.imageViewa.image = [array firstObject];
        
        self.imageViewb.image = [array firstObject];
    }
}
/// 消失
- (void)PhotoImageControllerDidDismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

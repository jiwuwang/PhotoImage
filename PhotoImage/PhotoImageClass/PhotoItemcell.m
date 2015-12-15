//
//  PhotoItemcell.m
//  Photptest
//
//  Created by jiwuwang on 15/11/29.
//  Copyright © 2015年 jiwuwang. All rights reserved.
//

#import "PhotoItemcell.h"

@implementation PhotoItemcell

- (void)setClickButton:(ClickBlock)clickBlock
{
    self.clickBlock = clickBlock;
}


- (IBAction)buttonSelect:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    self.clickBlock(sender);
    
}



@end

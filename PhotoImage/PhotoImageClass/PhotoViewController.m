//
//  PhotoViewController.m
//  Photptest
//
//  Created by jiwuwang on 15/11/29.
//  Copyright © 2015年 jiwuwang. All rights reserved.
//

#import "PhotoViewController.h"
#import "AssetHelper.h"

@interface PhotoViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) ALAsset *asset;

@end

@implementation PhotoViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        self.title = @"预览";
        
        
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIImage *image = [UIImage imageWithCGImage:[self.asset.defaultRepresentation fullScreenImage]];
    
    CGFloat scale = self.view.frame.size.width/image.size.width;
    
    self.imageView.bounds = CGRectMake(0, 0, self.view.frame.size.width, image.size.height*scale);
    
    self.imageView.image = image;
    
    if (self.type == StateTypeNormal) {
        
        self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"bookshelf_ring_normal.png"];
    }else
    {
        self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"bookshelf_ring_press.png"];
    }
    
    
}

- (void)setImageAsset:(ALAsset *)asset
{
    self.asset = asset;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bookshelf_ring_normal.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(clickRightBarItem:)];
    
    UIBarButtonItem *spacebar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *surebar = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(clickSure:)];
    
    self.toolbarItems = @[spacebar,spacebar,spacebar,surebar];
    
    self.navigationController.toolbarHidden = NO;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.imageView = [[UIImageView alloc] init];
    
    [self.view addSubview:self.imageView];
    
    self.imageView.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0);
}



- (void)setStateTypeChanged:(StateChange)valueBlock
{
    self.valueBlock = valueBlock;
}

- (void)clickRightBarItem:(UIBarButtonItem *)item
{
    
    if (self.type == StateTypeNormal) {
        self.type = StateTypeSelected;
        
        item.image = [UIImage imageNamed:@"bookshelf_ring_press.png"];
    }else
    {
        item.image = [UIImage imageNamed:@"bookshelf_ring_normal.png"];
        self.type = StateTypeNormal;
    }
    
    if (self.valueBlock) {
        self.valueBlock(self.type);
    }
    
}



- (void)clickSure:(UIBarButtonItem *)item
{
    if (self.valueBlock) {
        self.valueBlock(StateTypeSure);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    if (self.navigationController.toolbarHidden) {
        
        [self.navigationController setToolbarHidden:NO animated:YES];
        
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
    }else
    {
        [self.navigationController setToolbarHidden:YES animated:YES];
        
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    
    
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

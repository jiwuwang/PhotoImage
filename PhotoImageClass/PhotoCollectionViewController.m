//
//  PhotoCollectionViewController.m
//  Photptest
//
//  Created by jiwuwang on 15/11/29.
//  Copyright © 2015年 jiwuwang. All rights reserved.
//

#import "PhotoCollectionViewController.h"
#import "PhotoViewController.h"
#import "PhotoItemcell.h"
#import "AssetHelper.h"
#import "PhotoImageController.h"

@interface PhotoCollectionViewController ()<UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray   *dataArray;

@property (nonatomic, strong) NSMutableArray *selectArray;

@end

@implementation PhotoCollectionViewController

static NSString * const reuseIdentifier = @"photoItemcell";

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        self.title = @"";
    }
    
    return self;
}

- (void)setDataSource:(NSArray *)dataSource
{
    
    self.dataArray = dataSource;
    
    [self.collectionView reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.backgroundView.backgroundColor = [UIColor whiteColor];
    
    
    UIBarButtonItem *surebar = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(surechoose:)];
    
    UIBarButtonItem *canbar = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelchoose:)];
    
    UIBarButtonItem *spacebar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [self.navigationController.toolbar setBackgroundColor:kToolBarColor];
    [self.navigationController.toolbar setBarTintColor:kToolBarColor];
    
    [self.navigationController.toolbar setBarStyle:UIBarStyleBlack];
    
    self.toolbarItems = @[canbar,spacebar,surebar];
    
    self.navigationController.toolbar.hidden = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)cancelchoose:(UIBarButtonItem *)item
{
    [ASSETHELPER clearData];
    
    [[((PhotoImageController *)self.navigationController) pDelegate] PhotoImageControllerDidDismiss];
    
}

- (void)surechoose:(UIBarButtonItem *)item
{
    [ASSETHELPER clearData];
    
    [[((PhotoImageController *)self.navigationController) pDelegate] PhotoImageControllerdidSelectImages:self.selectArray];
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

#pragma mark <UICollectionViewDataSource>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PhotoItemcell *cell = (PhotoItemcell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    PhotoViewController *photoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"photoView"];
    
    [photoVC setImageAsset:self.dataArray[indexPath.item]];
    
    if (cell.markButton.selected) {
        photoVC.type = StateTypeSelected;
    }else
    {
        photoVC.type = StateTypeNormal;
    }
    
    
    [photoVC setStateTypeChanged:^(StateType type) {
       
        if (type == StateTypeSure) {
            
            //确定,直接返回 发帖界面
            
            [ASSETHELPER clearData];
            
            [[((PhotoImageController *)self.navigationController) pDelegate] PhotoImageControllerdidSelectImages:self.selectArray];
            
        }else
        {
            [cell buttonSelect:cell.markButton];
        }
        
        
    }];
    
    
    [self.navigationController pushViewController:photoVC animated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frame.size.width - 6) / 4.0f, (self.view.frame.size.width - 6) / 4.0f);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoItemcell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (self.dataArray.count > 0) {
        
        ALAsset *asset = self.dataArray[indexPath.item];
        
        cell.imageView.image = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]]; //[ASSETHELPER getImageFromAsset:self.dataArray[indexPath.item] type:ASSET_PHOTO_SCREEN_SIZE];
        
        [cell setClickButton:^(UIButton *sender) {
           
            if (sender.selected) {
                /// 选中了此照片...
                
                if (!((PhotoImageController *)self.navigationController).allowsMultipleSelection) {
                    
                    /// 单选 (返回)
                    [ASSETHELPER clearData];
                    
                    [[((PhotoImageController *)self.navigationController) pDelegate] PhotoImageControllerdidSelectImages:@[asset]];
                    
                }
                
                if (![self.selectArray containsObject:self.dataArray[indexPath.item]]) {
                    [self.selectArray addObject:self.dataArray[indexPath.item]];
                }
            }else
            {
                if ([self.selectArray containsObject:self.dataArray[indexPath.item]]) {
                    [self.selectArray removeObject:self.dataArray[indexPath.item]];
                }
            }
            
        }];
        
    }
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/



- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    
    return _dataArray;
}

- (NSMutableArray *)selectArray
{
    if (!_selectArray) {
        _selectArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _selectArray;
}

@end

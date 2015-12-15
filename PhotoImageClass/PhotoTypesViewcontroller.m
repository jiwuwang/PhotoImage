//
//  PhotoTypesViewcontroller.m
//  Photptest
//
//  Created by jiwuwang on 15/11/29.
//  Copyright © 2015年 jiwuwang. All rights reserved.
//

#import "PhotoTypesViewcontroller.h"
#import "AssetHelper.h"
#import "PhotoCollectionViewController.h"
#import "PhotoImageController.h"


@interface PhotoTypesViewcontroller ()

@property (nonatomic, strong) NSArray   *dataArray;

@end

static NSString *phootypecell = @"phootypecell";

@implementation PhotoTypesViewcontroller

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        self.title = @"照片";
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.toolbarHidden = YES;
    
    [self.tableView reloadRowsAtIndexPaths:self.tableView.indexPathsForSelectedRows withRowAnimation:UITableViewRowAnimationFade];
}

- (NSDictionary *)getAlAssersGroup:(ALAssetsGroup *)assetGroup
{
    return @{@"name" : [assetGroup valueForProperty:ALAssetsGroupPropertyName],
             @"count" : @([assetGroup numberOfAssets]),
             @"thumbnail" : [UIImage imageWithCGImage:[(ALAssetsGroup*)assetGroup posterImage]]};
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(didcancle:)];
    
    
    [ASSETHELPER getGroupList:^(NSArray *aGroups) {
        
        self.dataArray = aGroups;
        [self.tableView reloadData];
       
    }];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didcancle:(UIBarButtonItem *)item
{
    
    [ASSETHELPER clearData];
    
    [[((PhotoImageController *)self.navigationController) pDelegate] PhotoImageControllerDidDismiss];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.dataArray.count > 0) {
        
        PhotoCollectionViewController *photoCVC = [self.storyboard instantiateViewControllerWithIdentifier:@"photocollection"];
        NSDictionary *dic = [self getAlAssersGroup:self.dataArray[indexPath.row]];
        
        photoCVC.title = dic[@"name"];
        [ASSETHELPER getPhotoListOfGroup:self.dataArray[indexPath.item] result:^(NSArray *aPhotos) {
            [photoCVC setDataSource:aPhotos];
        }];
        
        [self.navigationController pushViewController:photoCVC animated:YES];
        
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:phootypecell forIndexPath:indexPath];
    
    if (self.dataArray.count > 0) {
        
        NSDictionary *dic = [self getAlAssersGroup:self.dataArray[indexPath.row]];
        
        cell.imageView.image = dic[@"thumbnail"];
        
        cell.textLabel.text = dic[@"name"];
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",dic[@"count"]];
        
    }
    
    
    // Configure the cell...
    
    return cell;
}


- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    
    return _dataArray;
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

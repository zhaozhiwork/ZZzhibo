//
//  AnchorViewController.m
//  直播oc
//
//  Created by ananooo on 17/4/29.
//  Copyright © 2017年 ananooo. All rights reserved.
//
#define kRGBColor(r, g, b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define kRandomColor  kRGBColor(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))
#define  kScreenW  [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#import "AnchorViewController.h"
#import "ZZWaterFullFlowLayout.h"
#import "HomeAnchorCollectionViewCell.h"
#import <AFNetworking/AFNetworking.h>

static NSString *homeAnchorCollectionViewCell = @"HomeAnchorCollectionViewCell";

@interface AnchorViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,ZZWaterFullFlowLayoutDataSource>

@property (nonatomic , strong) UICollectionView *collectionView;

@end

@implementation AnchorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRandomColor;
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.view addSubview:self.collectionView];
    [self loadHomeDataWithType:self.homeType andIndex:0];
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        ZZWaterFullFlowLayout *layout = [[ZZWaterFullFlowLayout alloc]init];
        layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
        layout.minimumLineSpacing = 8;
        layout.minimumInteritemSpacing = 8;
        layout.dataSource = self;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"HomeAnchorCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:homeAnchorCollectionViewCell];
    }
    return _collectionView;
}
#pragma mark -- 数据请求 --
-(void)setHomeType:(NSString *)homeType{

}
-(void)loadHomeDataWithType:(NSString *)type andIndex:(NSInteger)index{
    
    [[AFHTTPSessionManager manager]GET:@"http://qf.56.com/home/v4/moreAnchor.ios" parameters:@{@"type":type,@"index":[NSString stringWithFormat:@"%ld",index],@"size":@"48"} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeAnchorCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:homeAnchorCollectionViewCell forIndexPath:indexPath];
    cell.backgroundColor = kRandomColor;
    return cell;
}

#pragma mark -- -ZZWaterFullFlowLayoutDataSource --
-(CGFloat)waterFallLayout:(ZZWaterFullFlowLayout *)layout atIndexPath:(NSIndexPath *)indexPath{
    return  indexPath.item%2== 0 ? kScreenW * 2 / 3 : kScreenW * 0.5;
}
-(NSInteger)numberOfColsInWaterfallLayout:(ZZWaterFullFlowLayout *)layout{
    return 2;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

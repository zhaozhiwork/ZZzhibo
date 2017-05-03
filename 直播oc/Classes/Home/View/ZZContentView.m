//
//  ZZContentView.m
//  直播oc
//
//  Created by ananooo on 17/4/27.
//  Copyright © 2017年 ananooo. All rights reserved.
//
#define kRGBColor(r, g, b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define kRandomColor  kRGBColor(arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0)

#import "ZZContentView.h"
#import "ZZTitleView.h"

static NSString *ZZContentViewCellID = @"ZZContentViewCellID";


@interface ZZContentView ()<UICollectionViewDelegate,UICollectionViewDataSource>
/**子控制器*/
@property(nonatomic, strong)NSArray <UIViewController *>*childVcs;
/**父类控制器*/
@property(nonatomic, strong)UIViewController *parentVc;
/**collectionView*/
@property (nonatomic, strong)UICollectionView *collectionView;
@end

@implementation ZZContentView

-(instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray <UIViewController *>*)childVcs parentVc:(UIViewController *)parentVc{
    if (self = [super initWithFrame:frame]) {
        self.childVcs = childVcs;
        self.parentVc = parentVc;
        [self setupUI];
    }
    return self;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView setPagingEnabled:YES];
        _collectionView.bounces = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ZZContentViewCellID];
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}
-(void)setupUI{
    for (UIViewController *childVc in self.childVcs) {
        [self.parentVc addChildViewController:childVc];
    }
    [self addSubview:self.collectionView];
}
#pragma mark -- UICollectionViewDataSource --

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.childVcs.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZZContentViewCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    for (UIView *obj in cell.contentView.subviews) {
        [obj removeFromSuperview];
    }
    UIViewController *childVc = self.childVcs[indexPath.item];
    childVc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:childVc.view];
    return cell;
}
-(void)setCurrentPageIndex:(NSInteger)currentIndex{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currentIndex inSection:0];
        [self.collectionView selectItemAtIndexPath:indexPath animated:NO
                                    scrollPosition:(UICollectionViewScrollPositionLeft)];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self contentEndScroll];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        [self contentEndScroll];
    }
}
-(void)contentEndScroll{
    /**获取滚动位置*/
    NSInteger currentIndex = (NSInteger)self.collectionView.contentOffset.x/self.collectionView.bounds.size.width;
    
    /**通知titleView进行调整*/
    [self.delegate contentView:self atIndex:currentIndex];
    
    
}
@end

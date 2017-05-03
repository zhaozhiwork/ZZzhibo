//
//  ZZWaterFullFlowLayout.m
//  直播oc
//
//  Created by ananooo on 17/4/29.
//  Copyright © 2017年 ananooo. All rights reserved.
//

#import "ZZWaterFullFlowLayout.h"

@interface ZZWaterFullFlowLayout ()
@property(nonatomic, assign) NSInteger startIndex ;
@property (nonatomic , strong) NSMutableArray *colHeights;
@property(nonatomic , strong)NSMutableArray <UICollectionViewLayoutAttributes *>*atttibutesArray;
@property (nonatomic , assign) CGFloat maxH;
@end

@implementation ZZWaterFullFlowLayout
-(instancetype)init{
    if (self = [super init]) {
        self.startIndex = 0;
    }
    return self;
}
-(NSMutableArray<UICollectionViewLayoutAttributes *> *)atttibutesArray{
    if (!_atttibutesArray) {
        _atttibutesArray = [NSMutableArray array];
    }
    return _atttibutesArray;
}
-(NSMutableArray *)colHeights{
    if (!_colHeights) {
        _colHeights  = [NSMutableArray array];
        for (NSInteger i = 0; i<[self.dataSource numberOfColsInWaterfallLayout:self]; i++) {
            [_colHeights addObject:[NSNumber numberWithFloat:self.sectionInset.top]];
        }
    }
    return _colHeights;
}
-(void)prepareLayout{
    [super prepareLayout];
    /**1.获取item个数*/
    NSInteger itmeCount = [self.collectionView numberOfItemsInSection:0];
    /**2.获取列数*/
    NSInteger cols = [self.dataSource numberOfColsInWaterfallLayout:self];
    /**3.计算item的宽度*/
    CGFloat itemW = (self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing)/(CGFloat)cols;
    /**4.计算所有的item的属性*/
    for (NSInteger i = self.startIndex; i<itmeCount; i++) {
        /**4.1设置每一个item的位置相关属性*/
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        /**4.2根据位置创建attributes属性*/
        UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        /**4.3随机一个高度*/
        CGFloat height = [self.dataSource waterFallLayout:self atIndexPath:indexPath];
        
        /**5.取出最小列的位置*/
        CGFloat minH = [[self.colHeights valueForKeyPath:@"@min.floatValue"] floatValue];
        
        NSInteger index = [self.colHeights indexOfObject:[NSNumber numberWithFloat:minH]];
        
        minH = minH + height  + self.minimumLineSpacing;
        
        self.colHeights[index] = [NSNumber numberWithFloat:minH];
        
        attrs.frame = CGRectMake(self.sectionInset.left +(self.minimumInteritemSpacing + itemW)*index,minH - height - self.minimumLineSpacing ,itemW, height);
        
        [self.atttibutesArray addObject:attrs];
    }
    self.maxH = [[self.colHeights valueForKeyPath:@"@max.floatValue"] floatValue];
    
    self.startIndex = itmeCount;
}
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.atttibutesArray;
}
-(CGSize)collectionViewContentSize{
    return CGSizeMake(0, self.maxH +self.sectionInset.bottom-self.minimumLineSpacing);
}
@end

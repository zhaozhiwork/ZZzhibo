//
//  ZZWaterFullFlowLayout.h
//  直播oc
//
//  Created by ananooo on 17/4/29.
//  Copyright © 2017年 ananooo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZZWaterFullFlowLayout;

@protocol ZZWaterFullFlowLayoutDataSource <NSObject>
/**设置该item的高度*/
-(CGFloat)waterFallLayout:(ZZWaterFullFlowLayout *)layout atIndexPath:(NSIndexPath *)indexPath;
/**设置item的列数*/
@optional
-(NSInteger)numberOfColsInWaterfallLayout:(ZZWaterFullFlowLayout *)layout;
@end

@interface ZZWaterFullFlowLayout : UICollectionViewFlowLayout

@property (nonatomic,weak)id<ZZWaterFullFlowLayoutDataSource>dataSource;
@end

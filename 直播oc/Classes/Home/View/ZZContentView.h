//
//  ZZContentView.h
//  直播oc
//
//  Created by ananooo on 17/4/27.
//  Copyright © 2017年 ananooo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZZContentView;

@protocol ZZContentViewDelegate <NSObject>

-(void)contentView:(ZZContentView *)contentView atIndex:(NSInteger)index;

@end

@interface ZZContentView : UIView

@property (nonatomic , weak)id<ZZContentViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray <UIViewController *>*)childVcs parentVc:(UIViewController *)parentVc;
/**调整偏移量*/
-(void)setCurrentPageIndex:(NSInteger)currentIndex;

@end

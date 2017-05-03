//
//  ZZPageView.h
//  直播oc
//
//  Created by ananooo on 17/4/27.
//  Copyright © 2017年 ananooo. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ZZTitleStyle;

@interface ZZPageView : UIView

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *>*)titles childVcs:(NSArray <UIViewController *>*)childVcs parentVc:(UIViewController *)parentVc titleStyle:(ZZTitleStyle *)titleStyle;

@end

//
//  ZZTitleStyle.h
//  直播oc
//
//  Created by ananooo on 17/4/27.
//  Copyright © 2017年 ananooo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**标题栏目的样式**/
@interface ZZTitleStyle : UIView

@property (nonatomic , assign) CGFloat chanelHeight;

@property (nonatomic , assign) CGFloat fontSize;

@property (nonatomic , strong) UIColor *normalColor;

@property (nonatomic , strong) UIColor *selectColor;

@property (nonatomic , assign) CGFloat itemMargin;

+(instancetype)titleStyle;

+(void)setChanelHeight:(CGFloat)chanelHeight;

+(void)setFontSize:(CGFloat)fontSize;

+(void)setNormalColor:(UIColor *)normalColor;

+(void)setSelectColor:(UIColor *)selectColor;

+(void)setItemMargin:(CGFloat)itemMargin;

@end

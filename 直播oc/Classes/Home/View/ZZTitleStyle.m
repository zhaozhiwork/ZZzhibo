//
//  ZZTitleStyle.m
//  直播oc
//
//  Created by ananooo on 17/4/27.
//  Copyright © 2017年 ananooo. All rights reserved.
//

#import "ZZTitleStyle.h"

@interface ZZTitleStyle ()

@end

@implementation ZZTitleStyle

+(instancetype)titleStyle{
    static  ZZTitleStyle *titleStyle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        titleStyle = [[self alloc]init];
        titleStyle.chanelHeight = 44;
        titleStyle.fontSize = 15;
        titleStyle.normalColor = [UIColor blackColor];
        titleStyle.selectColor = [UIColor orangeColor];
        titleStyle.itemMargin = 30;
    });
    return titleStyle;
}
+(void)setChanelHeight:(CGFloat)chanelHeight{
    [ZZTitleStyle titleStyle].chanelHeight =  chanelHeight;
}
+(void)setFontSize:(CGFloat)fontSize{
    [ZZTitleStyle titleStyle].fontSize = fontSize;
}
+(void)setNormalColor:(UIColor *)normalColor{
    [ZZTitleStyle titleStyle].normalColor = normalColor;
}
+(void)setSelectColor:(UIColor *)selectColor{
    [ZZTitleStyle titleStyle].selectColor =  selectColor;
}
+(void)setItemMargin:(CGFloat)itemMargin{
    [ZZTitleStyle titleStyle].itemMargin = itemMargin;
}
@end

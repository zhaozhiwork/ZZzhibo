//
//  HomeAnchorCollectionViewCell.m
//  直播oc
//
//  Created by ananooo on 17/5/2.
//  Copyright © 2017年 ananooo. All rights reserved.
//

#import "HomeAnchorCollectionViewCell.h"

@interface HomeAnchorCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *anchorImageView;

@end

@implementation HomeAnchorCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.anchorImageView.layer.cornerRadius = 3.0f;
    self.anchorImageView.clipsToBounds = YES;
}

@end

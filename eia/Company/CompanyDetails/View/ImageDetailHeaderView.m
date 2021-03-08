//
//  ImageDetailHeaderView.m
//  eia
//
//  Created by JimmyYue on 2020/6/20.
//  Copyright © 2020 JimmyYue. All rights reserved.
//

#import "ImageDetailHeaderView.h"

@implementation ImageDetailHeaderView

- (void)setAddUITapGestureRecognizer {
    //添加点击的手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
}

- (void)onTap:(UITapGestureRecognizer *)tap {
    if (self.block) {
        self.block();
    }
}

-(void)updateWithStatus:(int)status {

    if (status == 1) {
        self.statusImageView.image = [UIImage imageNamed:@"rightward"];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationsEnabled:YES];
        self.statusImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        [UIView commitAnimations];
    }else if (status == 2){
        self.statusImageView.image = [UIImage imageNamed:@"downward"];//为了合上也有动画
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationsEnabled:YES];
        self.statusImageView.transform = CGAffineTransformMakeRotation(- M_PI_2);
        [UIView commitAnimations];
    }else {
        self.statusImageView.image = [UIImage imageNamed:@"rightward"];//防止一开始就有动画
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

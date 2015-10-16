//
//  ScaleImageView.m
//  JianDan
//
//  Created by 刘献亭 on 15/9/20.
//  Copyright (c) 2015年 刘献亭. All rights reserved.
//

#import "ScaleImageView.h"
#import "UIImage+Scale.h"
#import "PureLayout.h"

@implementation ScaleImageView

-(void)setImage:(UIImage *)image{
    //第一次设置的图片一定是默认图片
    if (!self.placeholder) {
        self.placeholder=image;
        return;
    }
    
    //不重复加载默认图片
    if (!image||[image isEqual:self.placeholder]) {
        return;
    }
    
    //第一次加载图片
    // 1，设定基本动画参数
    CGImageRef imageRef=image.CGImage;
    CABasicAnimation *contentsAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
    contentsAnimation.fromValue         =  self.layer.contents;
    contentsAnimation.toValue           =  (__bridge id)imageRef;
    contentsAnimation.duration          = 0.5f;
    
    // 2，设定layer动画结束后的contents值
    self.layer.contents         = (__bridge id)imageRef;
    
    //3， 让layer开始执行动画
    [self.layer addAnimation:contentsAnimation forKey:nil];
}

-(void)updateIntrinsicContentSize:(CGSize)size{
    CGFloat ratio = self.frame.size.width/ size.width;
    CGFloat mHeight = size.height * ratio;
    if(mHeight>=SCREEN_HEIGHT){
        mHeight=SCREEN_HEIGHT*2.0/3.0;
        self.layer.masksToBounds=YES;
        [self.layer setContentsScale:[[UIScreen mainScreen] scale]];
        self.layer.contentsGravity=kCAGravityResizeAspectFill;
    }else{
        self.layer.contentsGravity=kCAGravityResize;
    }
    self.mHeight=mHeight;
    [self invalidateIntrinsicContentSize];
}

-(CGSize)intrinsicContentSize{
    if (self.mHeight) {
         return CGSizeMake(self.frame.size.width, self.mHeight);
    }
    return [super intrinsicContentSize];
   
}
@end

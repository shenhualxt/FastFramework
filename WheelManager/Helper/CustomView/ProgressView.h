//
//  ProgressView.h
//  iSmartRouter
//
//  Created by NPHD on 14-4-18.
//  Copyright (c) 2014年 NPHD. All rights reserved.
//

#import <UIKit/UIKit.h>
#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
//#define  PROGREESS_WIDTH 140 //圆直径
//#define  PROGREESS_WIDTH 200 //圆直径
//#define PROGRESS_LINE_WIDTH 10 //弧线的宽度
//#define START_ANGLE  -210
//#define END_ANGLE 30
#define TextColor    [UIColor grayColor]
@interface ProgressView : UIView
{
    CAShapeLayer *_backLayer;
    UILabel *_progressTextLab;
    float rotations;
    int width;
}
@property(nonatomic, strong) CAShapeLayer *progressLayer;
@property(nonatomic, strong)UILabel *progressTextLab;
@property(nonatomic, strong)UILabel *progressLab;
@property(nonatomic, strong)UILabel *scoreLab;
-(void) startAnimation;
-(void) stopAnimation;
-(void) setProgress:(float)progress;
@end

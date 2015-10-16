//
//  ProgressView.m
//  iSmartRouter
//
//  Created by NPHD on 14-4-18.
//  Copyright (c) 2014年 NPHD. All rights reserved.
//

#import "ProgressView.h"
//#define  PROGREESS_WIDTH 140 //圆直径
//#define  PROGREESS_WIDTH 200 //圆直径
//#define PROGRESS_LINE_WIDTH 10 //弧线的宽度
//#define START_ANGLE  -210
//#define END_ANGLE 30


@implementation ProgressView


- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
		[self initlization];
	}
	return self;
}

- (void)awakeFromNib {
	[self initlization];
}

- (void)initlization {
	self.backgroundColor = [UIColor clearColor];
    width=self.frame.size.width;
    
    
	float radius = self.frame.size.width / 2;  //半径
    float baseLeft =0;//(320 - PROGREESS_WIDTH) / 2; //左边距离
    float baseUp = 0;//12;
	float squareRadius = sqrt(radius * radius / 2);//内切正方的长度的一半

	//固定的白色背景层
	_backLayer = [CAShapeLayer layer];
//	_backLayer.frame = CGRectMake((320 - PROGREESS_WIDTH) / 2, baseUp, PROGREESS_WIDTH, PROGREESS_WIDTH);
    _backLayer.frame=CGRectMake(0, 0, width, width);
	_backLayer.fillColor = [[UIColor clearColor] CGColor];
	_backLayer.strokeColor = [UIColor lightGrayColor].CGColor;//指定path的渲染颜色
	//_trackLayer.opacity = 0.25; //背景同学你就甘心做背景吧，不要太明显了，透明度小一点
	_backLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
	_backLayer.lineWidth = 10;//线的宽度
	_backLayer.strokeStart = 0.0;
	_backLayer.strokeEnd = 1.0;


//	UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width / 2, width / 2) radius:(width - 10) / 2 startAngle:(-M_PI / 2) endAngle:(3 * M_PI / 2) clockwise:YES];//上面说明过了用来构建圆形
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width / 2, width / 2) radius:(width - 10) / 2 startAngle:(-M_PI / 2) endAngle:(3 * M_PI / 2) clockwise:YES];//上面说明过了用来构建圆形
	_backLayer.path = [path CGPath]; //把path传递給layer，然后layer会处理相应的渲染，整个逻辑和CoreGraph是一致的。


	//进度条层 外切白色层的内切正方形
	_progressLayer = [CAShapeLayer layer];//创建一个track shape layer
	_progressLayer.frame = CGRectMake(baseLeft + (radius - squareRadius), baseUp + (radius - squareRadius), squareRadius * 2, squareRadius * 2);
	_progressLayer.fillColor = [[UIColor clearColor] CGColor];
	_progressLayer.strokeColor = [UIColor colorWithRed:35 / 255.0f green:255 / 255.0f blue:177 / 255.0f alpha:0.8].CGColor;//指定path的渲染颜色
//	_progressLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
	_progressLayer.lineWidth = 10;//线的宽度
	_progressLayer.strokeStart = 0.0;
	_progressLayer.strokeEnd =  0.0;
	path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(squareRadius, squareRadius) radius:(width - 10) / 2 startAngle:(-M_PI / 2) endAngle:(3 * M_PI / 2) clockwise:YES];//上面说明过了用来构建圆形
	_progressLayer.path = [path CGPath]; //把path传递給layer，然后layer会处理相应的渲染，整个逻辑和CoreGraph是一致的。

	[self.layer addSublayer:_backLayer];
//    [self.layer addSublayer:_progressLayer];

	/*********** 渐变处理 ****************/
	CALayer *gradientLayer = [CALayer layer];
	//用于渐变的3种颜色
	UIColor *green = [UIColor colorWithRed:0/ 255.0f green:167/ 255.0f blue:157 / 255.0f alpha:1.0f];
	UIColor *yellow = [UIColor colorWithRed:245 / 255.0f green:166 / 255.0f blue:35 / 255.0f alpha:1.0f];
	UIColor *red = [UIColor colorWithRed:237 / 255.0f green:103 / 255.0f blue:115 / 255.0f alpha:1.0f];
	CAGradientLayer *gradientLayer1 = [CAGradientLayer layer]; //用来渐变
	gradientLayer.backgroundColor = [UIColor whiteColor].CGColor;
    
    gradientLayer1.frame=CGRectMake(width/2, 0, width/2, width);
	[gradientLayer1 setColors:[NSArray arrayWithObjects:(id)green.CGColor, yellow.CGColor, nil]];
	[gradientLayer1 setLocations:@[@0.5, @1.0]];
	[gradientLayer1 setStartPoint:CGPointMake(0.5, 0)];
	[gradientLayer1 setEndPoint:CGPointMake(0.5, 1)];

	[gradientLayer addSublayer:gradientLayer1];
    
    CAGradientLayer *gradientLayer2= [CAGradientLayer layer]; //用来渐变
    gradientLayer.backgroundColor = [UIColor whiteColor].CGColor;
    
    gradientLayer2.frame=CGRectMake(0, 0, width/2, width);
    [gradientLayer2 setColors:[NSArray arrayWithObjects:(id)red.CGColor, yellow.CGColor, nil]];
    [gradientLayer2 setLocations:@[@0.5, @1.0]];
    [gradientLayer2 setStartPoint:CGPointMake(0.5, 0)];
    [gradientLayer2 setEndPoint:CGPointMake(0.5, 1)];
    
    [gradientLayer addSublayer:gradientLayer2];

	[gradientLayer setMask:_progressLayer]; //用progressLayer来截取渐变层

	[self.layer addSublayer:gradientLayer];
	/*********** 渐变处理 ****************/
}

//开始动画
- (void)startAnimation {
	rotations = 1.0;
	_progressLayer.strokeStart = 0.0;
	_progressLayer.strokeEnd = 1.0;
	[self runSpinAnimationWithDuration:1.0];
	[_progressLayer setAnchorPoint:CGPointMake(0.5, 0.5)];
}

// 停止动画
- (void)stopAnimation {
	NSLog(@"stop");
	[_progressLayer removeAnimationForKey:@"animateTransform"];
}

- (CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount {
	CATransform3D rotationTransform  = CATransform3DMakeRotation(degree, 0, 0, direction);

	CABasicAnimation *animation;

	animation = [CABasicAnimation animationWithKeyPath:@"transform"];



	animation.toValue = [NSValue valueWithCATransform3D:rotationTransform];

	animation.duration = dur;

	animation.autoreverses = NO;

	animation.cumulative = YES;

	animation.removedOnCompletion = NO;

	animation.fillMode = kCAFillModeForwards;

	animation.repeatCount = 2;

	animation.delegate = self;

	return animation;
}

- (void)runSpinAnimationWithDuration:(CGFloat)duration;
{
	CABasicAnimation *rotationAnimation;
	rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	rotationAnimation.toValue = [NSNumber numberWithFloat:(176 / 180.0) * M_PI * 1.0 /* full rotation*/ * rotations * duration];
	rotationAnimation.duration = duration;
	rotationAnimation.cumulative = YES;
	rotationAnimation.repeatCount = 10000;
	rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	rotationAnimation.removedOnCompletion = NO;
	rotationAnimation.autoreverses = YES;
	rotationAnimation.fillMode = kCAFillModeForwards;
	[_progressLayer addAnimation:rotationAnimation forKey:@"animateTransform"];
}

//设置进度
- (void)setProgress:(float)progress {
	[UIView animateWithDuration:0.5f animations: ^{
	    if (progress > 1) {
	        _progressLayer.strokeEnd = 1.0;
		}
	    else {
	        _progressLayer.strokeEnd = progress/ 1;
		}

	    _progressLab.text = [NSString stringWithFormat:@"%ld", (long)progress];
	    [self calcLevelWithProgress:progress];
	}];
}

- (void)calcLevelWithProgress:(NSInteger)progress {
	if (progress >= 300) {
		_scoreLab.text = NSLocalizedString(@"Serious pollution", nil);
	}
	else if (progress >= 200 && progress < 300) {
		_scoreLab.text = NSLocalizedString(@"Severe pollution", nil);
	}
	else if (progress >= 150 && progress < 200) {
		_scoreLab.text = NSLocalizedString(@"Middle level pollution", nil);
	}
	else if (progress >= 100 && progress < 150) {
		_scoreLab.text = NSLocalizedString(@"Light pollution", nil);
	}
	else if (progress >= 50 && progress < 100) {
		_scoreLab.text = NSLocalizedString(@"Good", nil);
	}
	else {
		_scoreLab.text = NSLocalizedString(@"Very good", nil);
	}
}

@end

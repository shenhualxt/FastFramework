//
//  WithProgressController.m
//  WheelManager
//
//  Created by 刘献亭 on 15/10/14.
//  Copyright © 2015年 刘献亭. All rights reserved.
//

#import "WithProgressController.h"
#import "ScaleImageView.h"
#import "UIImageView+UIProgressForSDWebImage.h"
#import "BLImageSize.h"
#import "LTProgressWebView.h"

static NSString* const picURL = @"http://b.zol-img.com.cn/desk/bizhi/image/6/1680x1050/1444722383719.jpg";
static NSString* const webURL = @"https://www.baidu.com";
@interface WithProgressController ()

@property (assign,nonatomic) CGSize picSize;

@property (strong,nonatomic) UIButton *button;

@property (strong,nonatomic) UIImageView *progressImageView;

@property (strong,nonatomic) LTProgressWebView *webView;

@end

@implementation WithProgressController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title=@"UIWebView+ProgressView";
    
    if ([self.sendObject integerValue]==4) {
        self.title=@"UIImageView+ProgressView";
        [self.button setTitle:@"点击加载图片" forState:UIControlStateNormal];
    }

    //开始加载
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if([self.sendObject integerValue]==4){//UIImageView+Progress
            [[SDImageCache sharedImageCache] removeImageForKey:picURL];
#pragma mark -核心代码
            [self.progressImageView setImageWithURL:[NSURL URLWithString:picURL] placeholderImage:[UIImage imageNamed:@"ic_loading_small"] options:SDWebImageLowPriority usingProgressViewStyle:UIProgressViewStyleDefault];
        }else{//UIwebView
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webURL]]];
        }
    }];
}


-(LTProgressWebView *)webView{
    if (!_webView) {
        CGRect frame=CGRectMake(0, 65, SCREEN_WIDTH, 400);
        _webView=[[LTProgressWebView alloc] initWithFrame:frame];
        [self.view addSubview:_webView];
    }
    return _webView;
}



-(UIImageView *)progressImageView{
    if (!_progressImageView) {
        CGRect frame=CGRectMake(0, 65, SCREEN_WIDTH, 400);
        _progressImageView=[[UIImageView alloc] initWithFrame:frame];
        _progressImageView.image=[UIImage imageNamed:@"ic_loading_small"];
        [self.view addSubview:_progressImageView];
    }
    return _progressImageView;
}

-(UIButton *)button{
    if (!_button) {
        _button=[UIButton buttonWithType:UIButtonTypeSystem];
        _button.frame=CGRectMake(100, 0, 100, 60);
        [_button setTitle:@"点击加载网页" forState:UIControlStateNormal];
        [self.view addSubview:_button];
    }
    return _button;
}

@end

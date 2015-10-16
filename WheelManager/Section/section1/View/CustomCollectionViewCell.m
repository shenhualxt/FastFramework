//
//  CustomCollectionViewCell.m
//  WheelManager
//
//  Created by 刘献亭 on 15/10/13.
//  Copyright © 2015年 刘献亭. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@interface CustomCollectionViewCell()<CEReactiveView>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation CustomCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        NSArray *nibs=[[NSBundle mainBundle] loadNibNamed:@"CustomCollectionViewCell" owner:self options:nil];
        self=(CustomCollectionViewCell *)[nibs firstObject];
    }
    return self;
}

-(void)bindViewModel:(NSString *)title forIndexPath:(NSIndexPath *)indexPath{
    self.imageView.image=[UIImage imageNamed:@"ic_loading_small"];
    self.title.text=title;
}

@end

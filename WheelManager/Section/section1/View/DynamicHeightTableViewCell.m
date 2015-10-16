//
//  DynamicHeightTableViewCell.m
//  WheelManager
//
//  Created by 刘献亭 on 15/10/13.
//  Copyright © 2015年 刘献亭. All rights reserved.
//

#import "DynamicHeightTableViewCell.h"
#import "TableViewController.h"

@interface DynamicHeightTableViewCell()<CEReactiveView>

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *content;

@end

@implementation DynamicHeightTableViewCell


-(void)bindViewModel:(CusmtomModel *)viewModel forIndexPath:(NSIndexPath *)indexPath{
    self.title.text=viewModel.title;
    if(indexPath.row%2==0){
        self.content.text=[NSString stringWithFormat:@"%@%@%@%@%@%@",viewModel.title,viewModel.title,viewModel.title,viewModel.title,viewModel.title,viewModel.title];
    }else{
        self.content.text=[NSString stringWithFormat:@"%@%@",viewModel.title,viewModel.title];
    }
}

@end

//
//  TableViewController.h
//  WheelManager
//
//  Created by 刘献亭 on 15/10/12.
//  Copyright © 2015年 刘献亭. All rights reserved.
//

#import "BaseTableViewController.h"

#pragma mark -模型
@interface CusmtomModel : NSObject

@property(nonatomic,assign) int id;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *thumb_c;

@end

@interface TableViewController : BaseTableViewController

@property(strong,nonatomic) CETableViewBindingHelper *helper;

@end

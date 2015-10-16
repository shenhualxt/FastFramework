//
//  AppDelegate.m
//  WheelManager
//
//  Created by 刘献亭 on 15/10/11.
//  Copyright (c) 2015 刘献亭. All rights reserved.
//

#import "AppDelegate.h"
#import "MainController.h"
#import "Section1Controller.h"
#import "Section2Controller.h"
#import "Section3Controller.h"
#import "Section4Controller.h"
#import "BaseNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  [self initChildViewController];
  [_window makeKeyAndVisible];
  return YES;
}

-(void)initChildViewController{
  MainController *mainVC=[MainController new];
  self.window.rootViewController=mainVC;

  NSArray *vcArray=@[Section1Controller.class,Section2Controller.class,Section3Controller.class,Section4Controller.class];
  NSArray *imageArray=@[@"carwin_icon_mgr", @"carwin_icon_carwin", @"carwin_icon_exchage", @"carwin_icon_tips"];
  NSArray *titleArray=@[@"工具",@"自定义View",@"第三方库",@"编程思想"];
  for (int i = 0; i <titleArray.count; i++) {
    Class clazz=(Class)vcArray[i];
    UIViewController *vc=[clazz new];
    BaseNavigationController *navVC=[[BaseNavigationController alloc] initWithRootViewController:vc];
    [mainVC addChildViewController:navVC];
    vc.title=titleArray[i];
    vc.tabBarItem.image=[UIImage imageNamed:imageArray[i]];
  }
}

@end

//
//  OtherToolsController.m
//  WheelManager
//
//  Created by 刘献亭 on 15/10/12.
//  Copyright © 2015年 刘献亭. All rights reserved.
//

#import "OtherToolsController.h"

@interface OtherToolsController ()

@end

@implementation OtherToolsController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSMutableArray *)toolArray {
    
    NSMutableArray *toolArray = [NSMutableArray array];
    NSArray *titleArray;
    NSArray *detailTitleArray;
    switch ([self.sendObject integerValue]) {
        case 3:{
             self.title=@"小工具类";
            titleArray = @[@"1、BLImageSize", @"2、CommonUtils", @"3、UITableViewCell+TableView", @"4、UIWebView+RAC",@"BaseViewController"];
            detailTitleArray=@[@"通过图片网络地址，获得图片大小", @"内有常用工具方法", @"cell内获得所在的UITableView,UIViewController", @"响应式替代代理",@"便捷传值（sendObject）、返回街、快速创建菜单，背景图片、清理内存、网络错误显示界面"];
        }
            break;
        case 4:{
            self.title=@"常用软件";
            titleArray = @[@"1、Xcode插件", @"2、instruments", @"3、AppCode",@"4、Reveal",@"6、Postman",@"7、Souretree",@"8、Sketch",@"9、Firefox插件"];
            detailTitleArray=@[@"Alcatraz,CocoaPods,KSImageNamed,VVDocument,FUzzyAutocomplete",@"内存占用，泄露，耗时", @"重构，代码提示，格式化，插件，这些方面要比Xcode 好很多，两者可以相互补充", @"Xcode 的Capture View Heirarchy的升级美化版",@"接口调试工具，chrome插件",@"git版本控制管理器（可视化+命令行）",@"图片处理工具，切图利器", @"Sqlite Manager插件等"];
        }
            break;
        case 5:{
            self.title=@"小技巧";
            titleArray = @[@"1、snippets", @"2、LLDB调试技巧",@"3、宏，类目的使用",@"4、多使用插件",@"5、打好基础",@"6、代码整理收集"];
            detailTitleArray=@[@"用法：@property (strong,nonatomic) <#type#> <#name#>;     github管理插件：ACCodeSnippetRepositoryPlugin", @"po(print object)、expr(运行时修改变量值)、断点出发条件（Condition action）、Add Exception Breakpoint、带颜色的Log", @"避免代码重复",@"自动导入头文件，注释，格式化，图片名称提示等",@"C语言，数据结构，算法，数据库，网络编程，内存",@"有些可能记不住"];
        }
            break;
        case 6:{
            self.title=@"常用网站";
            titleArray = @[@"Apple doc",@"1、淘宝",@"Github", @"2、CocoaChina，简书，CSDN,objc中国",@"3、stackoverflow",@"4、iosdevweekly，objc，nshipster，raywenderlich等",@"5、大牛博客"];
            detailTitleArray=@[@"",@"淘一些好书，教学视频",@"", @"中文学习网站", @"问题开速解决的好地方",@"外文学习网站",@"唐巧，onecat,KittenYang,Limboy,土土哥等"];
        }
            break;
        case 7:{
            self.title=@"书籍";
            titleArray = @[@"1、重构改善既有代码的设计", @"2、iOS设计模式解析",@"3、测试驱动的iOS开发",@"4、编写高质量iOS与OS X的52个有效方法",@"5、C语言程序设计",@"6、算法导论",@"7、Objective-C高级编程",@"8、iOS8 swift编程指南"];
            detailTitleArray=@[@"Java语言，代码有些过时，但这不影响什么", @"设计模式在iOS开发中运用", @"先写测试代码，后写实现代码",@"Effective 系列书籍",@"c语言，必须的",@"需要耐心研读",@"内存管理，Blocks,GCD", @"追逐前沿"];
        }
            break;
        default:
            break;
    }
    
    
    for (int i = 0; i < titleArray.count; ++i) {
        TemplateModel *tool=[TemplateModel new];
        tool.title=titleArray[i];
        tool.subTitle=detailTitleArray[i];
        [toolArray addObject:tool];
    }
    
    
    
    return toolArray;
}




@end

//
//  RWTableViewBindingHelper.h
//  RWTwitterSearch
//
//  Created by Colin Eberhardt on 24/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface TemplateModel : NSObject

@property(assign,nonatomic) long id;

@property(strong,nonatomic) NSString *title;

@property(strong,nonatomic) NSString *subTitle;

@property(assign,nonatomic) Class targetController;

@property(assign,nonatomic) BOOL accessoryType;

@end

@interface TemplateCell : UITableViewCell<CEReactiveView>

@end

/// A helper class for binding view models with NSArray properties to a UITableView.
@interface CETableViewBindingHelper : NSObject

// forwards the UITableViewDelegate methods
@property (weak, nonatomic) id<UITableViewDelegate> delegate;

@property (weak, nonatomic) id<UIScrollViewDelegate> scrollViewDelegate;

@property (assign, nonatomic) BOOL isDynamicHeight;

@property (strong, nonatomic) NSMutableArray *data;

+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
                             sourceSignal:(RACSignal *)source
                         selectionCommand:(RACCommand *)selection
                          customCellClass:(Class)clazz;

+ (instancetype)bindingHelperForTableView:(UITableView *)tableView sourceSignal:(RACSignal *)source;

+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
                             sourceSignal:(RACSignal *)source
                         selectionCommand:(RACCommand *)selection
                        templateCellClass:(Class)clazz;
@end

//
//  RWView.h
//  RWTwitterSearch
//
//  Created by Colin Eberhardt on 25/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

/// A protocol which is adopted by views which are backed by view models.
@protocol CEReactiveView <NSObject>

/// Binds the given view model to the view
@required
- (void)bindViewModel:(id)viewModel forIndexPath:(NSIndexPath *)indexPath;

@optional
- (void)loadImage:(id)viewModel forIndexPath:(NSIndexPath *)indexPath;

@end

//
//  UnfoldTabView.h
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/5.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UnfoldTableViewDataSource<NSObject>

@required

- (NSInteger)numberOfRowsInOrderDetailsView;

- (id)dataForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (void)dataForRowAtIndexPath:(id)data didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)tipNoteAtBottom;

@end


@interface UnfoldTabView : UIView

@property (nonatomic, copy) dispatch_block_t dismissBlock;

@property (nonatomic, weak) id<UnfoldTableViewDataSource> dataSource;

- (id)initWithDataSource:(id<UnfoldTableViewDataSource>)dataSource andHeight:(CGFloat)height;

- (void)show;

- (void)dismiss;

@end

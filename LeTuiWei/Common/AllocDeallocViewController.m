//
//  AllocDeallocViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/3/28.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "AllocDeallocViewController.h"

@interface AllocDeallocViewController ()

@end

@implementation AllocDeallocViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#ifdef DEBUG
static NSMutableDictionary *s_allocInfo;
#endif

#pragma mark - init and dealloc
- (id)init {
    if (self = [super init]) {
        [self allocInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self allocInit];
    }
    return self;
}

- (void)allocInit {
#ifdef DEBUG
    NSLog(@"----------------创建类----------------%@", NSStringFromClass([self class]));
    if (!s_allocInfo) {
        s_allocInfo = [NSMutableDictionary dictionary];
    }
    
    s_allocInfo[NSStringFromClass([self class])] = @([s_allocInfo[NSStringFromClass([self class])] intValue] + 1);
    NSLog(@"%@", s_allocInfo);
#endif
}

- (void)dealloc {
#ifdef DEBUG
    NSLog(@"----------------释放类----------------%@",  NSStringFromClass([self class]));
    
    s_allocInfo[NSStringFromClass([self class])] = @([s_allocInfo[NSStringFromClass([self class])] intValue] - 1);
    if ([s_allocInfo[NSStringFromClass([self class])] intValue] == 0) {
        [s_allocInfo removeObjectForKey:NSStringFromClass([self class])];
    }
    NSLog(@"%@", s_allocInfo);
#endif
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end

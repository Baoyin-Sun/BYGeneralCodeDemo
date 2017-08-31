//
//  BYViewModel.m
//  BYGeneralCodeDemo
//
//  Created by BaoYin on 2017/8/31.
//  Copyright © 2017年 BaoYin Sun. All rights reserved.
//

#import "BYViewModel.h"

@implementation BYViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    BYViewModel *viewModel = [super allocWithZone:zone];
    if (viewModel) {
        [viewModel by_initialize];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model {
    self = [super init];
    if (self) {
    }
    return self;
}

//- (WZRequest *)request {
//    if (!_request) {
//        _request = [WZRequest request];
//    }
//    return _request;
//}

- (void)by_initialize {}

@end

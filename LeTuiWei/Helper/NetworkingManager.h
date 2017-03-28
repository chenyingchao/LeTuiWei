//
//  NetworkingManager.h
//  OilInstalments
//
//  Created by 陈颖超 on 2017/2/6.
//  Copyright © 2017年 chenyingchao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Success)(id responseObject);
typedef void(^Failure)(NSError *error);

@interface NetworkingManager : NSObject

@property(nonatomic , copy) Success requestSuccess; //请求成功
@property(nonatomic , copy) Failure requestFailure; //请求失败

#pragma GET请求--------------
+ (void)requestMethodGetUrl:(NSString*)url dic:(NSDictionary*)dic Succed:(Success)succed failure:(Failure)failure;

#pragma POST请求--------------
+ (void)requestMethodPOSTUrl:(NSString*)url dic:(NSDictionary*)dic Succed:(Success)succed failure:(Failure)failure;

@end

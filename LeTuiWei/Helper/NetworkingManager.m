//
//  NetworkingManager.m
//  OilInstalments
//
//  Created by 陈颖超 on 2017/2/6.
//  Copyright © 2017年 chenyingchao. All rights reserved.
//

#import "NetworkingManager.h"
#import <AFNetworking.h>
@implementation NetworkingManager
//默认网络请求时间
static const NSUInteger kDefaultTimeoutInterval = 20;

#pragma GET请求--------------
+(void)requestMethodGetUrl:(NSString*)url
                       dic:(NSDictionary*)dic
                    Succed:(Success)succed
                   failure:(Failure)failure{
    //1.数据请求接口 2.请求方法 3.参数
    //请求成功   返回数据
    //请求失败   返回错误
    [NetworkingManager Manager:url Method:@"GET"  dic:dic requestSucced:^(id responseObject) {
        
        succed(responseObject);
        
    } requestfailure:^(NSError *error) {
        
        failure(error);
        
    }];
}
#pragma POST请求--------------
+(void)requestMethodPOSTUrl:(NSString*)url
                        dic:(NSDictionary*)dic
                     Succed:(Success)succed
                    failure:(Failure)failure{
    [NetworkingManager Manager:url Method:@"POST"  dic:dic requestSucced:^(id responseObject) {
        
        succed(responseObject);
        
    } requestfailure:^(NSError *error) {
        
        failure(error);
    }];
}

//=====================
+(void)Manager:(NSString*)url Method:(NSString*)Method dic:(NSDictionary*)dic requestSucced:(Success)Succed requestfailure:(Failure)failure
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = kDefaultTimeoutInterval; //默认网络请求时间
    manager.responseSerializer = [AFJSONResponseSerializer serializer]; //申明返回的结果是json类型
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript",@"text/html", nil];
   
    if ([Method isEqualToString:@"POST"]) {
        [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            Succed(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failure(error);
        }];

    }else{
        
        [manager GET:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            Succed(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failure(error);
            
        }];
    }
    
}




@end

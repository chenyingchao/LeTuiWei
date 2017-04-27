//
//  StoreCoordinateViewController.m
//  LeTuiWei
//
//  Created by 陈营超 on 2017/4/10.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "StoreCoordinateViewController.h"

@interface StoreCoordinateViewController ()<QMapViewDelegate>
@property (nonatomic, strong) QMapView *mapView;

@property (nonatomic) CLLocationCoordinate2D storeCoordinate;

@end

@implementation StoreCoordinateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"门店坐标";

    self.mapView = [[QMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    [self.mapView setZoomLevel:14];
    [_mapView setShowsUserLocation:YES];
    
    [self setUpNavigationBarLeftBack];
    [self setUpNavigationBarRight];
}

- (void)setUpNavigationBarLeftBack {
    UIView *leftContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kNavigationBarHeight, kNavigationBarHeight)];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftContainerView addSubview:backBtn];
    
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(leftContainerView);
    }];
    
    WS(weakSelf);
    [backBtn bk_whenTapped:^{
        [weakSelf leftbarbuttonAction];
    }];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftContainerView];
}

- (void)leftbarbuttonAction {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setUpNavigationBarRight {
    UIView *leftContainerView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth -kNavigationBarHeight, 0, kNavigationBarHeight, kNavigationBarHeight)];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftContainerView addSubview:backBtn];
    
    [backBtn setTitle:@"确定" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(leftContainerView);
    }];
    
    WS(weakSelf);
    [backBtn bk_whenTapped:^{
        [weakSelf rightbarbuttonAction];
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftContainerView];
}

- (void)rightbarbuttonAction {
    [self.view endEditing:YES];
    
    if (self.storeLocationBlock) {
        self.storeLocationBlock(self.storeCoordinate);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    [self.mapView removeFromSuperview];
    self.mapView.delegate = nil;
    
}


- (void)mapViewWillStartLocatingUser:(QMapView *)mapView {
    //获取开始定位的状态

    
}

- (void)mapViewDidStopLocatingUser:(QMapView *)mapView {
    //获取停止定位的状态

}

- (void)mapView:(QMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
 
    CLLocationCoordinate2D centerCoordinate = mapView.region.center;

    
    NSLog(@" regionDidChangeAnimated %f,%f",centerCoordinate.latitude, centerCoordinate.longitude);


}


- (void)mapView:(QMapView *)mapView didUpdateUserLocation:(QUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    //刷新位置

    [mapView setCenterCoordinate:CLLocationCoordinate2DMake(mapView.userLocation.location.coordinate.latitude, mapView.userLocation.location.coordinate.longitude) animated:YES];
    
    if (mapView.userLocation.location.coordinate.latitude > 0 &&  mapView.userLocation.location.coordinate.longitude ) {
        self.storeCoordinate = mapView.userLocation.location.coordinate;
    }
    
    
    CLGeocoder *geocoder = [CLGeocoder new];
    //反地理编码
    [geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error != nil || placemarks.count == 0) {
            return ;
        }
        //获取地标
        CLPlacemark *placeMark = [placemarks firstObject];
        //设置标题
        userLocation.title = [NSString stringWithFormat:@"%@%@",placeMark.locality, placeMark.subLocality];
        //设置子标题
        userLocation.subtitle = placeMark.name;
        
    
        
    }];
    

    
    

}


@end

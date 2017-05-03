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

@property (nonatomic, strong) NSArray *annotations;

@property (nonatomic, assign) BOOL isLocationSuccess;

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

- (void)mapViewWillStartLocatingUser:(QMapView *)mapView {
    //获取开始定位的状态
    NSLog(@"开始");
    
}

- (void)mapViewDidStopLocatingUser:(QMapView *)mapView {
    //获取停止定位的状态
     NSLog(@"结束");

}

- (void)mapView:(QMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    if (!_isLocationSuccess) {
        return;
    }
    
    
    CLLocationCoordinate2D centerCoordinate = mapView.region.center;

    
    NSLog(@" regionDidChangeAnimated %f,%f",centerCoordinate.latitude, centerCoordinate.longitude);
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:centerCoordinate.latitude longitude:centerCoordinate.longitude];
    
    CLGeocoder *geocoder = [CLGeocoder new];
    //反地理编码
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error != nil || placemarks.count == 0) {
            return ;
        }
        //获取地标
        CLPlacemark *placeMark = [placemarks firstObject];
        //设置标题
      
        if (location.coordinate.latitude > 0 && location.coordinate.longitude) {
       
            [_mapView removeAnnotations:_annotations];
            QPointAnnotation *annotation = [[QPointAnnotation alloc] init];
            annotation.title = [NSString stringWithFormat:@"%@%@",placeMark.locality, placeMark.subLocality];
            annotation.subtitle = placeMark.name;
            annotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude);
            
            
            
            _annotations = [NSArray arrayWithObjects: annotation, nil];
            [_mapView addAnnotations:_annotations];
            [_mapView viewForAnnotation:[_annotations objectAtIndex:0]].selected = YES;
        }
        
    }];

    
    

    

}


- (void)mapView:(QMapView *)mapView didUpdateUserLocation:(QUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    //刷新位置
     NSLog(@"刷新  %d",updatingLocation);

    
    if (userLocation.location.coordinate.latitude > 0 && userLocation.location.coordinate.longitude) {

       
    } else {
    
        return;
    }
    
    CLGeocoder *geocoder = [CLGeocoder new];
    //反地理编码
    [geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error != nil || placemarks.count == 0) {
            return ;
        }
        //获取地标
        CLPlacemark *placeMark = [placemarks firstObject];
//        //设置标题

        if (userLocation.location.coordinate.latitude > 0 && userLocation.location.coordinate.longitude) {
            _storeCoordinate = userLocation.location.coordinate;
            _mapView.showsUserLocation = NO;
            _isLocationSuccess = YES;
            [_mapView removeAnnotations:_annotations];
            QPointAnnotation *annotation = [[QPointAnnotation alloc] init];
            annotation.title = [NSString stringWithFormat:@"%@%@",placeMark.locality, placeMark.subLocality];
            annotation.subtitle = placeMark.name;
            annotation.coordinate = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
            
            
            NSLog(@"%@", placeMark.name);
            _annotations = [NSArray arrayWithObjects: annotation, nil];
            [_mapView addAnnotations:_annotations];
            [_mapView viewForAnnotation:[_annotations objectAtIndex:0]].selected = YES;

            
        }

    }];
    
    
        [mapView setCenterCoordinate:CLLocationCoordinate2DMake(mapView.userLocation.location.coordinate.latitude, mapView.userLocation.location.coordinate.longitude) animated:YES];
    
    
}

-(QAnnotationView *)mapView:(QMapView *)mapView
          viewForAnnotation:(id<QAnnotation>)annotation {
    static NSString *pointReuseIndentifier = @"pointReuseIdentifier";

    //添加默认pinAnnotation
    if ([annotation isEqual:[_annotations objectAtIndex:0]]) {
        
        QPinAnnotationView *annotationView = (QPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil) {
            annotationView = [[QPinAnnotationView alloc]
                              initWithAnnotation:annotation
                              reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout = YES;
     
        annotationView.selected = YES;

        annotationView.draggable = YES;
        return annotationView;
    }
    
    
 return nil;
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


@end

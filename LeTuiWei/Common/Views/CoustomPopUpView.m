//
//  CoustomPopUpView.m
//  弹窗demo
//
//  Created by 陈营超 on 2017/4/10.
//  Copyright © 2017年 陈营超. All rights reserved.
//

#import "CoustomPopUpView.h"
#import "PopUpTableViewCell.h"
@interface CoustomPopUpView() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIImageView *backImageView;

@property (nonatomic, strong) UIButton *centreButton;

@property (nonatomic, strong) UIButton *centreUpButton;

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UILabel *seperatorLabel;

@property (nonatomic, strong) UILabel *seperatorLabel1;

@property (nonatomic, strong) UILabel *verticalSeperatorLabel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UILabel *markLabel;


@end

@implementation CoustomPopUpView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8;
        self.clipsToBounds = YES;
    }
    return self;
}


#pragma mark  弹出带tableview的view
- (void)PopUpViewComponent:(PopUpViewType)type withTitle:(NSString *)title withDataScoure:(id)dataScoure {
    WS(weakSelf);
    [self.seperatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(@(kSeparatorHeight));
        make.top.equalTo(weakSelf.mas_top).offset([Theme paddingWithSize:96]);
    }];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset([Theme paddingWithSize20]);
        make.right.equalTo(weakSelf).offset(-[Theme paddingWithSize20]);
        make.width.equalTo(@([UIImage imageNamed:@"close"].size.width));
        make.height.equalTo(@([UIImage imageNamed:@"close"].size.height));
        
    }];

    self.titleLabel.text = self.title.length > 0 ? self.title : title;
    [self addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset([Theme paddingWithSize20]);
        make.right.equalTo(weakSelf.backImageView.mas_left).offset(-[Theme paddingWithSize20]);
        make.bottom.equalTo(weakSelf.seperatorLabel);
    }];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_tableView];
    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(weakSelf);
        make.top.equalTo(weakSelf).offset([Theme paddingWithSize:96]);
    }];
    
    [self addSubview:self.tableView];
    
    if (!self.dataSourceArray.count) {
        self.dataSourceArray = dataScoure;
    }

    [ATKeyWindow addSubview:self.maskView];
    [ATKeyWindow addSubview:self];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [Theme paddingWithSize:80];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self closeView];
  
    if (self.tabViewCellClickedBlock) {
        self.tabViewCellClickedBlock(indexPath);
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PopUpTableViewCell *cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:@"stores"];
    if (!cell) {
        cell = [[PopUpTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"stores"];

    }
        cell.contentLabel.text = self.dataSourceArray[indexPath.row];
    
    if (indexPath.row == self.dataSourceArray.count - 1) {
        [cell.seperatorLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(cell.contentView);
        }];
    }

    
      return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark 弹出普通的view

- (void)PopUpViewComponent:(PopUpViewType)type withTitle:(NSString *)title withContent:(NSString *)content andButtonType:(PopUpViewComponent)components {
    WS(weakSelf);
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset([Theme paddingWithSize20]);
        make.right.equalTo(weakSelf).offset(-[Theme paddingWithSize20]);
        make.width.equalTo(@([UIImage imageNamed:@"close"].size.width));
        make.height.equalTo(@([UIImage imageNamed:@"close"].size.height));
        
    }];

    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset([Theme paddingWithSize40]);
        make.right.equalTo(weakSelf).offset(-[Theme paddingWithSize40]);
        make.top.equalTo(weakSelf.backImageView.mas_bottom);
        make.bottom.equalTo(weakSelf.seperatorLabel.mas_top);
    }];
    
    [self.seperatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.height.equalTo(@(0.5));
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-[Theme paddingWithSize100]);
    }];
    
    if (type == PopUpViewTypeWithTextField) {
        self.contentLabel.hidden = YES;
        self.textField.placeholder = @"   请填写密码";
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset([Theme paddingWithSize40]);
            make.right.equalTo(weakSelf).offset(-[Theme paddingWithSize40]);
            make.top.equalTo(weakSelf.backImageView.mas_bottom).offset([Theme paddingWithSize28]);
            make.height.equalTo(@([Theme paddingWithSize:90]));
        }];
        
        self.markLabel.text = @"大小写字母、数字组成，不少于6位";
        [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf.textField);
            make.top.equalTo(weakSelf.textField.mas_bottom).offset([Theme paddingWithSize10]);
        }];
        
       
    }
    
    if (self.attributeContent.length > 0) {
        self.contentLabel.attributedText = self.attributeContent;
    } else {
        self.contentLabel.text = self.content.length ?self.content : content;
    }
    
    NSString *centreButtonTitle = self.centreButtonTitle.length ? self.centreButtonTitle : @"我知道了";
    
    NSString *centreUpButtonTitle = self.centreUpButtonTitle.length ? self.centreButtonTitle : @"知道了，我已购买";
    NSString *leftButtonTitle = self.leftButtonTitle.length ? self.leftButtonTitle : @"取消";
    NSString *rightButtonTitle = self.rightButtonTitle.length ? self.rightButtonTitle : @"确定";
    
    
    if (components & PopUpViewComponentCentreButton ) {
        
        [self.centreButton setTitle:centreButtonTitle forState:UIControlStateNormal];
        [self.centreButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf);
            make.top.equalTo(weakSelf.seperatorLabel.mas_bottom);
            make.left.equalTo(weakSelf);
            make.bottom.equalTo(weakSelf);
        }];
        [self.centreButton bk_whenTapped:^{
            if (weakSelf.centreButtonClickedBlock) {
                weakSelf.centreButtonClickedBlock(weakSelf.centreButton, weakSelf.textField.text);
            }
           
            [weakSelf closeView];
        }];
        
    }
    
    if (components & PopUpViewComponentLeftButton && components & PopUpViewComponentRightButton ) {
        [self.verticalSeperatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf);
            make.top.equalTo(weakSelf.seperatorLabel.mas_bottom);
            make.width.equalTo(@(kSeparatorHeight));
            make.bottom.equalTo(weakSelf);
        }];
        
        [self.leftButton setTitle:leftButtonTitle forState:UIControlStateNormal];
        [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf);
            make.top.equalTo(weakSelf.seperatorLabel.mas_bottom);
            make.right.equalTo(weakSelf.verticalSeperatorLabel.mas_right);
            make.bottom.equalTo(weakSelf);
            
        }];
        
        [self.rightButton setTitle:rightButtonTitle forState:UIControlStateNormal];
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf);
            make.top.equalTo(weakSelf.seperatorLabel.mas_bottom);
            make.left.equalTo(weakSelf.verticalSeperatorLabel.mas_left);
            make.bottom.equalTo(weakSelf);
            
        }];
        
        [self.leftButton bk_whenTapped:^{
            if (weakSelf.leftButtonClickedBlock) {
                weakSelf.leftButtonClickedBlock(weakSelf.leftButton);
            }
           
            [weakSelf closeView];
        }];
        
        [self.rightButton bk_whenTapped:^{
            if (weakSelf.rightButtonClickedBlock) {
                weakSelf.rightButtonClickedBlock(weakSelf.rightButton);
            }
       
            [weakSelf closeView];
        }];
    
    }
    
    if (components & PopUpViewComponentCentreButton && components & PopUpViewComponentCentreUpButton ) {
       
        [self.seperatorLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf);
            make.right.equalTo(weakSelf);
            make.height.equalTo(@(0.5));
            make.bottom.equalTo(weakSelf.mas_bottom).offset(-[Theme paddingWithSize:200]);
        }];
        
        
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset([Theme paddingWithSize40]);
            make.right.equalTo(weakSelf).offset(-[Theme paddingWithSize40]);
            make.top.equalTo(weakSelf.backImageView.mas_bottom);
            make.bottom.equalTo(weakSelf.seperatorLabel1.mas_top);
        }];
        
        [self.centreUpButton setTitle:centreUpButtonTitle forState:UIControlStateNormal];
        [self.centreUpButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf);
            make.top.equalTo(weakSelf.seperatorLabel1.mas_bottom);
            make.left.equalTo(weakSelf);
            make.bottom.equalTo(weakSelf.seperatorLabel.mas_bottom);
        }];
        [self.centreUpButton bk_whenTapped:^{
            
            if (weakSelf.centreUpButtonClickedBlock) {
                weakSelf.centreUpButtonClickedBlock(weakSelf.centreUpButton);
            }
            [weakSelf closeView];
        }];
        
        [self.centreButton setTitle:centreButtonTitle forState:UIControlStateNormal];
        [self.centreButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf);
            make.top.equalTo(weakSelf.seperatorLabel.mas_bottom);
            make.left.equalTo(weakSelf);
            make.bottom.equalTo(weakSelf);
        }];
        [self.centreButton bk_whenTapped:^{
            if (weakSelf.centreButtonClickedBlock) {
                weakSelf.centreButtonClickedBlock(weakSelf.centreButton, nil);
            }
            
            [weakSelf closeView];
        }];
        
        
    }
    
    
    [ATKeyWindow addSubview:self.maskView];
    [ATKeyWindow addSubview:self];

}




- (UIButton *)rightButton {
    if (!_rightButton) {
        
        _rightButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_rightButton setTitleColor:[Theme colorForAppearance] forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [Theme fontWithSize30];
        [self addSubview:_rightButton];
    }
    return _rightButton;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        
        _leftButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_leftButton setTitleColor:[Theme colorForAppearance] forState:UIControlStateNormal];
        _leftButton.titleLabel.font = [Theme fontWithSize30];
        [self addSubview:_leftButton];
    }
    return _leftButton;
}

- (UIButton *)centreUpButton {
    if (!_centreUpButton) {
        
        _centreUpButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_centreUpButton setTitleColor:[Theme colorForAppearance] forState:UIControlStateNormal];
        _centreUpButton.titleLabel.font = [Theme fontWithSize30];
        [self addSubview:_centreUpButton];
    }
    return _centreUpButton;
}

- (UIButton *)centreButton {
    if (!_centreButton) {
        
        _centreButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_centreButton setTitleColor:[Theme colorForAppearance] forState:UIControlStateNormal];
        _centreButton.titleLabel.font = [Theme fontWithSize30];
        [self addSubview:_centreButton];
    }
    return _centreButton;
}

- (UILabel *)seperatorLabel1 {
    
    if (!_seperatorLabel1) {
        _seperatorLabel1 = [[UILabel alloc] initWithFrame:CGRectZero];
        _seperatorLabel1.backgroundColor = [Theme colorBlackWithAlpha:0.3];
        [self addSubview:_seperatorLabel1];
    }
    return _seperatorLabel1;
}

- (UILabel *)seperatorLabel {
    
    if (!_seperatorLabel) {
        _seperatorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _seperatorLabel.backgroundColor = [Theme colorBlackWithAlpha:0.3];
        [self addSubview:_seperatorLabel];
    }
    return _seperatorLabel;
}

- (UILabel *)verticalSeperatorLabel {
    
    if (!_verticalSeperatorLabel) {
        _verticalSeperatorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _verticalSeperatorLabel.backgroundColor = [Theme colorBlackWithAlpha:0.3];
        [self addSubview:_verticalSeperatorLabel];
    }
    return _verticalSeperatorLabel;
}


- (UIImageView *)backImageView {
    WS(weakSelf);
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _backImageView.image = [UIImage imageNamed:@"close"];
        _backImageView.userInteractionEnabled = YES;
        [self addSubview:_backImageView];
        [self.backImageView bk_whenTapped:^{
            [weakSelf closeView];
        }];
    }
    return _backImageView;
}

- (UITextField *)textField {
    
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
        _textField.font = [Theme fontWithSize30];
        _textField.textColor = [Theme colorDarkGray];
        _textField.layer.borderWidth = 0.5;
        _textField.layer.borderColor = [Theme colorForSeparatorLine].CGColor;
        [self addSubview:_textField];
    }
    return _textField;
}


- (UILabel *)markLabel {
    
    if (!_markLabel) {
        _markLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _markLabel.font = [Theme fontWithSize24];
        _markLabel.textColor = [Theme colorDarkGray];
        [self addSubview:_markLabel];
    }
    return _markLabel;
}


- (UILabel *)contentLabel {
    
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [Theme fontWithSize28];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [Theme colorGray];
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}


- (UILabel *)titleLabel {

    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [Theme fontWithSize30];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = [Theme colorForAppearance];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}


- (void)closeView {
    [self.maskView removeFromSuperview];
    self.maskView = nil;
    [self removeFromSuperview];
}

- (void)tap:(UIGestureRecognizer *)gr {
    
    [self.maskView removeFromSuperview];
    self.maskView = nil;
    [self removeFromSuperview];
}

-(UIView *)maskView {

    if (!_maskView) {

        _maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_maskView addGestureRecognizer:tap];
        _maskView.userInteractionEnabled = YES;
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha =  0.4;

    }
    
    return _maskView;
}



@end

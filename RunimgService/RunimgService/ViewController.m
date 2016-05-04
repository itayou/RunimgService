//
//  ViewController.m
//  RunimgService
//
//  Created by lizq on 16/5/4.
//  Copyright © 2016年 lizq. All rights reserved.
//

#import "ViewController.h"

#import "RunimgService.h"



@interface ViewController ()
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UIButton *btn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imgView];
    [self.view addSubview:self.btn];
}

- (UIButton *)btn {
    if(!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btn setBackgroundColor:[UIColor grayColor]];
        _btn.layer.masksToBounds = YES;
        _btn.layer.cornerRadius = 5;
        [_btn setFrame:CGRectMake(30, 80, 100, 30)];
        [_btn setTitle:@"请求图片" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(clickRefreshButton2:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (UIImageView *)imgView {
    if(!_imgView) {
        _imgView = [[UIImageView alloc] init];
        [_imgView setFrame:self.view.bounds];
    }
    return _imgView;
}

- (void)clickRefreshButton2 :(UIButton *)btn {
    ImageOperator *imgOpt = [[ImageOperator alloc] init];
    [imgOpt setImageZoomWidth:1024 height:768 process:YES];
    NSLog(@"%@",[imgOpt toString]);
    UrlCreator *urlCreator = [[UrlCreator alloc] initWithTokenId:@"123456789ABCDEF0" tokenKey:@"0123456789ABCDEF" imageType:TYPE_4D expired:3600 imageOperator:imgOpt];
    NSLog(@"URL:\n%@",[urlCreator toUrlString]);
    [[RunimgService sharedInstance] getImageUrlWithUrlCreator:urlCreator successed:^(NSObject *object) {
        [self downloagImage:(UpdateStanza *)object];
    } failed:^(NSObject *object, NSError *error) {
        
    }];
}

- (void)downloagImage:(UpdateStanza *)updateStanza {
    Record *recode = nil;
    if(updateStanza.records.count > 0) {
        recode = [updateStanza.records objectAtIndex:0];
        [[RunimgService sharedInstance] getImageByUrl:recode.url successed:^(NSObject *object) {
            self.imgView.image = (UIImage *)object;
        } failed:^(NSObject *object, NSError *error) {
            
        }];
    }
    
}

@end

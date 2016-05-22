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
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)UIButton *btn;
@property(atomic,strong)  NSMutableArray *imageUrls;
@property(nonatomic,strong)NSMutableArray *imageOpts;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageUrls = [[NSMutableArray alloc] initWithCapacity:1];
    self.imageOpts = [[NSMutableArray alloc] initWithCapacity:1];
    [self.view addSubview:self.webView];
    [self testImageOperators];
}

- (UIWebView *)webView {
    if(!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    }
    return _webView;
}

#pragma  mark ---
#pragma  mark test 
- (void)testImageOperators {
    [self.imageUrls removeAllObjects];
    //imageZoonWidth:Hight:process
    ImageOperator *imgOpt = [[ImageOperator alloc] init];
    [imgOpt setImageZoomWidth:200 height:200 process:YES];
    [self.imageOpts addObject:@{@"method":@"setImageZoonWidth:hight:process",@"imgOpt":imgOpt}];
    //imageZoonWidth:Hight:process
    imgOpt = [[ImageOperator alloc] init];
    [imgOpt setImageZoomWidth:200 height:0 process:YES];
    [self.imageOpts addObject:@{@"method":@"setImageZoonWidth:200 hight:0 process",@"imgOpt":imgOpt}];
    //imageZoonWidth:Hight:process:
    imgOpt = [[ImageOperator alloc] init];
    [imgOpt setImageZoomWidth:0 height:200 process:YES];
    [self.imageOpts addObject:@{@"method":@"setImageZoonWidth:0 hight:200 process",@"imgOpt":imgOpt}];
    //imageZoomProportion:
    imgOpt = [[ImageOperator alloc] init];
    [imgOpt setImageZoomWidth:200 height:200 process:YES];
    [imgOpt setImageZoomProportion:1];
    [self.imageOpts addObject:@{@"method":@"setImageZoomProportion:",@"imgOpt":imgOpt}];
    //imageZoom:
    imgOpt = [[ImageOperator alloc] init];
    [imgOpt setImageZoomWidth:40 height:40 process:YES];
    [imgOpt setImageZoom:500];
    [self.imageOpts addObject:@{@"method":@"setImageZoom:",@"imgOpt":imgOpt}];
    //clipperWidth:Height:index
    imgOpt = [[ImageOperator alloc] init];
    [imgOpt setImageClipperWidth:200 height:200 index:4];
    [self.imageOpts addObject:@{@"method":@"setImageClipperWidth:height:index:",@"imgOpt":imgOpt}];
    //clipperRadius:type:
    imgOpt = [[ImageOperator alloc] init];
    [imgOpt setImageClipperRadius:200 type:1];
    [self.imageOpts addObject:@{@"method":@"setImageClipperRadius:type:",@"imgOpt":imgOpt}];
    //clipperChunk:direction:index
    imgOpt = [[ImageOperator alloc] init];
    [imgOpt setImageClipperChunk:200 direction:CLIPPER_Y index:3];
    [self.imageOpts addObject:@{@"method":@"setImageClipperChunk:direction:index:",@"imgOpt":imgOpt}];
    //clipperRectX:y:w:h:
    imgOpt = [[ImageOperator alloc] init];
    [imgOpt setimageClipperRectX:200 y:200 w:200 h:200];
    [self.imageOpts addObject:@{@"method":@"setImageClipperRectX:y:w:h:",@"imgOpt":imgOpt}];
    //imageRotation:
    imgOpt = [[ImageOperator alloc] init];
    [imgOpt setImageZoomWidth:200 height:200 process:NO];
    [imgOpt setImageRotation:180];
    [self.imageOpts addObject:@{@"method":@"setImageRotation:",@"imgOpt":imgOpt}];
    //imageSharpen:
    imgOpt = [[ImageOperator alloc] init];
    [imgOpt setImageZoomWidth:200 height:200 process:NO];
    [imgOpt setImageSharpen:100];
    [self.imageOpts addObject:@{@"method":@"setImageSharpen:",@"imgOpt":imgOpt}];
    //imageBlurryRadius:sigmal
    imgOpt = [[ImageOperator alloc] init];
    [imgOpt setImageZoomWidth:200 height:200 process:NO];
    [imgOpt setImageBlurryRadius:20 sigmal:20];
    [self.imageOpts addObject:@{@"method":@"setImageBlurryRadius:sigmal:",@"imgOpt":imgOpt}];
    //imageBrightness:
    imgOpt = [[ImageOperator alloc] init];
    [imgOpt setImageZoomWidth:200 height:200 process:NO];
    [imgOpt setImageBrightness:50];
    [self.imageOpts addObject:@{@"method":@"setImageBrightness:",@"imgOpt":imgOpt}];
    //imageContrast:
    imgOpt = [[ImageOperator alloc] init];
    [imgOpt setImageZoomWidth:200 height:200 process:NO];
    [imgOpt setImageContrast:50];
    [self.imageOpts addObject:@{@"method":@"setImageContrast:",@"imgOpt":imgOpt}];
    //JPGImageRelationQuality:
    imgOpt = [[ImageOperator alloc] init];
    [imgOpt setImageZoomWidth:200 height:200 process:NO];
    [imgOpt setJPGImageRelationQuality:90];
    [imgOpt setImageFormat:FORMAT_JPG];
    [self.imageOpts addObject:@{@"method":@"setJPGImageRelationQuality:",@"imgOpt":imgOpt}];
    //JPGImageAbsoluteQuality:
    imgOpt = [[ImageOperator alloc] init];
    [imgOpt setImageZoomWidth:200 height:200 process:NO];
    [imgOpt setJPGImageAbsoluteQuality:90];
    [imgOpt setImageFormat:FORMAT_JPG];
    [self.imageOpts addObject:@{@"method":@"setJPGImageAbsoluteQuality:",@"imgOpt":imgOpt}];
    //imageFormat:
    imgOpt = [[ImageOperator alloc] init];
    [imgOpt setImageZoomWidth:200 height:200 process:NO];
    [imgOpt setImageFormat:FORMAT_BMP];
    [self.imageOpts addObject:@{@"method":@"setImageFormat:",@"imgOpt":imgOpt}];
    
    [self testUrlRequest];
}

- (void)testUrlRequest {
    for(NSDictionary *imgOptDic in self.imageOpts) {
        ImageOperator *opt = imgOptDic[@"imgOpt"];
        UrlCreator *urlCreator = [[UrlCreator alloc] initWithTokenId:@"123456789ABCDEF0" tokenKey:@"0123456789ABCDEF" imageType:TYPE_4D expired:3600 imageOperator:opt];
        UpdateStanza *updateStanza = [[RunimgService sharedInstance] getImageUrlBase:BASE_URL urlCreator:urlCreator];
        if(updateStanza.records.count > 0) {
            Record *record = [updateStanza.records objectAtIndex:0];
            [self.imageUrls addObject:@{@"method":imgOptDic[@"method"],@"url":record.url}];
        }
    }
    [self transitionToHTML];
}

- (void)transitionToHTML {
    NSLog(@"\n%@\n",self.imageUrls);
    NSMutableString *htmls = [[NSMutableString alloc] init];
    [htmls appendFormat:@"<html><head></head><body>"];
    for(NSDictionary *dic in self.imageUrls) {
        NSString *url = dic[@"url"];
        if(url) {
            [htmls appendFormat:@"<br><br><font size=\"5\" color=\"green\">%@</font><br>",dic[@"method"]];
            [htmls appendFormat:@"<img src=\"%@\"><br><br>",url];
        }else {
            [htmls appendFormat:@"<br><br><font size=\"5\" color=\"red\">%@</font><br>",dic[@"method"]];
            [htmls appendFormat:@"image error:%@<br><br>",dic[@"error"]];
        }
    }
    [htmls appendFormat:@"</body><html>"];
    NSString *filePath = [NSString stringWithFormat:@"%@/RunimgHtml.html",NSHomeDirectory()];
    NSError *error = nil;
    //写入文件
    [htmls writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    [self.webView loadHTMLString:htmls baseURL:nil];
}

@end

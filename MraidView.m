//
//  MraidView.m
//  TestMraid
//
//  Created by caigee on 14-7-28.
//  Copyright (c) 2014年 caigee. All rights reserved.
//

#import "MraidView.h"
#import "mraidjs.h"
#import "MRAIDServiceDelegate.h"
#import "MRAIDParser.h"
//状态
typedef enum {
    MRAIDStateLoading,
    MRAIDStateDefault,
    MRAIDStateExpanded,
    MRAIDStateResized,
    MRAIDStateHidden
} MRAIDState;

@interface MraidView()<UIWebViewDelegate>
{
    MRAIDState state;
    BOOL isInterstitial;    //是否是插屏
    BOOL useCustomClose;
    MRAIDParser *mraidParser;
    
    UIWebView *webView;
    UIWebView *currentWebView;
}
@property (nonatomic, assign, getter = isViewable, setter = setIsViewable:) BOOL isViewable;
@property (nonatomic, unsafe_unretained) id<MRAIDServiceDelegate> serviceDelegate;


// hidden方法支持插屏广告
- (void)showAsInterstitial;

- (void)deviceOrientationDidChange:(NSNotification *)notification;

- (void)addCloseEventRegion;
- (void)showResizeCloseRegion;
- (void)removeResizeCloseRegion;
- (void)setResizeViewPosition;

- (void)injectJavaScript:(NSString *)js;
// 本地调用 marid.js 的事件,状态改变、错误事件、大小改变、视图可见
- (void)fireErrorEventWithAction:(NSString *)action message:(NSString *)message;
- (void)fireReadyEvent;
- (void)fireSizeChangeEvent;
- (void)fireStateChangeEvent;
- (void)fireViewableChangeEvent;

// 设置 mraid控件 大小
- (void)setDefaultPosition;
-(void)setMaxSize;
-(void)setScreenSize;

- (void)parseCommandUrl:(NSString *)commandUrlString;

@end

@implementation MraidView
@synthesize isViewable=_isViewable;

#pragma mark --Close Button--

-(void)setIsViewable:(BOOL)newIsViewable
{
    if(newIsViewable!=_isViewable){
        _isViewable=newIsViewable;
        [self fireViewableChangeEvent];
    }
}

-(BOOL)isViewable
{
    return _isViewable;
}

- (void)showAsInterstitial
{
//    [self expand:nil];
}
// 通知 mraid 转向
- (void)deviceOrientationDidChange:(NSNotification *)notification
{
    [self setScreenSize];
    [self setMaxSize];
}
// modalVC.view 右上角添加关闭按钮
- (void)addCloseEventRegion
{
    // 并绑定 close 事件
}

// resizeView 添加关闭按钮 resizeCloseRegion
- (void)showResizeCloseRegion
{
    // 绑定 closeFromResize 事件
}
- (void)removeResizeCloseRegion
{
    //[resizeCloseRegion removeFromSuperview];
    //移除 resizeView 上的按钮
}

//设置 resizeView 的位置
- (void)setResizeViewPosition
{
//    if (!CGRectEqualToRect(oldResizeFrame, newResizeFrame)) {
//        resizeView.frame = newResizeFrame;
//    }
}

- (void)close
{
    /** 
     移除关闭按钮
     移除modalVC
     给js传递size，viewable 事件
     state 改成hidden
     
     */
}
- (void)closeFromResize
{
    /**
     state 改成 defalue
     resizeview 删除
     */
}

#pragma mark --JS callBack--

- (void)createCalendarEvent:(NSString *)eventJSON
{
    
}

//这里面有大量的方法
- (void)expand:(NSString *)urlString
{
    
}

- (void)open:(NSString *)urlString
{
    
}

- (void)playVideo:(NSString *)urlString
{
    
}

- (void)resize{
    
}

#pragma mark --FireEvent--
- (void)injectJavaScript:(NSString *)js
{
    [currentWebView stringByEvaluatingJavaScriptFromString:js];
}
- (void)fireErrorEventWithAction:(NSString *)action message:(NSString *)message
{
    [self injectJavaScript:[NSString stringWithFormat:@"mraid.fireErrorEvent('%@','%@');", message, action]];
}
- (void)fireReadyEvent
{
    [self injectJavaScript:@"mraid.fireReadyEvent()"];
}
- (void)fireSizeChangeEvent
{
    [self injectJavaScript:[NSString stringWithFormat:@"mraid.setCurrentPosition(%d,%d,%d,%d);", 0, 0, 320, 50]];
}
- (void)fireStateChangeEvent
{
    NSArray *stateNames = @[
                            @"loading",
                            @"default",
                            @"expanded",
                            @"resized",
                            @"hidden",
                            ];
    NSString *stateName = stateNames[state];
    [self injectJavaScript:[NSString stringWithFormat:@"mraid.fireStateChangeEvent('%@');", stateName]];
}
- (void)fireViewableChangeEvent
{
    [self injectJavaScript:[NSString stringWithFormat:@"mraid.fireViewableChangeEvent(%@);", (self.isViewable ? @"true" : @"false")]];
}
#pragma mark --设置 mraid 控件大小--
// 设置 mraid控件 默认位置
- (void)setDefaultPosition
{
}
// 设置 mraid控件 最大位置
-(void)setMaxSize
{
}

// 设置 mraid控件 屏幕位置
-(void)setScreenSize
{
}

//解析命令
- (void)parseCommandUrl:(NSString *)commandUrlString
{
    NSDictionary *commandDict = [mraidParser parseCommandUrl:commandUrlString];
    if (!commandDict) {
        
    }
    
    NSString *command = [commandDict valueForKey:@"command"];
    NSObject *paramObj = [commandDict valueForKey:@"paramObj"];
    
    SEL selector = NSSelectorFromString(command);
    
    // Turn off the warning "PerformSelector may cause a leak because its selector is unknown".
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    
    [self performSelector:selector withObject:paramObj];
    
#pragma clang diagnostic pop
}

#pragma mark --初始化视图--
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        mraidParser = [[MRAIDParser alloc]init];
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
        webView.delegate = self;
        currentWebView = webView;
        [self initWebView:webView];
        [self addSubview:webView];
        
        webView.backgroundColor = [UIColor grayColor];
        state = MRAIDStateLoading;
        _isViewable = NO;
        useCustomClose = NO;
        
        // 检测支持的本地操作
        
        [self loadWebView];
    }
    return self;
}

// 加载html
-(void)loadWebView
{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"test" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    [webView loadHTMLString:htmlString baseURL:nil];
    
}

// 添加 js
-(void)initWebView:(UIWebView *)vv
{
    
    NSData* mraidJSData = [NSData dataWithBytesNoCopy:__sourcekit_mraid_ios_mraid_js
                                               length:__sourcekit_mraid_ios_mraid_js_len
                                         freeWhenDone:NO];
    NSString * mraidjs = [[NSString alloc] initWithData:mraidJSData encoding:NSUTF8StringEncoding];
    
    if (mraidjs) {
        [webView stringByEvaluatingJavaScriptFromString:mraidjs];
    }
    
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    NSString *scheme = [url scheme];
    NSString *myStr = [url absoluteString];
    // 替换掉%xx这种格式的字符
    NSString *absUrlString = [myStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    if ([scheme isEqualToString:@"mraid"]) {
        [self parseCommandUrl:absUrlString];
        return NO;
    } else if ([scheme isEqualToString:@"console-log"]) {
        return NO;
    } else if ([scheme isEqualToString:@"tel"]) {
        [self.serviceDelegate mraidServiceCallTelWithUrlString:absUrlString];
        
        return NO;
    }  else if ([scheme isEqualToString:@"sms"]) {
        [self.serviceDelegate mraidServiceSendSmsWithUrlString:absUrlString];
        return NO;
    }
    
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)_webView
{
    if (state == MRAIDStateLoading) {
        state = MRAIDStateDefault;
        [self injectJavaScript:[NSString stringWithFormat:@"mraid.setPlacementType('%@');", (isInterstitial ? @"interstitial" : @"inline")]];
        [self fireStateChangeEvent];
        [self fireReadyEvent];
    }
}



@end

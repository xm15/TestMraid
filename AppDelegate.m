//
//  AppDelegate.m
//  TestMraid
//
//  Created by caigee on 14-7-28.
//  Copyright (c) 2014年 caigee. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    RootVC *root = [[RootVC alloc]init];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.rootViewController = root;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//if (mraid.getState() != 'ready'){
//    mraid.addEventListener('ready',loadAndDisplayAd)
//    alert("add ready listener");
//}else{
//    loadAndDisplayAd();
//    alert("do displayAd");
//}
//function loadAndDisplayAd(){
//    //加载图片
//    var img = document.getElementById("demo");
//    img.src = @"http://rm.lomark.cn/Upload/AdMaterials/9ba093daf5c54ddd83f7ea17cf79d81f_640X100.jpg";
//    alert("src laod");
//    
//}
//
//function testViewable(){
//    setTimeout(isViewable,1000);
//}
//
//function isViewable() {
//    var msg = "This ad is on the screen!";
//    var viewable = mraid.isViewable();
//    if (viewable) {
//        alert(msg);
//    } else {
//        alert("Ad off screen");
//    }
//}

@end

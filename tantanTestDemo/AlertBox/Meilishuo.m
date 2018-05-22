//
//  Meilishuo.m
//  Meilishuo
//
//  Created by Gao Lei on 6/16/11.
//  Copyright 2011 Meilishuo, Inc. All rights reserved.
//

#import "Meilishuo.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation Meilishuo

void openUrlIos9OrAbove(NSURL *url)
{
    /*IOS10OrAbove
     {
     NSDictionary *options = @{UIApplicationOpenURLOptionUniversalLinksOnly : @YES};
     [[UIApplication sharedApplication] openURL:url options:options completionHandler:nil];
     }
     else{
     [[UIApplication sharedApplication] openURL:url];
     }*/
    UIApplication *application = [UIApplication sharedApplication];
    if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
        if (@available(iOS 10.0, *)) {
            [application openURL:url options:@{}
               completionHandler:^(BOOL success) {
                   NSLog(@"Open %@: %d",url,success);
               }];
        } else {
            // Fallback on earlier versions
        }
    } else {
        BOOL success = [application openURL:url];
        NSLog(@"Open %@: %d",url,success);
    }
}

#pragma mark -
#pragma mark Class methods

+ (Meilishuo *)sharedInstance {
    static Meilishuo *shared;
    if (shared == nil) {
        shared = [[Meilishuo alloc] init];
    }
    return shared;
}

//+ (NSString *)udid {
//    UIDevice *device = [UIDevice currentDevice];
//    if ([device respondsToSelector:@selector(uniqueIdentifier)]) {
//        return [device uniqueIdentifier];
//    }
//    else {
//        return nil;
//    }
//}

+ (BOOL)isRetina {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(currentMode)] &&
        [UIScreen mainScreen].currentMode.size.width == 640
        ) 
    {
        return YES;
    }
    else {
        return NO;
    }
}

+ (NSURL *)appstoreURL
{
    return [NSURL URLWithString:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=467311880&mt=8"];
}

+ (NSURL *)ratingURL
{
    return [NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=467311880"];
}

+ (CGFloat)screenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)screenHeightWithoutStatusBar
{
    return [UIScreen mainScreen].bounds.size.height - 20;
}

+ (CGFloat)screenHeightWithoutNavigationBar
{
    return [UIScreen mainScreen].bounds.size.height - 20 - 44;
}

+ (CGFloat)screenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

+ (void)openURL:(NSURL *)URL
{
    if ([URL.scheme isEqualToString:@"futuretrader"]) {
    }
    else if ([[UIApplication sharedApplication] canOpenURL:URL]) {
        openUrlIos9OrAbove(URL);
    }
}

+ (float)getSystemVersion {
    float version = 0;
    
    NSString *versionStr = [[UIDevice currentDevice] systemVersion];
    version = [versionStr floatValue];
    
    return version;
}

@end

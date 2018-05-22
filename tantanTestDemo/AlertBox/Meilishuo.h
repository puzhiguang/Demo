//
//  Meilishuo.h
//  Meilishuo
//
//  Created by Gao Lei on 6/16/11.
//  Copyright 2011 Meilishuo, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Main interface to interact with the Meilishuo data API. It provides methods
// to create API requests easily, and deals with the access token mess.
//
// Note that you will almost never need to create an instance of this class
// manually, since the most commonly used methods can be accessed through class
// methods. And, if you do need to call instance methods, use the shared
// instance.
@interface Meilishuo : NSObject{
}

// Get the singleton instance shared across the application.
+ (Meilishuo *)sharedInstance;

// Add a request to the queue waiting for access token. When an access token is
// received, the request will be fired with the token set immediately.
// Get udid
//+ (NSString *)udid;

//get ios version
+ (float)getSystemVersion;

+ (BOOL)isRetina;

+ (NSURL *)appstoreURL;
// 
+ (NSURL *)ratingURL;

+ (CGFloat)screenHeight;
+ (CGFloat)screenHeightWithoutStatusBar;
+ (CGFloat)screenHeightWithoutNavigationBar;
+ (CGFloat)screenWidth;


+ (void)openURL:(NSURL *)URL;

@end

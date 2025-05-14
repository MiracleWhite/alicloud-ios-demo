//
//  CommonTools.m
//  mpush_ios_demo
//
//  Created by Miracle on 2025/5/13.
//  Copyright © 2025 alibaba. All rights reserved.
//

#import "CommonTools.h"

@implementation CommonTools

+ (void)userDefaultSetObject:(id)value forKey:(NSString *)key {
    if (key) {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (id)userDefaultGet:(NSString *)key {
    if (key) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    }
    return nil;
}

+ (BOOL)textFiledIsEmpty:(UITextField *)textFiled {
    if (textFiled.text == nil || [textFiled.text length] == 0) {
        return YES;
    }
    return NO;
}

+ (void)showTitle:(NSString *)title message:(NSString *)message handle:(void (^ __nullable)(UIAlertAction *action))handler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handler];
    [alert addAction:action];
    [[self getCurrentViewController] presentViewController:alert animated:YES completion:nil];
}

+ (UIViewController *)getCurrentViewController {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self getVisibleViewControllerFrom:rootViewController];
}

+ (UIViewController *)getVisibleViewControllerFrom:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self getVisibleViewControllerFrom:((UINavigationController *)vc).visibleViewController];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self getVisibleViewControllerFrom:((UITabBarController *)vc).selectedViewController];
    } else if (vc.presentedViewController) {
        return [self getVisibleViewControllerFrom:vc.presentedViewController];
    } else {
        return vc;
    }
}

@end

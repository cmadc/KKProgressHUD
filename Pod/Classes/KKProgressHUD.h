//
//  KKProgressHUD.h
//  kakatrip
//
//  Created by caiming on 16/9/20.
//  Copyright © 2016年 kakatrip. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface KKProgressHUD : MBProgressHUD

+ (void)showMBProgressAddTo:(UIView*)aView message:(NSString *)message;
+ (void)showMBProgressAddTo:(UIView*)aView;//显示loading
+ (void)hideMBProgressForView:(UIView*)aView;//隐藏HUD
+ (void)showSuccessAdd:(UIView *)aView message:(NSString *)message;//成功提示
+ (void)showErrorAddTo:(UIView *)aView message:(NSString *)message;//失败提示
+ (void)showReminder:(UIView *)aView message:(NSString *)message __attribute__((deprecated("此方法已弃用,请使用showSuccessAdd:message: or showErrorAddTo:message:方法")));


@end

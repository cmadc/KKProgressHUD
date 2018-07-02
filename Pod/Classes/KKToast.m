//
//  KKToast.m
//  Common
//
//

#import "KKToast.h"
#import <QuartzCore/QuartzCore.h>
#if __has_include("BaseViewController.h")
#import "BaseViewController.h"
#define THEBaseViewController       BaseViewController
#elif __has_include(<MJBaseViewController.h>)
#define THEBaseViewController       MJBaseViewController
#else
#define THEBaseViewController       UIViewController
#endif
#if __has_include(<MJWindowRootViewController.h>)
#import <MJWindowRootViewController.h>
#define THEWindowRootViewController       MJWindowRootViewController
#else
#define THEWindowRootViewController       THEBaseViewController
#endif

static KKToast *s_KKToast = nil;

#define DEFAULT_BOTTOM_PADDING 1    // 50
#define START_DISAPPEAR_SECOND 2.0
#define DISAPPEAR_DURATION 1.0

// toast所依附的window
UIWindow *s_toastWindows = nil;

const CGFloat KKToastTextPadding     = 20;
const CGFloat KKToastLabelWidth      = 200;
const CGFloat KKToastLabelHeight     = 160;

static float totalTimeCount = 10 * DISAPPEAR_DURATION;

@interface KKToast()

@property (nonatomic, copy) NSString *strToast;
@property (nonatomic, strong) UILabel *lblToast;
@property (nonatomic, strong) UIImageView *lblToastBG;
@property (nonatomic, strong) UIImageView *lblToastTips;
@property (nonatomic, assign) NSTimer *disappearTimer;
@property (nonatomic, assign) NSTimer *disappearingTimer;
@property (nonatomic, assign) int curToastState;        // 0:不显示;1:显示;2:正在消失
@property (nonatomic, assign) float curTimeCount;         // 当前倒计时
@property (nonatomic, strong) UIFont *textFont;


+ (KKToast *)sharedInstance;

- (id)initWithText:(NSString *)text;    

@end

@implementation KKToast


+ (UIWindow *)tostWindow
{
    if (s_toastWindows == nil) {
        s_toastWindows = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [s_toastWindows setBackgroundColor:[UIColor clearColor]];
        s_toastWindows.windowLevel = 10000000 + 1;
        THEWindowRootViewController *aVC = [[THEWindowRootViewController alloc] init];
        aVC.view.hidden = YES;
        [s_toastWindows setRootViewController:aVC];
        [s_toastWindows setUserInteractionEnabled:NO];
        [s_toastWindows makeKeyAndVisible];
    }
    return s_toastWindows;
}

+ (KKToast *)sharedInstance
{
    if (s_KKToast == nil) {
        s_KKToast = [[KKToast alloc] init];
        
    }
    return s_KKToast;
}


- (id)initWithText:(NSString *)text
{

    if (self = [super init])
    {
        self.strToast = text;
    }
    return self;
}

- (UILabel *)lblToast
{
    if (!_lblToast) {
        
        UILabel *lblPg = [[UILabel alloc]initWithFrame:CGRectZero];
        lblPg.textColor = [UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1];
        lblPg.numberOfLines = 0;
        lblPg.font = self.textFont;
        lblPg.textAlignment = NSTextAlignmentCenter;
        _lblToast = lblPg;
        
    }
    return _lblToast;
}

- (UIFont *)textFont
{
    if (!_textFont) {
        _textFont  = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    }
    return _textFont;
}

- (UIImageView *)lblToastBG
{
    if (!_lblToastBG) {
        
        _lblToastBG = [[UIImageView alloc]init];
        UIImage *image = [UIImage imageNamed:@"Rectangle"];
        _lblToastBG.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20) resizingMode:UIImageResizingModeTile];

        [_lblToastBG addSubview:self.lblToast];
        [_lblToastBG addSubview:self.lblToastTips];
    }
    return _lblToastBG;
}

- (UIImageView *)lblToastTips
{
    if (!_lblToastTips) {
        
        _lblToastTips = [[UIImageView alloc]initWithFrame:CGRectMake(21, 24, 15, 15)];
        _lblToastTips.image = [UIImage imageNamed:@"toastErrorTips"];
    }
    
    return _lblToastTips;
}

+ (KKToast *)makeToast:(NSString *)text
{
    KKToast *aToast = [KKToast sharedInstance];
    aToast.strToast = text;
    return aToast;
}


+ (KKToast *)makeErrorToast:(NSString *)text
{
    KKToast *aToast = [self makeToast:text];
    aToast.lblToastTips.image = [UIImage imageNamed:@"toastErrorTips"];
    return aToast;
}


+ (KKToast *)makeSucessToast:(NSString *)text
{
    KKToast *aToast = [self makeToast:text];
    aToast.lblToastTips.image = [UIImage imageNamed:@"toastSuccessTips"];
    return aToast;
}




- (void)show
{
    if([self.strToast isEqualToString:@""]) {
        
        return;
    }
    
    CGFloat KKLabelWidth  = [UIScreen mainScreen].bounds.size.width-106;
    CGSize textSize = [_strToast boundingRectWithSize:CGSizeMake(KKLabelWidth, KKToastLabelHeight)
                                              options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                           attributes:@{NSFontAttributeName:self.textFont}
                                              context:nil].size;
    
    self.lblToast.frame = CGRectMake(46, 23, textSize.width, textSize.height);
    self.lblToast.text = self.strToast;
    
    UIWindow *window = [KKToast tostWindow];

    if(self.lblToastBG.superview) {
        if (self.lblToastBG.superview != window) {
            [self.lblToastBG removeFromSuperview];
            [window addSubview:self.lblToastBG];
        }
    } else {
        [window addSubview:self.lblToastBG];
    }
    self.lblToastBG.frame = CGRectMake(0, 0, textSize.width+66, textSize.height+46);//136,78
    CGFloat windowCenterX = window.center.x;
    CGFloat centerX = windowCenterX;
    CGFloat centerY = window.center.y;
    
    self.lblToastBG.center = CGPointMake(centerX, centerY);
    self.lblToastBG.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin|
                                      UIViewAutoresizingFlexibleRightMargin|
                                      UIViewAutoresizingFlexibleTopMargin);
    
    self.lblToastTips.center =  CGPointMake(self.lblToastTips.center.x, textSize.height/2+23);
    if (_curToastState == 2) {
        [_disappearingTimer invalidate];
        self.disappearingTimer = nil;
    } else if (_curToastState == 1) {
        [_disappearTimer invalidate];
        self.disappearTimer = nil;
    }
    _curToastState = 0;
    [self.lblToastBG setAlpha:1];
    self.disappearTimer = [NSTimer scheduledTimerWithTimeInterval:START_DISAPPEAR_SECOND target:self selector:@selector(toastDisappear:) userInfo:nil repeats:NO];
    _curToastState = 1;
}

- (void)toastDisappear:(NSTimer *)timer
{
    [self.disappearTimer invalidate];
    self.disappearTimer = nil;
    _curTimeCount = totalTimeCount;
    self.disappearingTimer = [NSTimer scheduledTimerWithTimeInterval:1/60.0 target:self selector:@selector(startDisappear:) userInfo:nil repeats:YES];
    _curToastState = 2;
}

- (void)startDisappear:(NSTimer *)timer
{
    if (_curToastState == 0) {
        [self.disappearingTimer invalidate];
        self.disappearingTimer = nil;
        return;
    }
    if (_curTimeCount >= 0) {
        [self.lblToastBG setAlpha:_curTimeCount/totalTimeCount];
        _curTimeCount--;
    } else {
        [self.lblToastBG removeFromSuperview];
        [self.disappearingTimer invalidate];
        self.disappearingTimer = nil;
        _curToastState = 0;
        s_toastWindows = nil;
    }
}

@end

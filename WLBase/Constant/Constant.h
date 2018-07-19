//
//  Constant.h
//  WLBase
//
//  Created by 雷王 on 17/2/24.
//  Copyright © 2017年 WL. All rights reserved.
//

#ifndef Constant_h
#define Constant_h
#import "MobileData.h"
#import "DynamicForwardBtn.h"
#import "UIImageView+WebCache.h"
#import "UIIMage+Empress.h"
#import "IATConfig.h"
#import "MBProgressHUD+ZH.h"
//推送需要的
#define JPUSH_APPKEY @"cd27f62653b5a16d73f87489"
#define PACKAGE_CHINNLE @"AppStore"
//科大讯飞语音APPID
#define APPID_VALUE           @"5b166703"

//收到远程通知，点击推送栏，从后台到前台
#define KReceivedRemoteNotificationFromBackgroundToForegroundNotification @"KReceivedRemoteNotificationFromBackgroundToForegroundNotification"

//第三方
//微信
#define WEIXIN_APPKEY           @"wx3b2c5c1d75784585"
//#define WEIXIN_WEIXINSECRET     @"d1d5265e39e656d771cdf788d74c077a"
#define WEIXIN_WEIXINSECRET     @"bccb868b1e97af5d470784905f8212ee"


#define kAskOpenPhotosTip @"请允许\"小智\"访问照片"
#define kAskOpenCameroTip @"请允许\"小智\"访问相机"
#define kOpenPhotosTip @"开启 [访问照片]"
#define kOpenCameroTip @""
#define kAllowVisitorPhotosTip @"请到系统“设置”-“隐私”-“照片”中，允许“小智”访问照片"
#define kAllowVisitorCameroTip @"请到系统“设置”-“隐私”-“相机”中，允许“小智”访问相机"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height


/**登录成功通知 */
#define KLoginSuccessfulNotification @"KLoginSuccessfulNotification"
#define KLoginFailNotification @"KLoginFailNotification"
#define KLoginFailWithUserNameOrPassordIsNotRightNotification @"KLoginFailWithUserNameOrPassordIsNotRightNotification"
#define kPhoneNumIsNotRightTip @"手机号无效"

#pragma mark -- 颜色
#define UIColorFromRGB(rgbValue,alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

#pragma mark -- tabbar 字体的颜色
#define WLTabbarNormalColor UIColorFromRGB(0x808080, 1.0)
//#define WLTabbarSelectedColor UIColorFromRGB(0xff7f00, 1.0)
#define WLTabbarSelectedColor ( [UIColor colorWithRed:41.0/255.0f green:177.0/255.0f blue:252/255.0f alpha:1.0] )

#define SeperatorLineTag ( 0x000035890 )

#pragma mark -- 系统版本号
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)
#define BelowIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)

#define IOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
#define IOS11 ([[[UIDevice currentDevice] systemVersion] floatValue]>=11.0)

#define UIButton BlockButton


// 4.是否为5.5inch
#define ThreePointFiveInch ([UIScreen mainScreen].bounds.size.height == 480)
#define fourInch ([UIScreen mainScreen].bounds.size.height == 568)
#define fiveInch ([UIScreen mainScreen].bounds.size.height == 667)
#define sixInch ([UIScreen mainScreen].bounds.size.height == 736)
#define xInch ([UIScreen mainScreen].bounds.size.height == 812)

#define IPHONE5 [UIScreen mainScreen].bounds.size.height > 500

#define isI6Plus ([UIScreen mainScreen].bounds.size.height == 736)
#define isI6 ([UIScreen mainScreen].bounds.size.height == 667)
#define isI5 ([UIScreen mainScreen].bounds.size.height == 568) || ([UIScreen mainScreen].bounds.size.height == 480)
#define isI4 ( [UIScreen mainScreen].bounds.size.height == 480 )

#define isMoreWidthThanI6 ([UIScreen mainScreen].bounds.size.width > 375)
#define KGetSizeFromFourScreen(i4value, i5value, i6value, i6plusvalue) ( isI4 ? ( i4value ) : ( isI5 ? i5value : (isI6 ? i6value : i6plusvalue ) ) )//（ isI4 ? i4value : ( ( isI5 ? i5value : (isI6 ? i6value : i6plusvalue ) ) ) ）

#define KGetSizeFromScreen(i5value, i6value, i6plusvalue) ( isI5 ? i5value : (isI6 ? i6value : i6plusvalue ) )



//屏幕的高和宽
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width


//适配x
//#define XCStatusBar ([UIScreen mainScreen].bounds.size.height==812?145:64)
#define XCStatusBar ([UIScreen mainScreen].bounds.size.height==812?105:64)
#define XCStatusBar2 ([UIScreen mainScreen].bounds.size.height==812?88:64)

#define XCTbaBar ([UIScreen mainScreen].bounds.size.height==812?29:49)

//适配屏幕尺寸
#define XCCGRectMake(x,y,w,h) CGRectMake(x, y, w*WIDTH/320, h*HEIGHT/568)

#define kNavHeight  ([UIScreen mainScreen].bounds.size.height==812?105:64)
//#define TabBarHeight 49
#define TabBarHeight ([UIScreen mainScreen].bounds.size.height==812?84:49)
#define TITLEVIEWHEIGHT 44
#define StatusBarHeight ( [[[UIDevice currentDevice] systemVersion] floatValue] <7.0 ? 0 : 20 )

#define BarBtnWidth ( 73 )
#define SectionHeaderHeight ( 30/2 )

#define kCommonTableHeaderHeight (36.0)
#define kServiceTopBannerHeight 53

#define KDefaultTransparentNavBarViewHeight ( HEIGHT - StatusBarHeight  )
//#define KDefaultViewHeight ( HEIGHT - TITLEVIEWHEIGHT - StatusBarHeight )
#define KDefaultViewHeight ( HEIGHT - XCStatusBar )

#define KDefaultTransparentNavBarViewFrame ( CGRectMake(0, 0, WIDTH, KDefaultTransparentNavBarViewHeight) )
#define KDefaultViewFrame ( CGRectMake(0, 0, WIDTH, KDefaultViewHeight) )

//计算字符串size
#define XCsizeWithFont(value,font) [value sizeWithAttributes:@{NSFontAttributeName : font}]

#define WLsize(value) (value/375.0*WIDTH)

#define KGetViewToppestYPosition(value) (value.frame.origin.y)
#define KGetViewLeftestXPosition(value) (value.frame.origin.x)

#define KGetViewRightestXPosition(value) ( value.frame.origin.x + value.frame.size.width )
#define KGetViewBottomestYPosition(value) ( value.frame.origin.y + value.frame.size.height )

#define KConvertAllObjectToStrOrNil(value)  ( ([value isKindOfClass:[NSNull class]] || value == nil || value == Nil) ? nil : [NSString stringWithFormat:@"%@", ( value )] )

#define KConvertAllToStr(value) [NSString stringWithFormat:@"%@", ( value )]

//如果为null给其负值为@""
#define KConvertAllNULLObjectToStrEmpty(value) ( ([value isKindOfClass:[NSNull class]] || value == nil || value == Nil ) ?[NSString stringWithFormat:@"%@",@""]  : [NSString stringWithFormat:@"%@", ( value )] )

#define KSafelySettingJsonString(X)  ( [ ( X ) isKindOfClass:[NSNull class]] ? @"" : ( X ) )

//tableview 是否需要下啦刷新（待完善）
#define KIsTableViewNeedFootRefreshing( tableView ) ( tableView.contentSize.height > tableView.bounds.size.height )

//获取一行文字的宽度
#define KGetTextWidthOfOneLineWithFontSize( string,fontValue ) ( [string getTextWidthAndHeightWithFont:fontValue withWidth:999999].size.width )

//获取一行粗体文字的宽度
#define KGetTextWidthOfOneLineWithBoldFontSize( string,fontValue ) ( [string getTextWidthAndHeightWithBoldFont:fontValue withWidth:999999].size.width )

#define KSeparatorLineHeight ( KGetSizeFromScreen(1/2.0f, 1/2.0f, 1/3.0f) )
//#define KSeparatorLineColor ( UIColorFromRGB(0xd9d9d9, 1.0) )
#define KSeparatorLineColor ( UIColorFromRGB(0xF7F7F7, 1) )

#define LineColor ( KSeparatorLineColor )

//颜色
//#define DEFAULT_BackgroundView_COLOR UIColorFromRGB(0xefefef, 1.0)
#define DEFAULT_BackgroundView_COLOR  [UIColor colorWithRed:246/255.0f green:246/255.0f blue:247/255.0f alpha:1.0]


#define DEFAULT_TEXT_COLOR UIColorFromRGB(0x999999, 1)
#define DEFAULT_TEXT_COLOR_NUMBER UIColorFromRGB(0x666666, 1)

#define DEFAULT_BUTTON_TWO_COLOR  UIColorFromRGB(0xff7f00, 1.0)
#define DEFAULT_BUTTON_COLOR      UIColorFromRGB(0xff7f00, 1.0)

#define KDefaultTitleViewTitleColor ( UIColorFromRGB(0x333333, 1.0) )
#define KDefaultTitleViewTitleFont ( [UIFont systemFontOfSize:36/2] )
#define KDefaultTitleViewBgColor ( [UIColor whiteColor] )


#define UIColorFromInt(redValue, greenValue, blueValue, alphaValue) [UIColor colorWithRed:(redValue)/255.0f green:(greenValue)/255.0f blue:(blueValue)/255.0f alpha:(alphaValue)]

#define UIColorFromRGB(rgbValue,alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

#define KNormalNavBarBgColor ( [UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0f alpha:1.0] )

#define COLOR_TEXT_GREEN [UIColor colorWithRed:0.1059f green:0.7294f blue:0.0824f alpha:1.0f]

#define COLOR_TEXT_GRAY [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0f]


#define COLOR_ORANGE UIColorFromRGB(0xff7f00, 1.0)

#define COLOR_TABBAR_NORMAL UIColorFromRGB(0x808080, 1.0)
#define COLOR_TABBAR_Selected COLOR_ORANGE


#define COLOR_LIGHTGREEN UIColorFromRGB(0x13caaa, 1.0)
#define COLOR_BTN_GREEN UIColorFromRGB(0x1dbdf2, 1.0)
#define COLOR_BTN_WHITE UIColorFromRGB(0xffffff, 1.0)
#define COLOR_LableTimer_TestCode UIColorFromRGB(0x999999, 1.0)
#define COLOR_LableTip_TestCode UIColorFromRGB(0xb0b0b0, 1.0)
#define COLOR_LablePhone_TestCode UIColorFromRGB(0xff7f00, 1.0)

#define COLOR_Register_AgreementTitleGray UIColorFromRGB(0xb0b0b0, 1.0)
#define COLOR_SmsCodeTipGray UIColorFromRGB(0xb0b0b0, 1.0)
#define COLOR_SmsCodeTipRed UIColorFromRGB(0xef2d2a, 1.0)
#define COLOR_LoginPlaceHolderString UIColorFromRGB(0xd9d9d9, 1.0)

#define COLOR_Black UIColorFromRGB(0x333333, 1.0)
#define COLOR_Black_TextGray UIColorFromRGB(0x999999, 1.0)
#define COLOR_Gray_placeHoderLight UIColorFromRGB(0xD9D9D9, 1.0)

#define COLOR_VeryLightGray UIColorFromRGB(0xefefef, 1.0)
#define COLOR_grayRotPageControl UIColorFromRGB(0xe5e5e5, 1.0)
#define COLOR_SeviceFamilyClearMidBottomBg UIColorFromRGB(0xf8f8f8, 1.0)

#define MoveViewLineColor UIColorFromRGB(0xff7f00,1.0)
#define NameViewTextColor UIColorFromRGB(0x666666,1.0)
#define GrayViewTextColor UIColorFromRGB(0x999999,1.0)
#define CauseDetailTextColor UIColorFromRGB(0x333333,1.0)

#define COLOR_AddNewAddressBg UIColorFromRGB(0xf5f5f5,1.0)
//section背景色，字体颜色及大小
#define kGroupSectionBgColorCommon DEFAULT_BackgroundView_COLOR
#define kGroupSectionTextColorCommon COLOR_Black_TextGray
#define kGroupSectionTextFontSizeCommon 13
#define kGroupSectionHeight 34
#define kGroupSectionLableY 13
//字体
#define Font_TEXTFIELDPALCEHOLDER [UIFont boldSystemFontOfSize:18];

#define Font_Btn_Login [UIFont systemFontOfSize:18]
#define Font_LablePhone_TestCode [UIFont systemFontOfSize:14]
#define Font_LableTimer_TestCode [UIFont systemFontOfSize:14]

#define Font_LoginPlaceHolder [UIFont systemFontOfSize:14]

#define BaseServer ( [ServerHostName shareInstance].baseServerUrl )

#define Font_LoginTxtLeftTitle [UIFont systemFontOfSize:16]

#define Font_RegisterAgreementLeftTitle [UIFont systemFontOfSize:14]

#define SystemFont( size ) ( [UIFont systemFontOfSize:size] )
#define SystemBoldFont( size ) ( [UIFont boldSystemFontOfSize:size] )

#define ColorLine_Height 1
#define GrayLine_Alpha 0.5
#define GrayLine_Height KSeparatorLineHeight
#define kMineTopLabelRatio 0.6
#define Btn_CornerRadius 4
#define PaddingVertical 15
#define PaddinghHorizontal 15
#define PaddingInLeft 15
#define arrowRightWidth ([UIImage imageNamed:@"arrow"].size.width)
#define arrowRightHeight ([UIImage imageNamed:@"arrow"].size.height)

#define XCPhotosMaxCols 3
#define XCPhotoWidth 51
#define XCPhotoHeight XCPhotoWidth
#define XCPhotoMagin 9

#define kBtnLimitBuyWidth 65
#define kBtnLimitBuyHeight 17

#ifdef KSupportWebp
#define GetWebpImageVersion( value ) ( [NSString stringWithFormat:@"%@.webp", value] )
#else
#define GetWebpImageVersion( value )  ( value )
#endif

#define kLimitBuySpace @"                 "
//类型判断
#define XCS_IS_DICTIONARY( value ) ( [value isKindOfClass:[NSDictionary class]] )
#define XCS_IS_ARRAY( value ) ( [value isKindOfClass:[NSArray class]] )
#define XCS_IS_String( value ) ( [value isKindOfClass:[NSString class]] )
#define XCS_IS_NULL( value ) ( [value isKindOfClass:[NSNull class]] )


#define ImageaSpectRatio  (WIDTH/320.0)

#define CheckPhoneIsRegistedErroCode @"18"
#define KPromotionPriceChangeErrorCode @"41"
#define KLimitBuyErrorCode @"62"
#define KPhoneIsProhibitedErrorCode @"58"//
#define KFalseAccruedTokenStr @"20"
#define KFalseValidCodeStr @"12"
#define PageSizeDefault 20


//豆腐块高度
//#define BlockHeight ( KGetSizeFromScreen(188/2, 220/2, 314/3) ) //( sixInch ? 314/3.0f : (fiveInch ? 208/2 : 188/2 ) )
#define BlockHeight ( KGetSizeFromScreen(161/2, 190/2, 210/2) ) //( sixInch ? 314/3.0f : (fiveInch ? 208/2 : 188/2 ) )

//2 tab宽高
#define OneTabWidth ( KGetSizeFromScreen(176/2, 206/2, 308/3) )
#define OneTabHeight ( KGetSizeFromScreen(60/2, 60/2, 92/3) )

//图片压缩比例
#define KImageEmpressScale ( 0.4 )

//下拉刷新的阀值
#define KDragRefreshYPosition (50)

//下一步按钮的适配宽度
#define kNextBtnSpaceWight KGetSizeFromScreen(0, 0, 27)

#endif /* Constant_h */

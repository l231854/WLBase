//
//  XCJDTopListHeadView.h
//  CommunityService
//
//  Created by 雷王 on 2017/9/11.
//  Copyright © 2017年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCJDTopListHeadView : UIView
@property (nonatomic,strong) NSArray *arrayOfData;

@property (nonatomic,copy) void (^clickCategory)(id strTitle, NSInteger tag);
@property (nonatomic,assign) CGFloat count;

@property (nonatomic,assign) NSInteger selectIndex;

@property (nonatomic,copy) NSString *currentNoteType;


- (void)handleSwipForm:(BOOL)flag;
@end

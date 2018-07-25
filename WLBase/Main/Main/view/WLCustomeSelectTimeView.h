//
//  WLCustomeSelectTimeView.h
//  WLBase
//
//  Created by 雷王 on 2018/7/24.
//  Copyright © 2018年 WL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLCustomeSelectTimeView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,copy) NSString *year;
@property (nonatomic,copy) NSString *month;
@property (nonatomic,copy) NSString *day;
@property (nonatomic,strong) UIView *viewOfBig;
@property (nonatomic,strong) UIView *viewOfSelectTime;
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *arrayOfYears;
@property (nonatomic,strong) NSMutableArray *arrayOfMonth;
@property (nonatomic,strong) NSMutableArray *arrayOfDay;
//初始化方法
- (id)initWithTitle:(NSMutableArray*)years withyear:(NSString*)year withMonth:(NSString*)month withDay:(NSString*)day;
@property (nonatomic,copy) void (^clickSure)(NSString *year,NSString *month,NSString *day);
@property (nonatomic,copy) void (^clickRemove)(BOOL success);

@end

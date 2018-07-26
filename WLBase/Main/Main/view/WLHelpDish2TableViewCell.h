//
//  WLHelpDish2TableViewCell.h
//  WLBase
//
//  Created by 雷王 on 2018/7/22.
//  Copyright © 2018年 WL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLHelpDish2Model;
@interface WLHelpDish2TableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *imageviewOfContent;
//标签
@property (nonatomic,strong) UIButton *btnOfSign;
@property (nonatomic,strong) UIButton *btnOfSignRight;

@property (nonatomic,strong) UILabel *lbOfName;
@property (nonatomic,strong) UILabel *lbOfDescription;
@property (nonatomic,strong) UILabel *lbOfSalesNumbenr;
@property (nonatomic,strong) UILabel *lbOfPrice;
@property (nonatomic,strong) UILabel *lbOfOldPrice;
@property (nonatomic,strong) UILabel *lbOfOldPriceSep;

@property (nonatomic,strong) UIImageView *imageviewOfSellOut;
@property (nonatomic,strong) UIButton *buttonOfAdd;
@property (nonatomic,strong) UILabel *lbOfNumber;
@property (nonatomic,strong) UIButton *buttonOfMin;
@property (nonatomic,strong) NSIndexPath *currentIndex;

@property (nonatomic,strong) WLHelpDish2Model *model;
@property (nonatomic,copy) void (^clickAddOrMin)(NSIndexPath *index,NSString *number);

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

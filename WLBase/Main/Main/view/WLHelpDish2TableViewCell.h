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
@property (nonatomic,strong) UILabel *lbOfName;
@property (nonatomic,strong) UILabel *lbOfNumbenr;
@property (nonatomic,strong) UILabel *lbOfPrice;
@property (nonatomic,strong) UIButton *buttonOfAdd;

@property (nonatomic,strong) WLHelpDish2Model *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

//
//  WLConsultTableViewCell.h
//  WLBase
//
//  Created by 雷王 on 2018/7/20.
//  Copyright © 2018年 WL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLConsultModel;
@interface WLConsultTableViewCell : UITableViewCell
@property (nonatomic,strong) UILabel *lbOfName;
@property (nonatomic,strong) UILabel *lbOfTime;
@property (nonatomic,strong) UIImageView *imageviewOfContent;
@property (nonatomic,strong) UILabel *lbOfContent;
@property (nonatomic,strong) WLConsultModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end

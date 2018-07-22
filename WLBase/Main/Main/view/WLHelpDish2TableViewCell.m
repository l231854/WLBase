//
//  WLHelpDish2TableViewCell.m
//  WLBase
//
//  Created by 雷王 on 2018/7/22.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLHelpDish2TableViewCell.h"
#import "WLHelpDish2Model.h"
@implementation WLHelpDish2TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"WLHelpDish2TableViewCell";
    WLHelpDish2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectedBackgroundView = [[UIImageView alloc] init];
        //
        self.backgroundView = [[UIImageView alloc] init];
        [self setUpSubvies];
    }
    return self;
}
- (void)setUpSubvies
{
    self.imageviewOfContent=[[UIImageView alloc] init];
    [self.contentView addSubview:self.imageviewOfContent];
    self.lbOfName=[[UILabel alloc] init];
    [self.contentView addSubview:self.lbOfName];
    self.lbOfNumbenr=[[UILabel alloc] init];
    [self.contentView addSubview:self.lbOfNumbenr];
    self.lbOfPrice=[[UILabel alloc] init];
    [self.contentView addSubview:self.lbOfPrice];
    self.buttonOfAdd = [[UIButton alloc] init];
    [self.contentView addSubview:self.buttonOfAdd];
}
- (void)setModel:(WLHelpDish2Model *)model
{
    if (model) {
        _model=model;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

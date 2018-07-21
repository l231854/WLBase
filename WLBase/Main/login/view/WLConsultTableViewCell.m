//
//  WLConsultTableViewCell.m
//  WLBase
//
//  Created by 雷王 on 2018/7/20.
//  Copyright © 2018年 WL. All rights reserved.
//

#import "WLConsultTableViewCell.h"
#import "WLConsultModel.h"
@implementation WLConsultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"WLConsultTableViewCell";
    WLConsultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
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
    self.lbOfName=[[UILabel alloc] init];
    [self.contentView addSubview:self.lbOfName];
    self.lbOfTime=[[UILabel alloc] init];
    [self.contentView addSubview:self.lbOfTime];
    self.imageviewOfContent=[[UIImageView alloc] init];
    [self.contentView addSubview:self.imageviewOfContent];
    self.textviewOfContent=[[UITextView alloc] init];
    [self.contentView addSubview:self.textviewOfContent];
}
- (void)setModel:(WLConsultModel *)model
{
    if (model) {
        _model=model;
        self.lbOfName.frame=CGRectMake(WLsize(10.0), WLsize(20.0), WIDTH, WLsize(35));
        self.lbOfName.textColor=UIColorFromRGB(0x101010, 1);
        self.lbOfName.font =[UIFont systemFontOfSize:WLsize(17.0)];
        self.lbOfName.text=model.name;
        
        self.lbOfTime.frame=CGRectMake(WLsize(10.0), CGRectGetMaxY(self.lbOfName.frame), WIDTH, WLsize(23.0));
        self.lbOfTime.textColor=UIColorFromRGB(0x101010, 1);
        self.lbOfTime.font =[UIFont systemFontOfSize:WLsize(14.0)];
        self.lbOfTime.text=[NSString stringWithFormat:@"%@  %@",APPNAME,model.time];
        
        self.imageviewOfContent.frame=CGRectMake(WLsize(10.0), CGRectGetMaxY(self.lbOfTime.frame)+WLsize(17.0),WIDTH-WLsize(20.0), WLsize(150.0));
        [self.imageviewOfContent sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
        
//        CGSize size =XCsizeWithFont(, <#font#>)
        self.textviewOfContent.frame=CGRectMake(WLsize(10.0), CGRectGetMaxY(self.imageviewOfContent.frame), WIDTH-WLsize(20.0), HEIGHT-XCStatusBar-CGRectGetMaxY(self.imageviewOfContent.frame));
        self.textviewOfContent.textColor=UIColorFromRGB(0x101010, 1);
        self.textviewOfContent.font=[UIFont systemFontOfSize:14.0];
//        self.textviewOfContent.numberOfLines=0;
        self.textviewOfContent.text=model.content;
        
        
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

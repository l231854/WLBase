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
    self.btnOfSign=[[UIButton alloc] init];
    [self.contentView addSubview:self.btnOfSign];
    self.btnOfSignRight=[[UIButton alloc] init];
    [self.contentView addSubview:self.btnOfSignRight];
    self.lbOfName=[[UILabel alloc] init];
    [self.contentView addSubview:self.lbOfName];
    self.lbOfDescription=[[UILabel alloc] init];
    [self.contentView addSubview:self.lbOfDescription];
    self.lbOfSalesNumbenr=[[UILabel alloc] init];
    [self.contentView addSubview:self.lbOfSalesNumbenr];
    self.lbOfPrice=[[UILabel alloc] init];
    [self.contentView addSubview:self.lbOfPrice];
    self.lbOfOldPrice=[[UILabel alloc] init];
    [self.contentView addSubview:self.lbOfOldPrice];
    self.lbOfOldPriceSep=[[UILabel alloc] init];
    [self.contentView addSubview:self.lbOfOldPriceSep];
    self.lbOfNumber=[[UILabel alloc] init];
    [self.contentView addSubview:self.lbOfNumber];
    self.imageviewOfSellOut = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageviewOfSellOut];
    self.buttonOfAdd = [[UIButton alloc] init];
    [self.contentView addSubview:self.buttonOfAdd];
    self.buttonOfMin = [[UIButton alloc] init];
    [self.contentView addSubview:self.buttonOfMin];
}
- (void)setModel:(WLHelpDish2Model *)model
{
    if (model) {
        _model=model;
        self.imageviewOfContent.frame=CGRectMake(WLsize(10), WLsize(15), WLsize(75), WLsize(75));
        self.imageviewOfContent.layer.masksToBounds=YES;
        self.imageviewOfContent.backgroundColor=[UIColor grayColor];
        self.imageviewOfContent.layer.cornerRadius=WLsize(4.0);
        [self.imageviewOfContent sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    self.btnOfSign.frame=CGRectMake(self.imageviewOfContent.frame.origin.x,self.imageviewOfContent.frame.origin.y,WLsize(30), WLsize(16));
        [self.btnOfSign setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btnOfSign.titleLabel.font =[UIFont systemFontOfSize:WLsize(10)];
        if ([model.Sign intValue]==WLSignTypeRecommend) {
            [self.btnOfSign setBackgroundImage:[UIImage imageNamed:@"recommend_pic"] forState:UIControlStateNormal];
            [self.btnOfSign setTitle:@"推荐" forState:UIControlStateNormal];
        }else if ([model.Sign intValue]==WLSignTypeHot)
        {
            [self.btnOfSign setBackgroundImage:[UIImage imageNamed:@"sale_pic"] forState:UIControlStateNormal];

            [self.btnOfSign setTitle:@"热卖" forState:UIControlStateNormal];
        }
        else if ([model.Sign intValue]==WLSignTypeDiscount)
        {
            [self.btnOfSign setBackgroundImage:[UIImage imageNamed:@"discount_pic"] forState:UIControlStateNormal];
            [self.btnOfSign setTitle:@"7.8折" forState:UIControlStateNormal];
        }
        else if ([model.Sign intValue]==WLSignTypeNew)
        {
            [self.btnOfSign setBackgroundImage:[UIImage imageNamed:@"new_pic"] forState:UIControlStateNormal];
            [self.btnOfSign setTitle:@"新品" forState:UIControlStateNormal];
        }
        
        self.lbOfName.frame=CGRectMake(WLsize(8)+CGRectGetMaxX(self.imageviewOfContent.frame), self.imageviewOfContent.frame.origin.y,WLsize(155), WLsize(15));
        self.lbOfName.text=model.name;
        self.lbOfName.textColor=WLTEXTCOLOR;
        self.lbOfName.font=[UIFont systemFontOfSize:WLsize(14)];
        self.btnOfSignRight.frame=CGRectMake(CGRectGetMaxX(self.lbOfName.frame),self.lbOfName.frame.origin.y,WLsize(15), WLsize(15));
        if ([model.SignOfRight intValue]==WLSignTypeOfRightHot) {
            [self.btnOfSignRight setImage:[UIImage imageNamed:@"sale_icon"] forState:UIControlStateNormal];
        }
        else if ([model.SignOfRight intValue]==WLSignTypeOfRightNew) {
            [self.btnOfSignRight setImage:[UIImage imageNamed:@"new_icon"] forState:UIControlStateNormal];
        }
        self.lbOfDescription.frame=CGRectMake(self.lbOfName.frame.origin.x, CGRectGetMaxY(self.lbOfName.frame)+WLsize(2),WLsize(180), WLsize(15));
        self.lbOfDescription.font=[UIFont systemFontOfSize:WLsize(13)];
        self.lbOfDescription.textColor=UIColorFromInt(102, 102, 102, 1);
        if (model.strText.length>0) {
            self.lbOfDescription.text=model.strText;
            self.lbOfDescription.hidden=NO;
        }
        else{
            self.lbOfDescription.frame=CGRectMake(0,CGRectGetMaxY(self.lbOfName.frame),0, 0);
            self.lbOfDescription.hidden=YES;
        }
        self.lbOfSalesNumbenr.frame=CGRectMake(self.lbOfName.frame.origin.x, CGRectGetMaxY(self.lbOfDescription.frame)+WLsize(2), WLsize(160), WLsize(15));
        self.lbOfSalesNumbenr.text=model.salesNumber;
        self.lbOfSalesNumbenr.font=[UIFont systemFontOfSize:WLsize(13)];
        self.lbOfSalesNumbenr.textColor=UIColorFromInt(102, 102, 102, 1);
        
        self.lbOfPrice.font =[UIFont systemFontOfSize:WLsize(18)];
        self.lbOfPrice.textColor=UIColorFromInt(227, 87, 100, 1);
        self.lbOfPrice.text=[NSString stringWithFormat:@"¥%.2f",[model.price floatValue]];
        CGSize  size=XCsizeWithFont(self.lbOfPrice.text,[UIFont systemFontOfSize:WLsize(18)]);
    self.lbOfPrice.frame=CGRectMake(self.lbOfName.frame.origin.x,CGRectGetMaxY(self.imageviewOfContent.frame)-WLsize(21),size.width, WLsize(21));
        if (model.Oldprice.length>0) {
            self.lbOfOldPrice.font =[UIFont systemFontOfSize:WLsize(12)];
            self.lbOfOldPrice.textColor=UIColorFromInt(153, 153, 153, 1);
            self.lbOfOldPrice.text=[NSString stringWithFormat:@"¥%.2f",[model.Oldprice floatValue]];
            CGSize size2 = XCsizeWithFont(self.lbOfOldPrice.text, [UIFont systemFontOfSize:WLsize(12)]);
            self.lbOfOldPrice.frame=CGRectMake(CGRectGetMaxX(self.lbOfPrice.frame)+WLsize(5),CGRectGetMaxY(self.imageviewOfContent.frame)-WLsize(14),size2.width, WLsize(14));
            self.lbOfOldPriceSep.frame=CGRectMake(self.lbOfOldPrice.center.x-size2.width/2.0,self.lbOfOldPrice.center.y, size2.width, 1.0);
            self.lbOfOldPriceSep.backgroundColor=UIColorFromInt(153, 153, 153, 1);
            self.lbOfOldPriceSep.hidden=NO;
            self.lbOfOldPrice.hidden=NO;
        }else{
            self.lbOfOldPriceSep.hidden=YES;
            self.lbOfOldPrice.hidden=YES;
            self.lbOfOldPriceSep.frame=CGRectMake(0, 0, 0, 0);
            self.lbOfOldPrice.frame=CGRectMake(0, 0, 0, 0);

        }
        if([model.remainingNmuber intValue]<=0)
        {
            self.buttonOfAdd.hidden=YES;
            self.buttonOfAdd.frame=CGRectZero;
            self.buttonOfMin.hidden=YES;
            self.buttonOfMin.frame=CGRectZero;
            self.lbOfNumber.hidden=YES;
            self.lbOfNumber.frame=CGRectZero;
            self.imageviewOfSellOut.hidden=NO;
            self.imageviewOfSellOut.frame=CGRectMake(WLsize(295)-WLsize(13)-WLsize(65), CGRectGetMaxY(self.lbOfName.frame)+WLsize(12), WLsize(65), WLsize(65));
            self.imageviewOfSellOut.image=[UIImage imageNamed:@"seal_icon"];

        }
        else{
            self.imageviewOfSellOut.hidden=YES;
            self.imageviewOfSellOut.frame=CGRectZero;
            self.buttonOfAdd.hidden=NO;
            self.buttonOfMin.hidden=NO;
            self.lbOfNumber.hidden=NO;
        self.buttonOfAdd.frame=CGRectMake(WLsize(295)-WLsize(13)-WLsize(20), CGRectGetMaxY(self.imageviewOfContent.frame)-WLsize(20), WLsize(20), WLsize(20));
        [self.buttonOfAdd setImage:[UIImage imageNamed:@"add_dishes_icon"] forState:UIControlStateNormal];
        [self.buttonOfAdd addTarget:self action:@selector(clickAdd:) forControlEvents:UIControlEventTouchUpInside];
        self.lbOfNumber.frame=CGRectMake(self.buttonOfAdd.frame.origin.x-WLsize(30),self.buttonOfAdd.frame.origin.y, WLsize(30), self.buttonOfAdd.frame.size.height);
        self.lbOfNumber.text=model.SelectNumber;
        self.lbOfNumber.textAlignment=NSTextAlignmentCenter;
        self.lbOfNumber.textColor=WLTEXTCOLOR;
        self.lbOfNumber.font=[UIFont systemFontOfSize:WLsize(14)];
            if ([model.SelectNumber intValue]>0) {
                self.lbOfNumber.hidden=NO;
            }
            else{
                self.lbOfNumber.hidden=YES;

            }
            
        self.buttonOfMin.frame=CGRectMake(self.lbOfNumber.frame.origin.x-WLsize(20), CGRectGetMaxY(self.imageviewOfContent.frame)-WLsize(20), WLsize(20), WLsize(20));
        [self.buttonOfMin setImage:[UIImage imageNamed:@"minus_dishes_icon"] forState:UIControlStateNormal];
        [self.buttonOfMin addTarget:self action:@selector(clickMin:) forControlEvents:UIControlEventTouchUpInside];
            if ([model.SelectNumber intValue]>0) {
                self.buttonOfMin.hidden=NO;
            }
            else{
                self.buttonOfMin.hidden=YES;
                
            }
        }
        
        
    }
    
}


#pragma makr--点击+
-(void)clickAdd:(UIButton *)button
{
    if ([self.model.SelectNumber intValue]<[self.model.remainingNmuber integerValue]) {
        self.model.SelectNumber=[NSString stringWithFormat:@"%d",[self.model.SelectNumber intValue]+1];
        if ([self clickAddOrMin]) {
            [self clickAddOrMin](self.currentIndex,self.model.SelectNumber);
        }
    }
    else{
        [MBProgressHUD showWithMessage:@"已经达到该商品最大库存！"];
    }
    
}
#pragma makr--点击-
-(void)clickMin:(UIButton *)button
{
        self.model.SelectNumber=[NSString stringWithFormat:@"%d",[self.model.SelectNumber intValue]-1];
        if ([self clickAddOrMin]) {
            [self clickAddOrMin](self.currentIndex,self.model.SelectNumber);
        }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  RushBuyCell.m
//  ACHProject
//
//  Created by chenxiaohong on 2017/8/30.
//  Copyright © 2017年 爱享到. All rights reserved.
//

#import "RushBuyCell.h"

@implementation RushBuyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"RushBuyCell";
    RushBuyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil) {
        cell = [[RushBuyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    //选中cell的颜色 -无色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        
        for (int i = 0; i < 3; i++) {
            //
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(i*kBaseWidth/2, 0, kBaseWidth/2, 150)];
            if (i == 0) {
                //
                backView.frame = CGRectMake(i*kBaseWidth/2, 0, kBaseWidth/2, 150);
                //
                UILabel *Price = [[UILabel alloc]initWithFrame:CGRectMake(0, 130, backView.frame.size.width/2, 20)];
                Price.tag = 50+i;
                Price.text = @"$100";
                Price.textColor = kColor_title;
                Price.font = [UIFont systemFontOfSize:13];
                Price.textAlignment = NSTextAlignmentRight;
                [backView addSubview:Price];
                //
                UILabel *Price2 = [[UILabel alloc]initWithFrame:CGRectMake(backView.frame.size.width/2+10, 130, backView.frame.size.width/2, 20)];
                Price2.tag = 60+i;
                Price2.text = @"减20";
                Price2.textColor = [UIColor orangeColor];
                Price2.font = [UIFont systemFontOfSize:11];
                [backView addSubview:Price2];
                //
                UIImageView *shop = [[UIImageView alloc]initWithFrame:CGRectMake(backView.frame.size.width/2-(backView.frame.size.width/4), 10, backView.frame.size.width/2, 30)];
                shop.image = [UIImage imageNamed:@"todaySpecialHeaderTitleImage@2x"];
                [backView addSubview:shop];
                //
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(backView.frame.size.width/2-(backView.frame.size.width/4), 60, backView.frame.size.width/2, 50)];
                imageView.tag = 70 + i;
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                imageView.backgroundColor = kColor_title;
                [backView addSubview:imageView];
                //
                UILabel *imageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, backView.frame.size.width, 20)];
                imageLabel.text = @"举头望明月";
                imageLabel.tag = 80 +i;
                imageLabel.textAlignment = NSTextAlignmentCenter;
                imageLabel.textColor = [UIColor orangeColor];
                imageLabel.font = [UIFont systemFontOfSize:13];
                [backView addSubview:imageLabel];
            }else if (i == 1){
                //
                backView.frame = CGRectMake(i*kBaseWidth/2, 0, kBaseWidth/2, 75);
                //
                UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, backView.frame.size.width/2+10+60, 30)];
                titleLabel.text = @"唐硕唐帅";
                titleLabel.textColor = kColor_title;
                titleLabel.tag = 90 +i;
                titleLabel.font = [UIFont systemFontOfSize:15];
                [backView addSubview:titleLabel];
                //
                UILabel *subLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, backView.frame.size.width/2+10+60, 30)];
                subLable.tag = 91 +i;
                subLable.text = @"唐硕帅还用你说";
                subLable.font = [UIFont systemFontOfSize:12];
                [backView addSubview:subLable];
                //
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(backView.frame.size.width/2+15, backView.frame.size.height/2-25, 50, 50)];
                imageView.tag = 92 + i;
                [imageView setImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
                imageView.layer.masksToBounds = YES;
                imageView.layer.cornerRadius = 30;
                [backView addSubview:imageView];
                
            }else {
                //
                backView.frame = CGRectMake((i-1)*kBaseWidth/2, 75, kBaseWidth/2, 75);
                //
                UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, backView.frame.size.width/2+10+60, 30)];
                titleLabel.text = @"唐硕唐帅";
                titleLabel.textColor = kColor_title;
                titleLabel.font = [UIFont systemFontOfSize:15];
                [backView addSubview:titleLabel];
                //
                UILabel *subLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, backView.frame.size.width/2+10+60, 30)];
                subLable.text = @"唐硕帅还用你说";
                subLable.font = [UIFont systemFontOfSize:12];
                [backView addSubview:subLable];
                //
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(backView.frame.size.width/2+15, backView.frame.size.height/2-25, 50, 50)];
                [imageView setImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
                imageView.layer.masksToBounds = YES;
                imageView.layer.cornerRadius = 30;
                [backView addSubview:imageView];            }
            
            backView.tag = 100+i;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBackView:)];
            [backView addGestureRecognizer:tap];
            [self addSubview:backView];
            
            //
            //            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screen_width/2, 120)];
            //            imageView.contentMode = UIViewContentModeScaleAspectFit;
            //            imageView.tag = i+20;
            //            [backView addSubview:imageView];
            //线
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(kBaseWidth/2, 0, 1, 150)];
            UIView *linView2 = [[UIView alloc]initWithFrame:CGRectMake(kBaseWidth/2, 75, kBaseWidth/2, 1)];
            linView2.backgroundColor = kColor_title;
            lineView.backgroundColor = kColor_title;
            [self addSubview:linView2];
            [self addSubview:lineView];
            
            
        }
        
    }
    return self;
}

-(void)OnTapBackView:(UITapGestureRecognizer *)sender {
    NSLog(@"%ld", (long)sender.view.tag);
}



@end

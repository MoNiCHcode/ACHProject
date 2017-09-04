//
//  CardCell.m
//  ACHProject
//
//  Created by chenxiaohong on 2017/9/4.
//  Copyright © 2017年 爱享到. All rights reserved.
//

#import "CardCell.h"
#import "CardCollectionViewCell.h"
@implementation CardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_cardCollectionView registerNib:[UINib nibWithNibName:@"CardCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CardCollectionViewCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - flowlayout 
-(UICollectionViewFlowLayout *)flowlayout
{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    return flowlayout;
}

#pragma mark - delegate and dataSourse
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CardCollectionViewCell *coll = [collectionView dequeueReusableCellWithReuseIdentifier:@"CardCollectionViewCell" forIndexPath:indexPath];
    coll.backgroundColor = [UIColor redColor];
    return coll;

}



@end

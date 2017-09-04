//
//  CardCell.h
//  ACHProject
//
//  Created by chenxiaohong on 2017/9/4.
//  Copyright © 2017年 爱享到. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;


@end

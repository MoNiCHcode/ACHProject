//
//  AnimationView.h
//  MyMovie
//
//  Created by zsm on 14-8-26.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIImageView *_pageImageView;
    int _imageCount;
    int index;
    
    BOOL _isClick;
}

@property (nonatomic,strong)NSArray *banners;
+ (instancetype)sharedWelcomeView;
@end

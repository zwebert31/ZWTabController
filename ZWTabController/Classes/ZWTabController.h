//
//  ViewController.h
//  ZWTabController
//
//  Created by Zachary Webert on 1/11/15.
//  Copyright (c) 2015 Zachary Webert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWTabController : UIViewController <UIScrollViewDelegate>
@property (nonatomic, strong) NSArray* viewControllers;
-(void)didScrollToIndex:(NSInteger)index;
-(void)willScrollToIndex:(NSInteger)index;
+(CGFloat)buttonHeight;
+(CGFloat)selectorHeight;
+(UIColor*)btnColor;
+(UIColor*)btnTitleColor;
+(UIColor*)selectorColor;
@end


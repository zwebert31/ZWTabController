//
//  ViewController.m
//  ZWTabController
//
//  Created by Zachary Webert on 1/11/15.
//  Copyright (c) 2015 Zachary Webert. All rights reserved.
//

#import "ZWTabController.h"

@interface ZWTabController ()
{
    NSMutableArray *_btns;
    UIView *_selectorView;
    UIScrollView *_scroller;
}
@end

@implementation ZWTabController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

-(void)setupView {
    [super viewDidLoad];
    
    [[self.view subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //setup buttons
    CGFloat btnWidth = self.view.frame.size.width / self.viewControllers.count;
    CGFloat btnHeight = [[self class] buttonHeight];
    CGFloat btnY = self.view.frame.size.height - btnHeight;
    UIColor *btnColor = [[self class] btnColor];
    UIColor *btnTitleColor = [[self class] btnTitleColor];
    CGFloat selectorHeight = [[self class] selectorHeight];
    
    _scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - btnHeight - selectorHeight)];
    [_scroller setBackgroundColor:[UIColor grayColor]];
    [_scroller setScrollEnabled:YES];
    [_scroller setPagingEnabled:YES];
    [_scroller setBounces:NO];
    [_scroller setShowsHorizontalScrollIndicator:NO];
    [_scroller setShowsVerticalScrollIndicator:NO];
    [_scroller setContentSize:CGSizeMake(_scroller.frame.size.width * self.viewControllers.count, _scroller.frame.size.height)];
    [_scroller setDelegate:self];
    [self.view addSubview:_scroller];
    
    for (int i = 0; i<self.viewControllers.count; i++) {
        UIViewController *vc = self.viewControllers[i];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*btnWidth, btnY, btnWidth, btnHeight)];
        btn.backgroundColor = btnColor;
        [btn setTitleColor:btnTitleColor forState:UIControlStateNormal];
        [btn setTitle:vc.navigationItem.title forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
        
        [vc.view setFrame:CGRectMake(i * self.view.frame.size.width, 0, self.view.frame.size.width, _scroller.frame.size.height)];
        [_scroller addSubview:vc.view];
    }
    
    
    _selectorView = [[UIView alloc] initWithFrame:CGRectMake(0, btnY - selectorHeight, btnWidth, selectorHeight)];
    [_selectorView setBackgroundColor:[[self class] selectorColor]];
    [self.view addSubview:_selectorView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    CGFloat percentage = scrollView.contentOffset.x / pageWidth;
    CGFloat selectorPosition = percentage * _selectorView.frame.size.width;
    [_selectorView setFrame:CGRectMake(selectorPosition, _selectorView.frame.origin.y, _selectorView.frame.size.width, _selectorView.frame.size.height)];
}

-(void)scrollToIndex:(NSInteger)index {
    [_scroller setContentOffset:CGPointMake(_scroller.frame.size.width * index, 0) animated:YES];
    [self didScrollToIndex:index];
}

-(void)willScrollToIndex:(NSInteger)index {
    
}

-(void)didScrollToIndex:(NSInteger)index {
    
}

-(void)btnTapped:(id) sender {
    NSInteger index = ((UIView*)sender).tag;
    [self willScrollToIndex:index];
    [self scrollToIndex:index];
}

+(CGFloat)buttonHeight {
    return 60;
}

+(CGFloat)selectorHeight {
    return 7;
}

+(UIColor*)btnColor {
    return [UIColor whiteColor];
}

+(UIColor*)btnTitleColor {
    return [UIColor blueColor];
}

+(UIColor*)selectorColor {
    return [UIColor blueColor];
}



@end

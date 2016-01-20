//
//  ViewController.m
//  IDPReloadController
//
//  Created by 能登 要 on 2016/01/20.
//  Copyright © 2016年 Irimasu Densan Planning. All rights reserved.
//

#import "ViewController.h"
#import "IDPReloadController.h"
#import "IDPRCStyleKit.h"

@interface ViewController ()
{
    BOOL _initialized;
    
    IBOutlet IDPReloadController *_reloadCntroller;
    __weak IBOutlet UIButton *_reloadButton;
    
    CGPoint _scrollBeginingPoint;
}
@end

@implementation ViewController


- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [_reloadButton setImage:[IDPRCStyleKit imageOfArrow] forState:UIControlStateNormal];
    [_reloadButton setTintColor:[IDPRCStyleKit arrowColor]];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if( _initialized != YES ){
        _initialized = YES;
        
        [_reloadCntroller constructReloadControllerWithView:self.view topLayoutGuide:self.topLayoutGuide hidden:YES];
        
    }
}

- (IBAction)onShowReloadController:(id)sender
{
    [_reloadCntroller showWithView:self.view completion:^{
       
    }];
}




- (IBAction)onTouchDownonPressMoreRead:(id)sender
{
    _reloadCntroller.reloadView.alpha = 0.5;
}

- (IBAction)onMoreRead:(id)sender
{
    [_reloadCntroller hideWithView:self.view completion:^{
        _reloadCntroller.reloadView.alpha = 1.0;
        
    }];
}

- (IBAction)onTouchDownonCancelMoreRead:(id)sender
{
    _reloadCntroller.reloadView.alpha = 1.0;
}

- (IBAction)onTouchUpOutsideMoreRead:(id)sender
{
    _reloadCntroller.reloadView.alpha = 1.0;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDragging: call");
    
    _scrollBeginingPoint = [scrollView contentOffset];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScroll: call");
    
    CGPoint currentPoint = [scrollView contentOffset];
    CGFloat delta = _scrollBeginingPoint.y - currentPoint.y;
    [_reloadCntroller setVerticalOffset:delta];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if( decelerate != YES ){
        [_reloadCntroller resetVerticalOffsetWithView:self.view];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating: call");

    [_reloadCntroller resetVerticalOffsetWithView:self.view];
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat edge = CGRectGetWidth(self.collectionView.frame) * 0.5;
    
    return CGSizeMake(edge, edge);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *CellIdentifier = @"TimelineCell";
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    NSArray *colors = @[ [[UIColor redColor] colorWithAlphaComponent:0.5]
                        ,[[UIColor greenColor] colorWithAlphaComponent:0.5]
                        ,[[UIColor blueColor] colorWithAlphaComponent:0.5]
                        ,[[UIColor magentaColor] colorWithAlphaComponent:0.5]
                        ,[[UIColor yellowColor] colorWithAlphaComponent:0.5]
                        ,[[UIColor cyanColor] colorWithAlphaComponent:0.5]
                        ];
    
    cell.backgroundColor = colors[indexPath.row % colors.count];
    
    return cell;
}

@end

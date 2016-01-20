//
//  IDPReloadController.m
//  CollectionViewTest3
//
//  Created by 能登 要 on 2016/01/20.
//  Copyright © 2016年 Irimasu Densan Planning. All rights reserved.
//

#import "IDPReloadController.h"

@interface IDPReloadController ()
{
    NSLayoutConstraint *_moreReadTopConstraint;
    CGFloat _originalMoreReadTopConstraint;
    CGFloat _hiddenMoreReadTopConstraint;
    
    CGFloat _originalMaskTopConstraint;
    CGFloat _hiddenMaskTopConstraint;
    
    BOOL _hidden;
}
@end

@implementation IDPReloadController

- (instancetype) init
{
    self = [super init];
    if( self != nil ){
        _margin = 4;
    }
    return self;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    _margin = 4;
}

- (void) constructReloadControllerWithView:(UIView *)view topLayoutGuide:(id<UILayoutSupport>) topLayoutGuide hidden:(BOOL)hidden
{
    if( view != nil ){
        CGPoint center = CGPointMake( CGRectGetWidth(view.frame) * 0.5
                                     ,topLayoutGuide.length + CGRectGetHeight(_reloadView.frame) * 0.5 + _margin);
        _reloadView.center = center;
        _reloadView.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:_reloadView];
        
        _moreReadTopConstraint = [NSLayoutConstraint constraintWithItem:_reloadView
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:topLayoutGuide
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:_margin];
        _hiddenMoreReadTopConstraint = -(CGRectGetHeight(_reloadView.frame) + _margin);
        _originalMoreReadTopConstraint = _moreReadTopConstraint.constant;
        
        
        [NSLayoutConstraint activateConstraints:@[
                                                  _moreReadTopConstraint,
                                                  [NSLayoutConstraint constraintWithItem:_reloadView
                                                                               attribute:NSLayoutAttributeCenterX
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:view
                                                                               attribute:NSLayoutAttributeCenterX
                                                                              multiplier:1.0
                                                                                constant:0],
                                                  
                                                  [NSLayoutConstraint constraintWithItem:_reloadView
                                                                               attribute:NSLayoutAttributeHeight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeHeight
                                                                              multiplier:1.0
                                                                                constant:CGRectGetHeight(_reloadView.frame)],
                                                  
                                                  [NSLayoutConstraint constraintWithItem:_reloadView
                                                                               attribute:NSLayoutAttributeWidth
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeWidth
                                                                              multiplier:1
                                                                                constant:CGRectGetWidth(_reloadView.frame)],
                                                  ]];
        
        CGRect frame = CGRectMake(0, topLayoutGuide.length, CGRectGetWidth(view.frame), CGRectGetHeight(_reloadView.frame) + _margin * 2);
        UIView *maskView = [[UIView alloc] initWithFrame:frame];
        maskView.backgroundColor = [UIColor redColor];
        maskView.translatesAutoresizingMaskIntoConstraints = NO;
        maskView.center = CGPointMake(CGRectGetWidth(_reloadView.frame) * 0.5, CGRectGetHeight(_reloadView.frame) * 0.5);
        _reloadView.maskView = maskView;
        
        _hiddenMaskTopConstraint = CGRectGetHeight(_reloadView.frame) * 0.5 + CGRectGetHeight(_reloadView.frame) + _margin;
        _originalMaskTopConstraint = CGRectGetHeight(_reloadView.frame) * 0.5;
        
        if( hidden ){
            _moreReadTopConstraint.constant = _hiddenMoreReadTopConstraint;
            _reloadView.maskView.center = CGPointMake(CGRectGetWidth(_reloadView.frame) * 0.5, _hiddenMaskTopConstraint);
        }
        _hidden = hidden;
    }
}

- (BOOL) hidden
{
    return _hidden;
}

- (void) setVerticalOffset:(CGFloat)verticalOffset
{
    if( _hidden != YES && _reloadView != nil ){
        if( verticalOffset < 0 ){
            CGFloat constraint = MAX(_originalMoreReadTopConstraint + verticalOffset,_hiddenMoreReadTopConstraint);

            CGFloat ratio = (constraint - _hiddenMoreReadTopConstraint) / (_hiddenMoreReadTopConstraint - _originalMoreReadTopConstraint);
            NSLog(@"ratio=%@",@(ratio) );
            
            _moreReadTopConstraint.constant = constraint;
        }else{
            if( _moreReadTopConstraint.constant != _hiddenMoreReadTopConstraint ){
                _moreReadTopConstraint.constant = MIN(_moreReadTopConstraint.constant + verticalOffset,_originalMoreReadTopConstraint);
            }
        }
    }
}

- (void)onResetVerticalOffset:(id)obj
{
    UIView *view = obj;
    
    if( _hidden != YES ){
        
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _moreReadTopConstraint.constant = _originalMoreReadTopConstraint;
            _reloadView.maskView.center = CGPointMake(CGRectGetWidth(_reloadView.frame) * 0.25, _originalMaskTopConstraint);
            
            [view layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    }else{
        _moreReadTopConstraint.constant = _hiddenMoreReadTopConstraint;
        _reloadView.maskView.center = CGPointMake(CGRectGetWidth(_reloadView.frame) * 0.5, _hiddenMaskTopConstraint);
        [view layoutIfNeeded];
    }
}

- (void) resetVerticalOffsetWithView:(UIView *)view
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(onResetVerticalOffset:) object:nil];
    
    if( _hidden != YES && _reloadView != nil ){
        [self performSelector:@selector(onResetVerticalOffset:) withObject:view afterDelay:0.5];
    }
}

- (void) showWithView:(UIView *)view completion:(void (^ __nullable)(void))completion
{
    [view setNeedsUpdateConstraints];
    
    _hidden = NO;
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _moreReadTopConstraint.constant = _originalMoreReadTopConstraint;
        _reloadView.maskView.center = CGPointMake(CGRectGetWidth(_reloadView.frame) * 0.5, _originalMaskTopConstraint);
        
        [view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if( completion != nil ){
            completion();
        }
    }];
}

- (void) hideWithView:(UIView *)view completion:(void (^ __nullable)(void))completion
{
    [view setNeedsUpdateConstraints];
    
    _hidden = YES;
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _moreReadTopConstraint.constant = _hiddenMoreReadTopConstraint;
        _reloadView.maskView.center = CGPointMake(CGRectGetWidth(_reloadView.frame) * 0.5, _hiddenMaskTopConstraint);

        [view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if( completion != nil ){
            completion();
        }
    }];
}


@end

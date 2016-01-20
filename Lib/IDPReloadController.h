//
//  IDPReloadController.h
//  IDPReloadController
//
//  Created by 能登 要 on 2016/01/20.
//  Copyright © 2016年 Irimasu Densan Planning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDPReloadController : NSObject

@property (weak,nonatomic) IBOutlet UIView *reloadView;
@property (assign,nonatomic) CGFloat margin;
@property (readonly,nonatomic) BOOL hidden;

- (void) constructReloadControllerWithView:(UIView *)view topLayoutGuide:(id<UILayoutSupport>)topLayoutGuide hidden:(BOOL)hidden;
- (void) showWithView:(UIView *)view completion:(void (^)(void))completion;
- (void) hideWithView:(UIView *)view completion:(void (^)(void))completion;

// ScrollSupport
- (void) setVerticalOffset:(CGFloat)verticalOffset; // scrollViewDidScroll:
- (void) resetVerticalOffsetWithView:(UIView *)view; // scrollViewDidEndDragging:(decelerate != YES),scrollViewDidEndDecelerating:

@end

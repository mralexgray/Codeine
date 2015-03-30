
/* $Id$ */

@class CEVerticalTabView;

@protocol CEVerticalTabViewDelegate<NSObject>

@optional

- (void)verticalTabView:(CEVerticalTabView*)view didSelectViewAtIndex:(NSUInteger)index;

@end

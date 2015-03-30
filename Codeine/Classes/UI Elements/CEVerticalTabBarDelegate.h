
/* $Id$ */

@class CEVerticalTabBar;

@protocol CEVerticalTabBarDelegate<NSObject>

@optional

- (void)verticalTabBar:(CEVerticalTabBar*)tabBar didSelectItemAtIndex:(NSUInteger)index;

@end

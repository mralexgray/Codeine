
/* $Id$ */

#import "CEVerticalTabBarDelegate.h"

typedef enum {
  CEVerticalTabBarPositionLeft = 0x00,
  CEVerticalTabBarPositionRight = 0x01
} CEVerticalTabBarPosition;

@interface CEVerticalTabBar : NSView {
@protected

  NSMutableArray* _icons;
  CEVerticalTabBarPosition _position;
  NSMutableArray* _trackingAreas;
  NSInteger _trackingIndex;
  NSUInteger _selectedIndex;
  id<CEVerticalTabBarDelegate> __unsafe_unretained _delegate;

@private

  RESERVED_IVARS(CEVerticalTabBar, 5);
}

@property (readwrite, assign) CEVerticalTabBarPosition position;
@property (readwrite, unsafe_unretained) id<CEVerticalTabBarDelegate> delegate;

- (void)addItem:(NSImage*)icon;
- (void)removeItemAtIndex:(NSUInteger)index;
- (void)selectItemAtIndex:(NSUInteger)index;

@end

/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEVerticalTabBarDelegate.h"

typedef enum
{
    CEVerticalTabBarPositionLeft  = 0x00,
    CEVerticalTabBarPositionRight = 0x01
}
CEVerticalTabBarPosition;

@interface CEVerticalTabBar: NSView
{
@protected
    
    NSMutableArray                * _titles;
    NSMutableArray                * _icons;
    CEVerticalTabBarPosition        _position;
    id < CEVerticalTabBarDelegate > _delegate;
    
@private
    
    RESERVED_IVARS( CEVerticalTabBar, 5 );
}

@property( atomic, readwrite, assign ) CEVerticalTabBarPosition        position;
@property( atomic, readwrite, assign ) id < CEVerticalTabBarDelegate > delegate;

- ( void )addItemWithTitle: ( NSString * )title icon: ( NSImage * )icon;
- ( void )removeItemAtIndex: ( NSUInteger )index;

@end

/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#include "CEVerticalTabBar.h"

@interface CEVerticalTabView: NSView
{
@protected
    
    CGFloat                     _tabBarWidth;
    CEVerticalTabBar          * _tabBar;
    NSView                    * _contentView;
    NSMutableArray            * _views;
    CEVerticalTabBarPosition    _tabBarPosition;
    
@private
    
    RESERVED_IVARS( CESideBar, 5 );
}

@property( atomic, readwrite, assign ) CGFloat                  tabBarWidth;
@property( atomic, readwrite, assign ) CEVerticalTabBarPosition tabBarPosition;

- ( void )addView: ( NSView * )view title: ( NSString * )title icon: ( NSImage * )icon;
- ( void )removeViewAtIndex: ( NSUInteger )index;
- ( void )removeView: ( NSView * )view;

@end

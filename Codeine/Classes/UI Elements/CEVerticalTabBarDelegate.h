/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@class CEVerticalTabBar;

@protocol CEVerticalTabBarDelegate < NSObject >

@optional

- ( void )verticalTabBar: ( CEVerticalTabBar * )tabBar didSelectItemAtIndex: ( NSUInteger )index;

@end

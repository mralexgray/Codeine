/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEVerticalTabView+CEVerticalTabBarDelegate.h"

@implementation CEVerticalTabView( CEVerticalTabBarDelegate )

- ( void )verticalTabBar: ( CEVerticalTabBar * )tabBar didSelectItemAtIndex: ( NSUInteger )index
{
    NSView * view;
    
    ( void )tabBar;
    
    for( view in _contentView.subviews )
    {
        [ view removeFromSuperview ];
    }
    
    @try
    {
        view                  = [ _views objectAtIndex: index ];
        view.frame            = _contentView.bounds;
        view.autoresizingMask = NSViewWidthSizable
                              | NSViewHeightSizable;
        
        [ _contentView addSubview: view ];
    }
    @catch( NSException * e )
    {
        ( void )e;
    }
}

@end

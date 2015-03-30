
/* $Id$ */

#import "CEVerticalTabView+CEVerticalTabBarDelegate.h"

@implementation CEVerticalTabView( CEVerticalTabBarDelegate )

- ( void )verticalTabBar: ( CEVerticalTabBar * )tabBar didSelectItemAtIndex: ( NSUInteger )index
{
    NSView * view;
    

    
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
        
        if( _delegate != nil && [ _delegate respondsToSelector: @selector( verticalTabView:didSelectViewAtIndex: ) ] )
        {
            [ _delegate verticalTabView: self didSelectViewAtIndex: index ];
        }
    }
    @catch( NSException * e )
    {

    }
}

@end

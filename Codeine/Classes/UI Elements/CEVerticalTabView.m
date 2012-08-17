/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEVerticalTabView.h"
#import "CEVerticalTabView+CEVerticalTabBarDelegate.h"
#import "CEVerticalTabBar.h"

@implementation CEVerticalTabView

@synthesize delegate = _delegate;

- ( id )initWithFrame: ( NSRect )frame
{
    if( ( self = [ super initWithFrame: frame ] ) )
    {
        _tabBarPosition = CEVerticalTabBarPositionLeft;
        _tabBarWidth    = ( CGFloat )64;
        _tabBar         = [ [ CEVerticalTabBar alloc ] initWithFrame: CGRectMake( 0, 0, _tabBarWidth, frame.size.height ) ];
        _contentView    = [ [ NSView alloc ] initWithFrame: CGRectMake( _tabBarWidth, 0, frame.size.width - _tabBarWidth, frame.size.height ) ];
        
        _tabBar.autoresizingMask      = NSViewHeightSizable
                                      | NSViewMinYMargin
                                      | NSViewMaxYMargin;
        _contentView.autoresizingMask = NSViewHeightSizable
                                      | NSViewMinYMargin
                                      | NSViewMaxYMargin;
        
        _tabBar.delegate = self;
        
        [ self addSubview: _tabBar ];
        [ self addSubview: _contentView ];
        
        _views = [ [ NSMutableArray alloc ] initWithCapacity: 10 ];
        
    }
    
    return self;
}

- ( void )dealloc
{
    RELEASE_IVAR( _tabBar );
    RELEASE_IVAR( _contentView );
    RELEASE_IVAR( _views );
    
    [ super dealloc ];
}

- ( void )setFrame: ( NSRect )frame
{
    [ super setFrame: frame ];
    [ self setTabBarPosition: _tabBarPosition ];
}

- ( CGFloat )tabBarWidth
{
    @synchronized( self )
    {
        return _tabBarWidth;
    }
}

- ( void )setTabBarWidth: ( CGFloat )tabWidth
{
    CGRect frame;
    
    frame = self.bounds;
    
    @synchronized( self )
    {
        _tabBarWidth       = tabWidth;
        _tabBar.frame      = CGRectMake( 0, 0, _tabBarWidth, frame.size.height );
        _contentView.frame = CGRectMake( _tabBarWidth, 0, frame.size.width - _tabBarWidth, frame.size.height );
    }
}

- ( CEVerticalTabBarPosition )tabBarPosition
{
    @synchronized( self )
    {
        return _tabBarPosition;
    }
}

- ( void )setTabBarPosition: ( CEVerticalTabBarPosition )position
{
    CGRect frame;
    
    frame = self.bounds;
    
    @synchronized( self )
    {
        _tabBarPosition = position;
        
        if( _tabBarPosition == CEVerticalTabBarPositionLeft )
        {
            _tabBar.frame      = CGRectMake( ( CGFloat )0, ( CGFloat )0, _tabBarWidth, frame.size.height );
            _contentView.frame = CGRectMake( _tabBarWidth, ( CGFloat )0, frame.size.width - _tabBarWidth, frame.size.height );
        }
        else if( _tabBarPosition == CEVerticalTabBarPositionRight )
        {
            _tabBar.frame      = CGRectMake( frame.size.width - _tabBarWidth, 0, _tabBarWidth, frame.size.height );
            _contentView.frame = CGRectMake( ( CGFloat )0, ( CGFloat )0, frame.size.width - _tabBarWidth, frame.size.height );
        }
        
        [ _tabBar setPosition: position ];
    }
}

- ( void )addView: ( NSView * )view icon: ( NSImage * )icon
{
    [ _views addObject: view ];
    [ _tabBar addItem: icon ];
    
    if( _views.count == 1 )
    {
        [ self verticalTabBar: _tabBar didSelectItemAtIndex: 0 ];
    }
}

- ( void )removeViewAtIndex: ( NSUInteger )index
{
    @try
    {
        [ _views removeObjectAtIndex: index ];
        [ _tabBar removeItemAtIndex: index ];
    }
    @catch(  NSException * e )
    {
        ( void )e;
    }
}

- ( void )removeView: ( NSView * )view
{
    NSUInteger index;
    
    index = [ _views indexOfObject: view ];
    
    if( index != NSNotFound )
    {
        [ self removeViewAtIndex: index ];
    }
}

- ( void )selectViewAtIndex: ( NSUInteger )index
{
    [ _tabBar selectItemAtIndex: index ];
}

@end

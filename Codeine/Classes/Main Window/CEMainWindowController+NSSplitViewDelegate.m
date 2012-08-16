/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEMainWindowController+NSSplitViewDelegate.h"
#import "CEPreferences.h"

@implementation CEMainWindowController( NSSplitViewDelegate )

- ( CGFloat )splitView: ( NSSplitView * )splitView constrainMinCoordinate: ( CGFloat )proposedMin ofSubviewAt: ( NSInteger )dividerIndex
{
    ( void )dividerIndex;
    
    if( splitView == _horizontalSplitView )
    {
        return ( CGFloat )200;
    }
    else if( splitView == _verticalSplitView )
    {
        return ( CGFloat )200;
    }
    
    return proposedMin;
}

- ( CGFloat )splitView: ( NSSplitView * )splitView constrainMaxCoordinate: ( CGFloat )proposedMax ofSubviewAt: ( NSInteger )dividerIndex
{
    ( void )dividerIndex;
    
    if( splitView == _horizontalSplitView )
    {
        return _horizontalSplitView.frame.size.width - ( CGFloat )400;
    }
    else if( splitView == _verticalSplitView )
    {
        return _verticalSplitView.frame.size.height - ( CGFloat )100;
    }
    
    return proposedMax;
}

- ( void )splitViewDidResizeSubviews: ( NSNotification * )notification
{
    ( void )notification;
    
    if( self.window.isVisible == NO || self.window.isKeyWindow == NO )
    {
        return;
    }
    
    if( _fileBrowserHidden == NO )
    {
        [ [ CEPreferences sharedInstance ] setFileBrowserWidth: _leftView.frame.size.width ];
    }
    
    if( _debugAreaHidden == NO )
    {
        [ [ CEPreferences sharedInstance ] setDebugAreaHeight: _bottomView.frame.size.height ];
    }
}

@end

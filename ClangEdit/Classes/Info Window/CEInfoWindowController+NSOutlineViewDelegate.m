/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEInfoWindowController+NSOutlineViewDelegate.h"
#import "CEInfoWindowController+Private.h"

@implementation CEInfoWindowController( NSOutlineViewDelegate )

- ( NSView * )outlineView: ( NSOutlineView * )outlineView viewForTableColumn: ( NSTableColumn * )tableColumn item: ( id )item
{
    ( void )outlineView;
    ( void )tableColumn;
    
    return item;
}

- ( BOOL )outlineView: ( NSOutlineView * )outlineView shouldSelectItem: ( id )item
{
    ( void )outlineView;
    ( void )item;
    
    return NO;
}

- ( CGFloat )outlineView: ( NSOutlineView * )outlineView heightOfRowByItem: ( id )item
{
    ( void )outlineView;
    
    if( [ item isKindOfClass: [ NSView class ] ] == NO )
    {
        return 0;
    }
    
    return ( ( NSView * )item ).frame.size.height;
}

- ( void )outlineViewItemWillCollapse: ( NSNotification * )notification
{
    ( void )notification;
    
    [ self resizeWindow: YES ];
}

- ( void )outlineViewItemWillExpand: ( NSNotification * )notification
{
    ( void )notification;
    
    [ self resizeWindow: YES ];
}

@end

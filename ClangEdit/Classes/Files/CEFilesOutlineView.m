/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFilesOutlineView.h"
#import "CEFileViewItem.h"
#import <Carbon/../Frameworks/HIToolbox.framework/Headers/Events.h>

@implementation CEFilesOutlineView

- ( void )keyDown: ( NSEvent * )e
{
    CEFileViewItem * item;
    
    if( e.keyCode == kVK_Return && self.selectedRow != -1 )
    {
        item = [ self itemAtRow: self.selectedRow ];
        
        if( [ item isKindOfClass: [ CEFileViewItem class ] ] == YES )
        {
            if( item.type == CEFileViewItemTypeFS && item.expandable == YES )
            {
                if( [ self isItemExpanded: item ] == YES )
                {
                    [ self collapseItem: item ];
                }
                else
                {
                    [ self expandItem: item ];
                }
                
                return;
            }
        }
    }
    
    [ super keyDown: e ];
}

- ( void )mouseDown: ( NSEvent * )e
{
    NSPoint                             point;
    NSInteger                           row;
    CGRect                              frame;
    id < CEFilesOutlineViewDelegate >   delegate;
    
    point       = [ self convertPoint: [ e locationInWindow ] fromView: nil ];
    row         = [ self rowAtPoint: point ];
    frame       = [ self frameOfOutlineCellAtRow: row ];
    delegate    = nil;
    
    point.x = point.x - frame.origin.x;
    point.y = point.y - frame.origin.y;
    
    if( [ self.delegate conformsToProtocol: @protocol( CEFilesOutlineViewDelegate ) ] )
    {
        delegate = ( id < CEFilesOutlineViewDelegate > )( self.delegate );
    }
    
    if( [ delegate respondsToSelector: @selector( outlineView:shouldClickOnRow:atPoint: ) ] )
    {
        if( [ delegate outlineView: self shouldClickOnRow: row atPoint: point ] == NO )
        {
            return;
        }
    }
    
    if( [ delegate respondsToSelector: @selector( outlineView:willClickOnRow:atPoint: ) ] )
    {
        [ delegate outlineView: self willClickOnRow: row atPoint: point ];
    }
    
    [ super mouseDown: e ];
    
    if( [ delegate respondsToSelector: @selector( outlineView:didClickOnRow:atPoint: ) ] )
    {
        [ delegate outlineView: self didClickOnRow: row atPoint: point ];
    }
}

- ( NSMenu * )menuForEvent: ( NSEvent * )e
{
    NSPoint                           point;
    NSInteger                         row;
    NSMenu                          * menu;
    id < CEFilesOutlineViewDelegate > delegate;
    
    point    = [ self convertPoint: [ e locationInWindow ] fromView: nil ];
    row      = [ self rowAtPoint: point ];
    menu     = nil;
    delegate = nil;
    
    if( [ self.delegate conformsToProtocol: @protocol( CEFilesOutlineViewDelegate ) ] )
    {
        delegate = ( id < CEFilesOutlineViewDelegate > )( self.delegate );
    }
    
    if( [ delegate respondsToSelector: @selector( outlineView:menuForRow: ) ] )
    {
        menu = [ delegate outlineView: self menuForRow: row ];
    }
    
    return menu;
}

@end

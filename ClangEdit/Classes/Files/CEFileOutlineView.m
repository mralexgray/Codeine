/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFileOutlineView.h"
#import "CEFileViewItem.h"
#import <Carbon/../Frameworks/HIToolbox.framework/Headers/Events.h>

@implementation CEFileOutlineView

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
    id < CEFileOutlineViewDelegate >    delegate;
    
    point       = [ self convertPoint: [ e locationInWindow ] fromView: nil ];
    row         = [ self rowAtPoint: point ];
    delegate    = nil;
    
    if( [ self.delegate conformsToProtocol: @protocol( CEFileOutlineViewDelegate ) ] )
    {
        delegate = ( id < CEFileOutlineViewDelegate > )( self.delegate );
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

@end

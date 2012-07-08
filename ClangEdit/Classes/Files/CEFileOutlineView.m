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

@end

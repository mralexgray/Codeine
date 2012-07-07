/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFilesViewController+NSOutlineViewDelegate.h"
#import "CEFileViewItem.h"

@implementation CEFilesViewController( NSOutlineViewDelegate )

- ( BOOL )outlineView: ( NSOutlineView * )outlineView isGroupItem: ( id )item
{
    CEFileViewItem * filesViewItem;
    
    ( void )outlineView;
    
    if( [ item isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return NO;
    }
    
    filesViewItem = ( CEFileViewItem * )item;
    
    return ( BOOL )( filesViewItem.type == CEFileViewItemTypeSection );
}

@end

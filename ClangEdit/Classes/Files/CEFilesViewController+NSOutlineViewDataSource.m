/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEFilesViewController+NSOutlineViewDataSource.h"
#import "CEFileViewItem.h"

@implementation CEFilesViewController( NSOutlineViewDataSource )

- ( NSInteger )outlineView: ( NSOutlineView * )outlineView numberOfChildrenOfItem: ( id )item
{
    CEFileViewItem * fileViewItem;
    
    ( void )outlineView;
    
    if( item == nil )
    {
        return ( NSInteger )( _rootItems.count );
    }
    
    if( [ item isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return 0;
    }
    
    fileViewItem = ( CEFileViewItem * )item;
    
    return ( NSInteger )( fileViewItem.childrens.count );
}

- ( BOOL )outlineView: ( NSOutlineView * )outlineView isItemExpandable: ( id )item
{
    CEFileViewItem * fileViewItem;
    
    ( void )outlineView;
    
    if( [ item isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return NO;
    }
    
    fileViewItem = ( CEFileViewItem * )item;
    
    if( fileViewItem.type == CEFileViewItemTypeSection )
    {
        return NO;
    }
    else if( fileViewItem.type == CEFileViewItemTypeDocument )
    {
        return NO;
    }
    
    return ( BOOL )( fileViewItem.childrens.count > 0 );
}

- ( id )outlineView: ( NSOutlineView * )outlineView child: ( NSInteger )index ofItem: ( id )item
{
    ( void )outlineView;
    
    if( item == nil )
    {
        @try
        {
            return [ _rootItems objectAtIndex: ( NSUInteger )index ];
        }
        @catch( NSException * e )
        {
            ( void )e;
            
            return nil;
        }
    }
    
    return nil;
}

- ( id )outlineView: ( NSOutlineView * )outlineView objectValueForTableColumn: ( NSTableColumn * )tableColumn byItem: ( id )item
{
    CEFileViewItem * fileViewItem;
    
    ( void )outlineView;
    ( void )tableColumn;
    
    if( [ item isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return nil;
    }
    
    fileViewItem = ( CEFileViewItem * )item;
    
    if( fileViewItem.type == CEFileViewItemTypeSection )
    {
        return fileViewItem.name;
    }
    
    return nil;
}

@end

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
    
    return ( NSInteger )( fileViewItem.children.count );
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
    
    return fileViewItem.expandable;
}

- ( id )outlineView: ( NSOutlineView * )outlineView child: ( NSInteger )index ofItem: ( id )item
{
    CEFileViewItem * fileViewItem;
    
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
    
    if( [ item isKindOfClass: [ CEFileViewItem class ] ] == NO )
    {
        return nil;
    }
    
    fileViewItem = ( CEFileViewItem * )item;
    
    @try
    {
        return [ fileViewItem.children objectAtIndex: ( NSUInteger )index ];
    }
    @catch (NSException * e)
    {
        ( void )e;
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
    
    return ( fileViewItem.type == CEFileViewItemTypeSection ) ? fileViewItem.name : fileViewItem;
}

@end

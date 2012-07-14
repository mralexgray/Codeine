/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEInfoWindowController+NSOutlineViewDataSource.h"

@implementation CEInfoWindowController( NSOutlineViewDataSource )

- ( NSInteger )outlineView: ( NSOutlineView * )outlineView numberOfChildrenOfItem: ( id )item
{
    ( void )outlineView;
    
    if( item == nil )
    {
        return 4;
    }
    
    if( item == _generalLabelView )     { return 1; }
    if( item == _iconLabelView )        { return 1; }
    if( item == _permissionsLabelView ) { return 1; }
    
    return 0;
}

- ( BOOL )outlineView: ( NSOutlineView * )outlineView isItemExpandable: ( id )item
{
    ( void )outlineView;
    ( void )item;
    
    if( item == _generalLabelView )     { return YES; }
    if( item == _iconLabelView )        { return YES; }
    if( item == _permissionsLabelView ) { return YES; }
    
    return NO;
}

- ( id )outlineView: ( NSOutlineView * )outlineView child: ( NSInteger )index ofItem: ( id )item
{
    ( void )outlineView;
    ( void )index;
    
    if( item == nil )
    {
        switch ( index )
        {
            case 0:
                
                return _infoView;
                
            case 1:
                
                return _generalLabelView;
                
            case 2:
                
                return _iconLabelView;
                
            case 3:
                
                return _permissionsLabelView;
                
            default:
                
                return nil;
        }
    }
    
    if( item == _generalLabelView )     { return _generalView; }
    if( item == _iconLabelView )        { return _iconView; }
    if( item == _permissionsLabelView ) { return _permissionsView; }
    
    return nil;
}

- ( id )outlineView: ( NSOutlineView * )outlineView objectValueForTableColumn: ( NSTableColumn * )tableColumn byItem: ( id )item
{
    ( void )outlineView;
    ( void )tableColumn;
    ( void )item;
    
    return nil;
}

- ( id )outlineView: ( NSOutlineView * )outlineView itemForPersistentObject: ( id )object
{
    ( void )outlineView;
    
    if( [ object isKindOfClass: [ NSNumber class ] ] == NO )
    {
        return nil;
    }
    
    if( [ ( NSNumber * )object integerValue ] == 0 ) { return _generalLabelView; }
    if( [ ( NSNumber * )object integerValue ] == 1 ) { return _iconLabelView; }
    if( [ ( NSNumber * )object integerValue ] == 2 ) { return _permissionsLabelView; }
    
    return nil;
}

- ( id )outlineView: ( NSOutlineView * )outlineView persistentObjectForItem: ( id )item
{
    ( void )outlineView;
    
    if( item == _generalLabelView     ) { return [ NSNumber numberWithInteger: 0 ]; }
    if( item == _iconLabelView        ) { return [ NSNumber numberWithInteger: 1 ]; }
    if( item == _permissionsLabelView ) { return [ NSNumber numberWithInteger: 2 ]; }
    
    return nil;
}

@end

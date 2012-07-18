/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "NSApplication+CE.h"
#import "CEQuickLookItem.h"

static id < QLPreviewItem > __quickLookPreviewItem = nil;

static void __exit( void ) __attribute__( ( destructor ) );
static void __exit( void )
{
    RELEASE_IVAR( __quickLookPreviewItem );
}

@implementation NSApplication( CE )

- ( void )showQuickLookPanelForItemAtPath: ( NSString * )path sender: ( id )sender
{
    RELEASE_IVAR( __quickLookPreviewItem );
    
    __quickLookPreviewItem = [ [ CEQuickLookItem alloc ] initWithPath: path ];
    
    if( __quickLookPreviewItem != nil )
    {
        [ [ QLPreviewPanel sharedPreviewPanel ] updateController ];
        [ [ QLPreviewPanel sharedPreviewPanel ] makeKeyAndOrderFront: sender ];
    }
    else
    {
        NSBeep();
    }
}

- ( BOOL )acceptsPreviewPanelControl: ( QLPreviewPanel * )panel
{
    ( void )panel;
    
    return __quickLookPreviewItem != nil;
}

- ( void )beginPreviewPanelControl: ( QLPreviewPanel * )panel
{
    ( void )panel;
    
    [ panel setDataSource: self ];
}

- ( void )endPreviewPanelControl: ( QLPreviewPanel * )panel
{
    ( void )panel;
    
    [ panel setDataSource: nil ];
    
    RELEASE_IVAR( __quickLookPreviewItem );
}

- ( NSInteger )numberOfPreviewItemsInPreviewPanel: ( QLPreviewPanel * )panel
{
    ( void )panel;
    
    if( __quickLookPreviewItem != nil )
    {
        return 1;
    }
    
    return 0;
}

- ( id < QLPreviewItem > )previewPanel: ( QLPreviewPanel * )panel previewItemAtIndex: ( NSInteger )index
{
    ( void )panel;
    
    if( index != 0 )
    {
        return nil;
    }
    
    return __quickLookPreviewItem;
}

@end

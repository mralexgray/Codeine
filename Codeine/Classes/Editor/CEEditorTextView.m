/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEEditorTextView.h"
#import "CEEditorTextView+Private.h"
#import "CEPreferences.h"

@implementation CEEditorTextView

- ( id )initWithFrame:(NSRect)frameRect
{
    if( ( self = [ super initWithFrame: frameRect ] ) )
    {
        [ NOTIFICATION_CENTER addObserver: self selector: @selector( selectionDidChange: ) name: NSTextViewDidChangeSelectionNotification object: self ];
    }
    
    return self;
}

- ( id )initWithCoder:(NSCoder *)coder
{
    if( ( self = [ super initWithCoder: coder ] ) )
    {
        [ NOTIFICATION_CENTER addObserver: self selector: @selector( selectionDidChange: ) name: NSTextViewDidChangeSelectionNotification object: self ];
    }
    
    return self;
}

- ( void )dealloc
{
    [ NOTIFICATION_CENTER removeObserver: self ];
    
    [ super dealloc ];
}

- ( void )drawRect: ( NSRect )rect
{
    [ super drawRect: rect ];
}

- ( void )drawViewBackgroundInRect: ( NSRect )rect
{
    [ super drawViewBackgroundInRect: rect ];
    
    if( [ [ CEPreferences sharedInstance ] showPageGuide ] == YES )
    {
        [ self drawPageGuideInRect: rect ];
    }
    
    if( [ [ CEPreferences sharedInstance ] showTabStops ] == YES )
    {
        [ self drawTabStopsInRect: rect ];
    }
    
    if( 1 )
    {
        [ self drawCurrentLineHighlight: rect ];
    }
}


@end

/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEEditorTextView.h"
#import "CEEditorTextView+Private.h"
#import "CEPreferences.h"

@implementation CEEditorTextView

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
}

@end

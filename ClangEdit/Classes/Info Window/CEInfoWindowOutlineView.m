/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEInfoWindowOutlineView.h"

@implementation CEInfoWindowOutlineView

- ( id )initWithFrame: ( NSRect )frame
{
    if( ( self = [ super initWithFrame: frame ] ) )
    {
        [ [ self enclosingScrollView ] setDrawsBackground: NO ];
    }
    
    return self;
}

- ( id )initWithCoder: ( NSCoder * )coder
{
    if( ( self = [ super initWithCoder: coder ] ) )
    {
        [ [ self enclosingScrollView ] setDrawsBackground: NO ];
    }
    
    return self;
}

- ( BOOL )isOpaque
{
    return NO;
}

- ( void )drawBackgroundInClipRect: ( NSRect )rect
{
    ( void )rect;
}

@end

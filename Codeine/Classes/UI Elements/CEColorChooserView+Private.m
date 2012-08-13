/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEColorChooserView+Private.h"

@implementation CEColorChooserView( Private )

- ( void )changeColor: ( id )sender
{
    ( void )sender;
    
    if( _delegate != nil && [ _delegate respondsToSelector: @selector( colorChooserView:didChooseColor: ) ] == YES )
    {
        [ _delegate colorChooserView: self didChooseColor: _colorWell.color ];
    }
}

@end

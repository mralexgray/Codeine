/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CETextEncodingPopUpButton.h"
#import "CETextEncodingPopUpButton+Private.h"
#import "CETextEncoding.h"

@implementation CETextEncodingPopUpButton

- ( id )initWithFrame: ( NSRect )frame
{
    if( ( self = [ super initWithFrame: frame ] ) )
    {
        [ self fillItems ];
    }
    
    return self;
}

- ( id )initWithCoder: ( NSCoder * )coder
{
    if( ( self = [ super initWithCoder: coder ] ) )
    {
        [ self fillItems ];
    }
    
    return self;
}

- ( CETextEncoding * )selectedTextEncoding
{
    NSMenuItem * item;
    
    item = [ self selectedItem ];
    
    return ( CETextEncoding * )( item.representedObject );
}

- ( NSStringEncoding )selectedStringEncoding
{
    NSMenuItem     * item;
    CETextEncoding * encoding;
    
    item     = [ self selectedItem ];
    encoding = ( CETextEncoding * )( item.representedObject );
    
    return encoding.value;
}

@end

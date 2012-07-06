/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CETextEncodingPopUpButton+Private.h"
#import "CETextEncoding.h"
#import "CEPreferences.h"

@implementation CETextEncodingPopUpButton( Private )

- ( void )fillItems
{
    NSArray        * encodings;
    CETextEncoding * encoding;
    NSMenuItem     * item;
    
    encodings = [ CETextEncoding availableEncodings ];
    
    for( encoding in encodings )
    {
        [ self addItemWithTitle: encoding.localizedName ];
        
        item                   = [ self itemWithTitle: encoding.localizedName ];
        item.representedObject = encoding;
        
        if( encoding.value == [ [ CEPreferences sharedInstance ] textEncoding ] )
        {
            [ self selectItem: item ];
        }
    }
}

@end

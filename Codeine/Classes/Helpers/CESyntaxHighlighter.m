/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CESyntaxHighlighter.h"
#import "CESyntaxHighlighter+Private.h"

@implementation CESyntaxHighlighter

- ( id )initWithTextView: ( NSTextView * )textView sourceFile: ( CESourceFile * )sourceFile
{
    if( ( self = [ self init ] ) )
    {
        _textView   = [ textView retain ];
        _sourceFile = [ sourceFile retain ];
    }
    
    return self;
}

- ( void )dealloc
{
    RELEASE_IVAR( _textView );
    RELEASE_IVAR( _sourceFile );
    
    [ super dealloc ];
}

- ( void )highlight
{}

- ( void )startHighlighting
{}

- ( void )stopHighlighting
{}

@end

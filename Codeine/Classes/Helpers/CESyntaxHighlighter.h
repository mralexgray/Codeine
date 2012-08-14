/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@class CESourceFile;

@interface CESyntaxHighlighter: NSObject
{
@protected
    
    NSTextView   * _textView;
    CESourceFile * _sourceFile;
    
@private
    
    RESERVED_IVARS( CESyntaxHighlighter, 5 );
}

- ( id )initWithTextView: ( NSTextView * )textView sourceFile: ( CESourceFile * )sourceFile;
- ( void )highlight;
- ( void )startHighlighting;
- ( void )stopHighlighting;

@end

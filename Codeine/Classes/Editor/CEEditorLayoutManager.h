/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@interface CEEditorLayoutManager: NSLayoutManager
{
@protected
    
    NSTextView * _textView;
    BOOL         _showInvisibles;
    BOOL         _showSpaces;
    CGSize       _glyphSize;
    CGFloat      _firstGlyphLeftMargin;
    
@private
    
    RESERVED_IVARS( CEEditorLayoutManager , 5 );
}

@property( atomic, readwrite, assign ) BOOL    showInvisibles;
@property( atomic, readwrite, assign ) BOOL    showSpaces;
@property( atomic, readonly          ) CGSize  glyphSize;
@property( atomic, readonly          ) CGFloat firstGlyphLeftMargin;

@end

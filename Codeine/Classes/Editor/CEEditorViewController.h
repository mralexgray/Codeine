/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEViewController.h"

@class CESourceFile;
@class CEEditorLayoutManager;
@class CEEditorRulerView;
@class CEDocument;
@class CESyntaxHighlighter;

@interface CEEditorViewController: CEViewController
{
@protected
    
    NSTextView              * _textView;
    CEDocument              * _document;
    CEEditorLayoutManager   * _layoutManager;
    CEEditorRulerView       * _rulerView;
    CESyntaxHighlighter     * _highlighter;
    
@private
    
    RESERVED_IVARS( CEEditorViewController , 5 );
}

@property( nonatomic, readwrite, retain ) IBOutlet NSTextView * textView;
@property(    atomic, readwrite, retain )          CEDocument * document;

@end

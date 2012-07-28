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

@interface CEEditorViewController: CEViewController
{
@protected
    
    NSTextView              * _textView;
    CEDocument              * _document;
    CEEditorLayoutManager   * _layoutManager;
    CEEditorRulerView       * _rulerView;
    
@private
    
    RESERVED_IVARS( CEEditorViewController , 5 );
}

@property( nonatomic, readwrite, retain ) IBOutlet NSTextView * textView;
@property(    atomic, readwrite, retain )          CEDocument * document;

@end

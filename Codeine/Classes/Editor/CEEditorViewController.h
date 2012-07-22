/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEViewController.h"

@class CESourceFile;
@class CEEditorLayoutManager;
@class CEEditorRulerView;

@interface CEEditorViewController: CEViewController
{
@protected
    
    NSTextView              * _textView;
    CESourceFile            * _sourceFile;
    CEEditorLayoutManager   * _layoutManager;
    CEEditorRulerView       * _rulerView;
    
@private
    
    RESERVERD_IVARS( CEEditorViewController , 5 );
}

@property( nonatomic, readwrite, retain ) IBOutlet NSTextView   * textView;
@property(    atomic, readwrite, retain )          CESourceFile * sourceFile;

@end

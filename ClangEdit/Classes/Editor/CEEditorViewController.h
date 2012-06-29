/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEViewController.h"

@class CESourceFile;

@interface CEEditorViewController: CEViewController
{
@protected
    
    NSTextView   * _textView;
    CESourceFile * _sourceFile;
    
@private
    
    RESERVERD_IVARS( CEEditorViewController , 5 );
}

@property( nonatomic, readwrite, retain ) IBOutlet NSTextView   * textView;
@property(    atomic, readwrite, retain )          CESourceFile * sourceFile;

@end

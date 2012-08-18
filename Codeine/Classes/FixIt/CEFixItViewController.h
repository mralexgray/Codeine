/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEViewController.h"

@interface CEFixItViewController: CEViewController
{
@protected
    
    CKDiagnostic * _diagnostic;
    NSTextView   * _textView;
    NSTextField  * _messageTextField;
    NSImageView  * _iconView;
    
@private
    
    RESERVED_IVARS( CEFixItViewController, 5 );
}

@property(    atomic, readwrite, retain )          NSTextView   * textView;
@property( nonatomic, readwrite, retain ) IBOutlet NSTextField  * messageTextField;
@property( nonatomic, readwrite, retain ) IBOutlet NSImageView  * iconView;

- ( id )initWithDiagnostic: ( CKDiagnostic * )diagnostic;

@end

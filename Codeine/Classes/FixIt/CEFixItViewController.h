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
    NSTextField  * _lineTextField;
    NSTextField  * _columnTextField;
    NSTextField  * _messageTextField;
    NSImageView  * _iconView;
    NSButton     * _button;
    
@private
    
    RESERVED_IVARS( CEFixItViewController, 5 );
}

@property(    atomic, readwrite, retain )          NSTextView   * textView;
@property( nonatomic, readwrite, retain ) IBOutlet NSTextField  * lineTextField;
@property( nonatomic, readwrite, retain ) IBOutlet NSTextField  * columnTextField;
@property( nonatomic, readwrite, retain ) IBOutlet NSTextField  * messageTextField;
@property( nonatomic, readwrite, retain ) IBOutlet NSImageView  * iconView;
@property( nonatomic, readwrite, retain ) IBOutlet NSButton     * button;

- ( id )initWithDiagnostic: ( CKDiagnostic * )diagnostic;
- ( IBAction )fix: ( id )sender;

@end

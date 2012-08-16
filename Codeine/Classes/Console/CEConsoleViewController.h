/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEViewController.h"

@interface CEConsoleViewController: CEViewController
{
@protected
    
    NSTextView * _textView;
    
@private
    
    RESERVED_IVARS( CEConsoleViewController, 5 );
}

@property( nonatomic, readwrite, retain ) IBOutlet NSTextView * textView;

@end

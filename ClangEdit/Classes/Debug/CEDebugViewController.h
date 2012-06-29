/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEViewController.h"

@interface CEDebugViewController: CEViewController
{
@protected
    
    NSTextView * _textView;
    
@private
    
    RESERVERD_IVARS( CEDebugViewController , 5 );
}

@property( nonatomic, readwrite, retain ) IBOutlet NSTextView * textView;



@end

/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CESyntaxHighlighter+Private.h"
#import "CESourceFile.h"
#import "CEPreferences.h"

@implementation CESyntaxHighlighter( Private )

- ( void )updateText
{
    if( _lock == nil )
    {
        _lock = [ NSLock new ];
    }
    
    while( [ _lock tryLock ] == NO )
    {}
    
    {
        _sourceFile.text = _textView.textStorage.string;
		
        dispatch_async
        (
            dispatch_get_main_queue(),
            ^
            {
                [ self highlight ];
            }
        );
        
        [ _lock unlock ];
    }
}

- ( void )textDidChange: ( NSNotification * )notification
{
    ( void )notification;
    
    [ NSThread detachNewThreadSelector: @selector( updateText ) toTarget: self withObject: nil ];
}

@end

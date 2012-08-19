/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEEditorViewController+NSTextViewDelegate.h"
#import "CEPreferences.h"

@implementation CEEditorViewController( NSTextViewDelegate )

- ( BOOL )textView: ( NSTextView * )textView doCommandBySelector: ( SEL )sel
{
    NSRange           range;
    NSUInteger        spaces;
    NSUInteger        i;
    NSMutableString * text;
    
    if( sel == @selector( insertTab: ) && [ [ CEPreferences sharedInstance ] autoExpandTabs ] == YES )
    {
        range  = textView.selectedRange;
        spaces = range.location % 4;
        text   = [ NSMutableString string ];
        
        for( i = 4; i > spaces; i-- )
        {
            [ text appendString: @" " ];
        }
        
        [ _textView insertText: text ];
        
        return YES;
    }
    
    return NO;
}

@end

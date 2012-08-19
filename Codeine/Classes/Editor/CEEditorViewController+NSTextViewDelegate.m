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
    if( sel == @selector( insertTab: ) && [ [ CEPreferences sharedInstance ] autoExpandTabs ] == YES )
    {
        {
            NSInteger         column;
            NSUInteger        spaces;
            NSUInteger        i;
            NSMutableString * text;
            
            column = [ textView currentColumn ];
            
            if( column == NSNotFound )
            {
                return NO;
            }
            
            column = column - 1;
            spaces = column % 4;
            text   = [ NSMutableString string ];
            
            for( i = 4; i > spaces; i-- )
            {
                [ text appendString: @" " ];
            }
            
            [ _textView insertText: text ];
            
            return YES;
        }
    }
    else if( sel == @selector( insertNewline: ) && [ [ CEPreferences sharedInstance ] autoIndent ] == YES )
    {
        NSLog( @"OK" );
    }
    
    return NO;
}

@end

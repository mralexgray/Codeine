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
			NSUInteger        tabWidth;
            
			tabWidth = [ [ CEPreferences sharedInstance ] tabWidth ];
            column   = [ textView currentColumn ];
            
            if( column == NSNotFound )
            {
                return NO;
            }
            
            column = column - 1;
            spaces = ( NSUInteger )column % tabWidth;
            text   = [ NSMutableString string ];
            
            for( i = tabWidth; i > spaces; i-- )
            {
                [ text appendString: @" " ];
            }
            
            [ _textView insertText: text ];
            
            return YES;
        }
    }
    else if( sel == @selector( insertNewline: ) && [ [ CEPreferences sharedInstance ] autoIndent ] == YES )
    {
        {
            NSRange           range;
            NSString        * text;
            NSMutableString * indent;
            NSUInteger        i;
            UniChar           c;
            UniChar           lastChar;
			NSMutableString	* spaces;
            
            text        = textView.textStorage.string;
            range       = textView.selectedRange;
            range       = [ text lineRangeForRange: range ];
            text        = [ text substringWithRange: range ];
            indent      = [ NSMutableString string ];
            lastChar    = [ text characterAtIndex: text.length - 1 ];
            spaces      = [ NSMutableString string ];
            
            for( i = 0; i < [ [ CEPreferences sharedInstance ] tabWidth ]; i++ )
            {
                [ spaces appendString: @" " ];
            }
            
            for( i = 0; i < text.length; i++ )
            {
                c = [ text characterAtIndex: i ];
                
                if( c == ' ' )
                {
                    [ indent appendString: @" " ];
                }
                else if( c == '\t' )
                {
                    [ indent appendString: @" " ];
                }
                else
                {
                    if( c == '{' || lastChar == '{' )
                    {
                        [ indent appendString: ( [ [ CEPreferences sharedInstance ] autoExpandTabs ] == YES ) ? spaces : @"\t" ];
                    }
                    else if( c == '[' || lastChar == '[' )
                    {
                        [ indent appendString: ( [ [ CEPreferences sharedInstance ] autoExpandTabs ] == YES ) ? spaces : @"\t" ];
                    }
                    else if( c == '(' || lastChar == '(' )
                    {
                        [ indent appendString: ( [ [ CEPreferences sharedInstance ] autoExpandTabs ] == YES ) ? spaces : @"\t" ];
                    }
                    
                    break;
                }
            }
            
            [ textView insertText: [ NSString stringWithFormat: @"\n%@", indent ] ];
            
            return YES;
        }
    }
    
    return NO;
}

@end

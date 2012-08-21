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
            NSMutableString * indent;
            NSString        * text;
            NSUInteger        tabWidth;
            NSRange           range;
            NSRange           lineRange;
            UniChar           c;
            NSUInteger        location;
            
            range       = textView.selectedRange;
            text        = textView.textStorage.string;
            lineRange   = [ text lineRangeForRange: range ];
            text        = [ text substringWithRange: NSMakeRange( range.location, lineRange.length - ( range.location - lineRange.location ) ) ];
            location    = 0;
            
            for( i = 0; i < text.length; i++ )
            {
                c = [ text characterAtIndex: i ];
                
                if( c != ' ' )
                {
                    break;
                }
                
                location++;
            }
            
            textView.selectedRange = NSMakeRange( range.location + location, 0 );
            
            tabWidth = [ [ CEPreferences sharedInstance ] tabWidth ];
            column   = [ textView currentColumn ];
            
            if( column == NSNotFound )
            {
                return NO;
            }
            
            indent = [ NSMutableString string ];
            column = column - 1;
            spaces = ( NSUInteger )column % tabWidth;
            
            for( i = tabWidth; i > spaces; i-- )
            {
                [ indent appendString: @" " ];
            }
            
            if( range.length > 0 )
            {
                if( [ textView shouldChangeTextInRange: range replacementString: @"" ] == NO )
                {
                    return NO;
                }
                
                [ textView replaceCharactersInRange: range withString: @"" ];
            }
            
            [ _textView insertText: indent ];
            
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
    else if( sel == @selector( deleteBackward: ) )
    {
        {
            static BOOL isDeleting = NO;
            
            NSRange    range;
            NSRange    lineRange;
            NSString * text;
            NSUInteger i;
            NSUInteger mod;
            NSUInteger tabWidth;
            UniChar    c;
            NSUInteger charIndex;
            
            if( isDeleting == YES )
            {
                return NO;
            }
            
            isDeleting  = YES;
            range       = textView.selectedRange;
            text        = textView.textStorage.string;
            
            if( range.location == 0 || range.length > 0 )
            {
                isDeleting = NO;
                
                return NO;
            }
            
            if( range.location > 0 )
            {
                c = [ text characterAtIndex: range.location - 1 ];
                
                if( c != ' ' )
                {
                    isDeleting = NO;
                    
                    return NO;
                }
            }
            
            lineRange   = [ text lineRangeForRange: range ];
            tabWidth    = [ [ CEPreferences sharedInstance ] tabWidth ];
            mod         = ( range.location - lineRange.location ) % tabWidth;
            mod         = ( mod == 0 ) ? 4 : mod;
            
            for( i = 0; i < mod; i++ )
            {
                charIndex = ( range.location - 1 ) - i;
                
                c = [ text characterAtIndex: charIndex ];
                
                if( c != ' ' )
                {
                    break;
                }
                
                [ textView doCommandBySelector: sel ];
                
                if( charIndex == 0 )
                {
                    break;
                }
            }
            
            isDeleting = NO;
            
            return YES;
        }
    }
    
    return NO;
}

@end


/* $Id$ */

#import "CEConsoleViewController+Private.h"
#import "CEPreferences.h"

@implementation CEConsoleViewController( Private )



- ( void )updateView
{
    NSFont                  * font;
    NSDictionary            * selectionAttributes;
    NSMutableParagraphStyle * paragraphStyle;
    
    font = [ NSFont fontWithName: [ [ CEPreferences sharedInstance ] fontName ] size: [ [ CEPreferences sharedInstance ] fontSize ] ];
    
    _textView.font                = font;
    _textView.backgroundColor     = [ [ CEPreferences sharedInstance ] backgroundColor ];
    _textView.textColor           = [ [ CEPreferences sharedInstance ] foregroundColor ];
    _textView.insertionPointColor = [ [ CEPreferences sharedInstance ] foregroundColor ];
    
    selectionAttributes = @{NSBackgroundColorAttributeName: [ [ CEPreferences sharedInstance ] selectionColor ],
                                                                        NSForegroundColorAttributeName: [ [ CEPreferences sharedInstance ] foregroundColor ]};
    
    [ _textView setSelectedTextAttributes: selectionAttributes ];
    
    paragraphStyle = [ [ NSParagraphStyle defaultParagraphStyle ] mutableCopy ];
    
    [ _textView setDefaultParagraphStyle: paragraphStyle ];
    [ _textView.textStorage enumerateAttributesInRange: NSMakeRange( 0, _textView.string.length )
                            options:                    NSAttributedStringEnumerationReverse
                            usingBlock:                 ^( NSDictionary * attributes, NSRange range, BOOL * stop )
                            {
                                NSMutableDictionary * newAttributes;
                                

                                
                                newAttributes = [ NSMutableDictionary dictionaryWithDictionary: attributes ];
                                
                                newAttributes[NSParagraphStyleAttributeName] = paragraphStyle;
                                [ _textView.textStorage setAttributes: newAttributes range: range ];
                            }
    ];
}

@end

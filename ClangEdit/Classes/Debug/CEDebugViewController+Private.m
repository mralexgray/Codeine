/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEDebugViewController+Private.h"
#import "CEPreferences.h"

@implementation CEDebugViewController( Private )

- ( void )updateView
{
    NSFont       * font;
    NSDictionary * selectionAttributes;
    
    font = [ NSFont fontWithName: [ [ CEPreferences sharedInstance ] fontName ] size: [ [ CEPreferences sharedInstance ] fontSize ] ];
    
    _textView.font                = font;
    _textView.backgroundColor     = [ [ CEPreferences sharedInstance ] backgroundColor ];
    _textView.textColor           = [ [ CEPreferences sharedInstance ] foregroundColor ];
    _textView.insertionPointColor = [ [ CEPreferences sharedInstance ] foregroundColor ];
    
    selectionAttributes =   [ NSDictionary dictionaryWithObjectsAndKeys:    [ [ CEPreferences sharedInstance ] selectionColor ],  NSBackgroundColorAttributeName,
                                                                            [ [ CEPreferences sharedInstance ] foregroundColor ], NSForegroundColorAttributeName,
                                                                            nil
                            ];
    
    [ _textView setSelectedTextAttributes: selectionAttributes ];
}

@end

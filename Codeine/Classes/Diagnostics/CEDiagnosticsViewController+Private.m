/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEDiagnosticsViewController+Private.h"
#import "CEDocument.h"
#import "CESourceFile.h"

@implementation CEDiagnosticsViewController( Private )

- ( void )applicationStateDidChange: ( NSNotification * )notification
{
    ( void )notification;
    
    [ self.view setNeedsDisplay: YES ];
}

- ( void )getDiagnostics
{
    CKDiagnostic * diagnostic;
    NSString     * text;
    NSRange        lineRange;
    
    [ _diagnostics removeAllObjects ];
    
    if( _textView != nil && _textView.selectedRange.length == 0 )
    {
        text = _textView.textStorage.string;
    }
    else
    {
        text = nil;
    }
    
    for( diagnostic in _document.sourceFile.translationUnit.diagnostics )
    {
        if( text != nil )
        {
            lineRange = [ text lineRangeForRange: NSMakeRange( _textView.selectedRange.location, 0 ) ];
            
            if( diagnostic.range.location >= lineRange.location && diagnostic.range.location <= lineRange.location + lineRange.length )
            {
                continue;
            }
        }
        
        [ _diagnostics addObject: diagnostic ];
    }
}

- ( void )textViewSelectionDidChange: ( NSNotification * )notification
{
    ( void )notification;
    
    [ self getDiagnostics ];
    [ _tableView reloadData ];
}

@end

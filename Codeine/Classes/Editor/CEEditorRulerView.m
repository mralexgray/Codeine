/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEEditorRulerView.h"

NSString * const CEEditorRulerViewException = @"CEEditorRulerViewException";

@implementation CEEditorRulerView

- ( void )dealloc
{
    RELEASE_IVAR( _textView );
    
    [ super dealloc ];
}

- ( void )setClientView: ( NSView * )view
{
    NSException * e;
    
    [ super setClientView: view ];
    
    if( [ view isKindOfClass: [ NSTextView class ] ] == NO )
    {
        e = [ NSException exceptionWithName: CEEditorRulerViewException reason: @"Bad client view - Kind must be NSTextView" userInfo: nil ];
        
        @throw e;
    }
    
    _textView = ( NSTextView * )[ view retain ];
}

- ( void )drawHashMarksAndLabelsInRect: ( NSRect )rect
{
    NSColor      * color1;
    NSColor      * color2;
    NSGradient   * gradient;
    
    color1 = [ NSColor colorWithDeviceWhite: ( CGFloat )0.70 alpha: ( CGFloat )1 ];
    color2 = [ NSColor colorWithDeviceWhite: ( CGFloat )0.95 alpha: ( CGFloat )1 ];
    
    gradient = [ [ NSGradient alloc ] initWithColorsAndLocations: color1, ( CGFloat )0, color2, ( CGFloat )1, nil ];
    
    [ gradient drawInRect: rect angle: ( CGFloat )180 ];
    [ gradient release ];
    
    if( _textView == nil )
    {
        return;
    }
}

@end

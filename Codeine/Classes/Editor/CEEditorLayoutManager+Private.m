
/* $Id$ */

#import "CEEditorLayoutManager+Private.h"
#import "CEPreferences.h"

@implementation CEEditorLayoutManager( Private )

- ( void )updateDummyTextView
{
    NSRect rect;
    
    _textView.font   = [ NSFont fontWithName: [ [ CEPreferences sharedInstance ] fontName ] size: [ [ CEPreferences sharedInstance ] fontSize ] ];
    _textView.string = @"X";
    
    rect                  = [ _textView.layoutManager boundingRectForGlyphRange: NSMakeRange( 0, 1 ) inTextContainer: _textView.textContainer ];
    _glyphSize            = rect.size;
    _firstGlyphLeftMargin = rect.origin.x;
}

@end


/* $Id$ */

#import "CEEditorTextView.h"
#import "CEEditorTextView+Private.h"
#import "CEPreferences.h"
#import "CEEditorTextViewDelegate.h"

@implementation CEEditorTextView

- ( id )initWithFrame:(NSRect)frameRect
{
    if( ( self = [ super initWithFrame: frameRect ] ) )
    {
        [ NOTIFICATION_CENTER addObserver: self selector: @selector( selectionDidChange: ) name: NSTextViewDidChangeSelectionNotification object: self ];
    }
    
    return self;
}

- ( id )initWithCoder:(NSCoder *)coder
{
    if( ( self = [ super initWithCoder: coder ] ) )
    {
        [ NOTIFICATION_CENTER addObserver: self selector: @selector( selectionDidChange: ) name: NSTextViewDidChangeSelectionNotification object: self ];
    }
    
    return self;
}

- ( void )dealloc
{
    [ NOTIFICATION_CENTER removeObserver: self ];
    
}

- ( void )drawRect: ( NSRect )rect
{
    [ super drawRect: rect ];
}

- ( void )drawViewBackgroundInRect: ( NSRect )rect
{
    [ super drawViewBackgroundInRect: rect ];
    
    if( [ [ CEPreferences sharedInstance ] showPageGuide ] == YES )
    {
        [ self drawPageGuideInRect: rect ];
    }
    
    if( [ [ CEPreferences sharedInstance ] showTabStops ] == YES )
    {
        [ self drawTabStopsInRect: rect ];
    }
    
    if( [ [ CEPreferences sharedInstance ] highlightCurrentLine ] == YES )
    {
        [ self drawCurrentLineHighlight: rect ];
    }
}

- ( void )complete: ( id )sender
{
    id < CEEditorTextViewDelegate > delegate;
    
    delegate = ( id < CEEditorTextViewDelegate > )( self.delegate );
    
    if( [ delegate conformsToProtocol: @protocol( CEEditorTextViewDelegate ) ] )
    {
        if( [ delegate respondsToSelector: @selector( textView:complete: ) ] )
        {
            if( [ delegate textView: self complete: sender ] == NO )
            {
                [ super complete: sender ];
            }
        }
    }
}

@end

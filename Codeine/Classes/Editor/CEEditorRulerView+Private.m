
/* $Id$ */

#import "CEEditorRulerView+Private.h"
#import "CEEditorMarker.h"

@implementation CEEditorRulerView( Private )

- ( void )textStorageDidProcessEditing: ( NSNotification * )notification
{

    
    [ self setNeedsDisplay: YES ];
}

- ( void )textViewSelectionDidChange: ( NSNotification * )notification
{

    
    [ self setNeedsDisplay: YES ];
}

- ( void )applicationStateDidChange: ( NSNotification * )notification
{

    
    [ self setNeedsDisplay: YES ];
}

- ( void )setRect: ( NSRect )rect forLine: ( NSUInteger )line
{
    NSNumber * key;
    NSValue  * value;
    
    if( _linesRect == nil )
    {
        _linesRect = [ [ NSMutableDictionary alloc ] initWithCapacity: 10 ];
    }
    
    key   = [ NSNumber numberWithUnsignedInteger: line ];
    value = [ NSValue valueWithRect: rect ];
    
    [ _linesRect removeObjectForKey: key ];
    [ _linesRect setObject: value forKey: key ];
}

- ( NSRect )rectForLine: ( NSUInteger )line
{
    NSNumber * key;
    NSValue  * value;
    
    if( _textView == nil || _linesRect == nil )
    {
        return NSZeroRect;
    }
    
    for( key in _linesRect )
    {
        if( [ key unsignedIntegerValue ] == line )
        {
            value = [ _linesRect objectForKey: key ];
            
            return [ value rectValue ];
        }
    }
    
    return NSZeroRect;
}

- ( NSUInteger )lineForPoint: ( NSPoint )point
{
    NSNumber * key;
    NSValue  * value;
    NSRect     rect;
    
    if( _textView == nil || _linesRect == nil )
    {
        return NSNotFound;
    }
    
    for( key in _linesRect )
    {
        value = [ _linesRect objectForKey: key ];
        rect  = [ value rectValue ];
        
        if
        (
               point.y >= rect.origin.y
            && point.y <= rect.origin.y + rect.size.height
        )
        {
            return [ key unsignedIntegerValue ];
        }
    }
    
    return NSNotFound;
}

- ( void )addMarkerForLine: ( NSUInteger )line
{
    NSRulerMarker * marker;
    NSArray       * markers;
    NSNumber      * lineNumber;
    
    markers = [ self markers ];
    
    for( marker in markers )
    {
        if( [ ( NSObject * )( marker.representedObject ) isKindOfClass: [ NSNumber class ] ] == NO )
        {
            continue;
        }
        
        lineNumber = ( NSNumber * )( marker.representedObject );
        
        if( [ lineNumber unsignedIntegerValue ] == line )
        {
            return;
        }
    }
    
    marker                   = [ CEEditorMarker new ];
    marker.representedObject = [ NSNumber numberWithUnsignedInteger: line ];
    
    [ self addMarker: marker ];
    [ self setNeedsDisplay: YES ];
}

- ( void )removeMarkerForLine: ( NSUInteger )line
{
    NSRulerMarker * marker;
    NSArray       * markers;
    NSNumber      * lineNumber;
    
    markers = [ NSArray arrayWithArray: [ self markers ] ];
    
    for( marker in markers )
    {
        if( [ ( NSObject * )( marker.representedObject ) isKindOfClass: [ NSNumber class ] ] == NO )
        {
            continue;
        }
        
        lineNumber = ( NSNumber * )( marker.representedObject );
        
        if( [ lineNumber unsignedIntegerValue ] == line )
        {
            [ self removeMarker: marker ];
            [ self setNeedsDisplay: YES ];
            
            return;
        }
    }
}

- ( CEEditorMarker * )markerForLine: ( NSUInteger )line
{
    NSRulerMarker * marker;
    NSArray       * markers;
    NSNumber      * lineNumber;
    
    markers = [ NSArray arrayWithArray: [ self markers ] ];
    
    for( marker in markers )
    {
        if( [ ( NSObject * )( marker.representedObject ) isKindOfClass: [ NSNumber class ] ] == NO )
        {
            continue;
        }
        
        if( [ marker isKindOfClass: [ CEEditorMarker class ] ] == NO )
        {
            continue;
        }
        
        lineNumber = ( NSNumber * )( marker.representedObject );
        
        if( [ lineNumber unsignedIntegerValue ] == line )
        {
            return ( CEEditorMarker * )marker;
        }
    }
    
    return nil;
}

- ( NSMutableDictionary * )textAttributes
{
    NSFont                  * font;
    NSMutableParagraphStyle * paragraphStyle;
    
    if( _attributes == nil )
    {
        _attributes      = [ [ NSMutableDictionary alloc ] initWithCapacity: 10 ];
        font             = [ NSFont systemFontOfSize: ( CGFloat )8 ];
        paragraphStyle   = [ [ NSParagraphStyle defaultParagraphStyle ] mutableCopy ];
        
        [ paragraphStyle setAlignment: NSRightTextAlignment ];
        
        [ _attributes setObject: font                   forKey: NSFontAttributeName ];
        [ _attributes setObject: [ NSColor grayColor ]  forKey: NSForegroundColorAttributeName ];
        [ _attributes setObject: [ NSColor clearColor ] forKey: NSBackgroundColorAttributeName ];
        [ _attributes setObject: paragraphStyle         forKey: NSParagraphStyleAttributeName ];
    }
    
    return [ _attributes mutableCopy ];
}

@end

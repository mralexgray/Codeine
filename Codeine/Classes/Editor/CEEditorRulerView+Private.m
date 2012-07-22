/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEEditorRulerView+Private.h"
#import "CEEditorMarker.h"

@implementation CEEditorRulerView( Private )

- ( void )textStorageDidProcessEditing: ( NSNotification * )notification
{
    ( void )notification;
    
    [ self setNeedsDisplay: YES ];
}

- ( void )setRect: ( NSRect )rect forLine: ( NSUInteger )line
{
    if( _textView == nil )
    {
        return;
    }
    
    if( _linesRect == nil )
    {
        _linesRectSize = [ _textView numberOfHardLines ];
        
        if( ( _linesRect = ( NSRect * )calloc( sizeof( NSRect ), _linesRectSize ) ) == NULL )
        {
            return;
        }
    }
    
    if( line >= _linesRectSize )
    {
        _linesRectSize = line + 1;
        
        if( ( _linesRect = ( NSRect * )calloc( sizeof( NSRect ), _linesRectSize ) ) == NULL )
        {
            return;
        }
    }
    
    _linesRect[ line ] = rect;
}

- ( NSRect )rectForLine: ( NSUInteger )line
{
    if( _textView == nil )
    {
        return NSZeroRect;
    }
    
    if( _linesRectSize <= line + 1 )
    {
        return NSZeroRect;
    }
    
    return _linesRect[ line ];
}

- ( NSUInteger )lineForPoint: ( NSPoint )point
{
    NSUInteger i;
    NSRect     lineRect;
    
    for( i = 0; i < _linesRectSize; i++ )
    {
        lineRect = _linesRect[ i ];
        
        if
        (
               point.y >= lineRect.origin.y
            && point.y <= lineRect.origin.y + lineRect.size.height
        )
        {
            return i;
        }
    }
    
    return NSNotFound;
}

- ( void )addMarkerForLine: ( NSUInteger )line
{
    if( _textView == nil )
    {
        return;
    }
    
    if( _lineMarkers == nil )
    {
        _lineMarkersSize = [ _textView numberOfHardLines ];
        
        if( ( _lineMarkers = ( CEEditorMarker ** )calloc( sizeof( CEEditorMarker * ), _lineMarkersSize ) ) == NULL )
        {
            return;
        }
    }
    
    if( line >= _lineMarkersSize )
    {
        _lineMarkersSize = line + 1;
        
        if( ( _lineMarkers = ( CEEditorMarker ** )calloc( sizeof( CEEditorMarker * ), _lineMarkersSize ) ) == NULL )
        {
            return;
        }
    }
    
    _lineMarkers[ line ] = [ CEEditorMarker new ];
    
    [ self setNeedsDisplay: YES ];
}

- ( CEEditorMarker * )markerForLine: ( NSUInteger )line
{
    if( _textView == nil )
    {
        return nil;
    }
    
    if( _lineMarkersSize <= line + 1 )
    {
        return nil;
    }
    
    return _lineMarkers[ line ];
}

@end

/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

FOUNDATION_EXPORT NSString * const CEEditorRulerViewException;

@class CEEditorMarker;

@interface CEEditorRulerView: NSRulerView
{
@protected
    
    NSTextView      * _textView;
    NSRect          * _linesRect;
    NSUInteger        _linesRectSize;
    CEEditorMarker ** _lineMarkers;
    NSUInteger        _lineMarkersSize;
    BOOL              _hasApplicationObserver;
    
@private
    
    RESERVERD_IVARS( CEEditorRulerView, 5 );
}



@end

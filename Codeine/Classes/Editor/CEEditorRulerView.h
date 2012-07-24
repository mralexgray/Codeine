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
    
    NSTextView          * _textView;
    NSMutableDictionary * _linesRect;
    BOOL                  _hasApplicationObserver;
    
@private
    
    RESERVERD_IVARS( CEEditorRulerView, 5 );
}



@end

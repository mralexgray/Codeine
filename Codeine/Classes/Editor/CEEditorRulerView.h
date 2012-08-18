/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

FOUNDATION_EXPORT NSString * const CEEditorRulerViewException;

@class CEEditorMarker;
@class CEDocument;

@interface CEEditorRulerView: NSRulerView
{
@protected
    
    NSTextView          * _textView;
    NSMutableDictionary * _linesRect;
    CEDocument          * _document;
    NSMutableDictionary * _attributes;
    BOOL                  _hasApplicationObserver;
    
@private
    
    RESERVED_IVARS( CEEditorRulerView, 5 );
}

@property( atomic, readwrite, retain ) CEDocument * document;

@end

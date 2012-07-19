/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

FOUNDATION_EXPORT NSString * const CEEditorRulerViewException;

@interface CEEditorRulerView: NSRulerView
{
@protected
    
    NSTextView * _textView;
    
@private
    
    RESERVERD_IVARS( CEEditorRulerView, 5 );
}



@end

/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@interface CEHUDView: NSView
{
@protected
    
    CGFloat    _cornerRadius;
    NSColor  * _backgroundColor1;
    NSColor  * _backgroundColor2;
    NSColor  * _textColor;
    NSFont   * _font;
    NSString * _title;
    
@private
    
    RESERVERD_IVARS( CEHUDView, 5 );
}

@property( atomic, readwrite, assign ) CGFloat    cornerRadius;
@property( atomic, readwrite, retain ) NSColor  * backgroundColor1;
@property( atomic, readwrite, retain ) NSColor  * backgroundColor2;
@property( atomic, readwrite, retain ) NSColor  * textColor;
@property( atomic, readwrite, retain ) NSFont   * font;
@property( atomic, readwrite, copy   ) NSString * title;

@end

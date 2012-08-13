/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEColorChooserViewDelegate.h"

@interface CEColorChooserView: NSView
{
@protected
    
    NSColor                         * _backgroundColor;
    NSColor                         * _foregroundColor;
    NSColor                         * _color;
    NSFont                          * _font;
    NSString                        * _title;
    NSTextField                     * _textField;
    NSColorWell                     * _colorWell;
    id                                _representedObject;
    id < CEColorChooserViewDelegate > _delegate;
    
@private
    
    RESERVED_IVARS( CEColorChooserView, 5 );
}

@property( atomic, readwrite, retain ) NSColor                         * backgroundColor;
@property( atomic, readwrite, retain ) NSColor                         * foregroundColor;
@property( atomic, readwrite, retain ) NSColor                         * color;
@property( atomic, readwrite, retain ) NSFont                          * font;
@property( atomic, readwrite, copy   ) NSString                        * title;
@property( atomic, readwrite, assign ) id                                representedObject;
@property( atomic, readwrite, assign ) id < CEColorChooserViewDelegate > delegate;

@end

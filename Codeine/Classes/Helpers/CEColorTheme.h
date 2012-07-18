/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@interface CEColorTheme: NSObject
{
@protected
    
    NSString * _name;
    NSColor  * _foregroundColor;
    NSColor  * _backgroundColor;
    NSColor  * _selectionColor;
    NSColor  * _currentLineColor;
    NSColor  * _invisibleColor;
    NSColor  * _keywordColor;
    NSColor  * _commentColor;
    NSColor  * _stringColor;
    NSColor  * _predefinedColor;
    NSColor  * _numberColor;
    
@private
    
    RESERVERD_IVARS( CEColorTheme , 5 );
}

@property( atomic, readwrite, copy ) NSString * name;
@property( atomic, readwrite, copy ) NSColor  * foregroundColor;
@property( atomic, readwrite, copy ) NSColor  * backgroundColor;
@property( atomic, readwrite, copy ) NSColor  * selectionColor;
@property( atomic, readwrite, copy ) NSColor  * currentLineColor;
@property( atomic, readwrite, copy ) NSColor  * invisibleColor;
@property( atomic, readwrite, copy ) NSColor  * keywordColor;
@property( atomic, readwrite, copy ) NSColor  * commentColor;
@property( atomic, readwrite, copy ) NSColor  * stringColor;
@property( atomic, readwrite, copy ) NSColor  * predefinedColor;
@property( atomic, readwrite, copy ) NSColor  * numberColor;

+ ( NSArray * )defaultColorThemes;
+ ( id )defaultColorThemeWithName: ( NSString * )name;
+ ( id )colorThemeWithName: ( NSString * )name;
- ( id )initWithName: ( NSString * )name;

@end

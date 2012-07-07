/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@interface CEColorTheme: NSObject
{
@protected
    
    NSString * _name;
    NSColor  * _generalForegroundColor;
    NSColor  * _generalBackgroundColor;
    NSColor  * _generalSelectionColor;
    NSColor  * _generalCurrentLineColor;
    NSColor  * _sourceKeywordColor;
    NSColor  * _sourceCommentColor;
    NSColor  * _sourceStringColor;
    NSColor  * _sourcePredefinedColor;
    
@private
    
    RESERVERD_IVARS( CEColorTheme , 5 );
}

@property( atomic, readwrite, copy ) NSString * name;
@property( atomic, readwrite, copy ) NSColor  * generalForegroundColor;
@property( atomic, readwrite, copy ) NSColor  * generalBackgroundColor;
@property( atomic, readwrite, copy ) NSColor  * generalSelectionColor;
@property( atomic, readwrite, copy ) NSColor  * generalCurrentLineColor;
@property( atomic, readwrite, copy ) NSColor  * sourceKeywordColor;
@property( atomic, readwrite, copy ) NSColor  * sourceCommentColor;
@property( atomic, readwrite, copy ) NSColor  * sourceStringColor;
@property( atomic, readwrite, copy ) NSColor  * sourcePredefinedColor;

+ ( id )colorThemeWithName: ( NSString * )name;
- ( id )initWithName: ( NSString * )name;

@end

/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferencesFontsAndColorsOptionsViewController+Private.h"
#import "CEPreferences.h"

@implementation CEPreferencesFontsAndColorsOptionsViewController( Private )

- ( void )updateView
{
    NSString      * font;
    CEPreferences * prefs;
    
    prefs = [ CEPreferences sharedInstance ];
    font  = [ NSString stringWithFormat: @"%@ - %.01f", [ prefs fontName ], [ prefs fontSize ] ];
    
    [ _fontTextField setStringValue: font ];
    
    [ _generalForegroundColorWell   setColor: [ prefs foregroundColor ] ];
    [ _generalBackgroundColorWell   setColor: [ prefs backgroundColor ] ];
    [ _generalSelectionColorWell    setColor: [ prefs currentLineColor ] ];
    [ _sourceKeywordColorWell       setColor: [ prefs commentColor ] ];
    [ _sourceStringColorWell        setColor: [ prefs stringColor ] ];
    [ _sourcePredefinedColorWell    setColor: [ prefs predefinedColor ] ];
}

- ( void )updateColor: ( NSColorWell * )colorWell
{
         if( colorWell == _generalForegroundColorWell )  { [ [ CEPreferences sharedInstance ] setForegroundColor:  colorWell.color ]; }
    else if( colorWell == _generalBackgroundColorWell )  { [ [ CEPreferences sharedInstance ] setBackgroundColor:  colorWell.color ]; }
    else if( colorWell == _generalSelectionColorWell )   { [ [ CEPreferences sharedInstance ] setSelectionColor:   colorWell.color ]; }
    else if( colorWell == _generalCurrentLineColorWell ) { [ [ CEPreferences sharedInstance ] setCurrentLineColor: colorWell.color ]; }
    else if( colorWell == _sourceKeywordColorWell )      { [ [ CEPreferences sharedInstance ] setKeywordColor:     colorWell.color ]; }
    else if( colorWell == _sourceCommentColorWell )      { [ [ CEPreferences sharedInstance ] setCommentColor:     colorWell.color ]; }
    else if( colorWell == _sourceStringColorWell )       { [ [ CEPreferences sharedInstance ] setStringColor:      colorWell.color ]; }
    else if( colorWell == _sourcePredefinedColorWell )   { [ [ CEPreferences sharedInstance ] setPredefinedColor:  colorWell.color ]; }
}

@end

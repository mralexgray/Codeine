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
    [ _generalSelectionColorWell    setColor: [ prefs selectionColor ] ];
    [ _generalCurrentLineColorWell  setColor: [ prefs currentLineColor ] ];
    [ _generalInvisibleColorWell    setColor: [ prefs invisibleColor ] ];
    [ _sourceKeywordColorWell       setColor: [ prefs keywordColor ] ];
    [ _sourceCommentColorWell       setColor: [ prefs commentColor ] ];
    [ _sourceStringColorWell        setColor: [ prefs stringColor ] ];
    [ _sourcePredefinedColorWell    setColor: [ prefs predefinedColor ] ];
    [ _sourceNumberColorWell        setColor: [ prefs numberColor ] ];
}

- ( void )updateColor: ( NSColorWell * )colorWell
{
         if( colorWell == _generalForegroundColorWell )  { [ [ CEPreferences sharedInstance ] setForegroundColor:  colorWell.color ]; }
    else if( colorWell == _generalBackgroundColorWell )  { [ [ CEPreferences sharedInstance ] setBackgroundColor:  colorWell.color ]; }
    else if( colorWell == _generalSelectionColorWell )   { [ [ CEPreferences sharedInstance ] setSelectionColor:   colorWell.color ]; }
    else if( colorWell == _generalCurrentLineColorWell ) { [ [ CEPreferences sharedInstance ] setCurrentLineColor: colorWell.color ]; }
    else if( colorWell == _generalInvisibleColorWell )   { [ [ CEPreferences sharedInstance ] setInvisibleColor:   colorWell.color ]; }
    else if( colorWell == _sourceKeywordColorWell )      { [ [ CEPreferences sharedInstance ] setKeywordColor:     colorWell.color ]; }
    else if( colorWell == _sourceCommentColorWell )      { [ [ CEPreferences sharedInstance ] setCommentColor:     colorWell.color ]; }
    else if( colorWell == _sourceStringColorWell )       { [ [ CEPreferences sharedInstance ] setStringColor:      colorWell.color ]; }
    else if( colorWell == _sourcePredefinedColorWell )   { [ [ CEPreferences sharedInstance ] setPredefinedColor:  colorWell.color ]; }
    else if( colorWell == _sourceNumberColorWell )       { [ [ CEPreferences sharedInstance ] setNumberColor:      colorWell.color ]; }
}

@end

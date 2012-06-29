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
    
    [ _generalForegroundColorWell   setColor: [ prefs generalForegroundColor ] ];
    [ _generalBackgroundColorWell   setColor: [ prefs generalBackgroundColor ] ];
    [ _generalSelectionColorWell    setColor: [ prefs generalSelectionColor ] ];
    [ _generalCurrentLineColorWell  setColor: [ prefs generalCurrentLineColor ] ];
    [ _sourceKeywordColorWell       setColor: [ prefs sourceKeywordColor ] ];
    [ _sourceCommentColorWell       setColor: [ prefs sourceCommentColor ] ];
    [ _sourceStringColorWell        setColor: [ prefs sourceStringColor ] ];
    [ _sourcePredefinedColorWell    setColor: [ prefs sourcePredefinedColor ] ];
}

- ( void )updateColor: ( NSColorWell * )colorWell
{
         if( colorWell == _generalForegroundColorWell )  { [ [ CEPreferences sharedInstance ] setGeneralForegroundColor:  colorWell.color ]; }
    else if( colorWell == _generalBackgroundColorWell )  { [ [ CEPreferences sharedInstance ] setGeneralBackgroundColor:  colorWell.color ]; }
    else if( colorWell == _generalSelectionColorWell )   { [ [ CEPreferences sharedInstance ] setGeneralSelectionColor:   colorWell.color ]; }
    else if( colorWell == _generalCurrentLineColorWell ) { [ [ CEPreferences sharedInstance ] setGeneralCurrentLineColor: colorWell.color ]; }
    else if( colorWell == _sourceKeywordColorWell )      { [ [ CEPreferences sharedInstance ] setSourceKeywordColor:      colorWell.color ]; }
    else if( colorWell == _sourceCommentColorWell )      { [ [ CEPreferences sharedInstance ] setSourceCommentColor:      colorWell.color ]; }
    else if( colorWell == _sourceStringColorWell )       { [ [ CEPreferences sharedInstance ] setSourceStringColor:       colorWell.color ]; }
    else if( colorWell == _sourcePredefinedColorWell )   { [ [ CEPreferences sharedInstance ] setSourcePredefinedColor:   colorWell.color ]; }
}

@end

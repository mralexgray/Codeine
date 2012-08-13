/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEPreferencesFontsAndColorsOptionsViewController+CEColorChooserViewDelegate.h"
#import "CEPreferences.h"
#import "CEColorChooserView.h"

@implementation CEPreferencesFontsAndColorsOptionsViewController( CEColorChooserViewDelegate )

- ( void )colorChooserView: ( CEColorChooserView * )view didChooseColor: ( NSColor * )color
{
    ( void )view;
    
    if( view.representedObject == CEPreferencesKeyBackgroundColor )
    {
        [ [ CEPreferences sharedInstance ] setBackgroundColor: color ];
    }
    else if( view.representedObject == CEPreferencesKeyForegoundColor )
    {
        [ [ CEPreferences sharedInstance ] setForegroundColor: color ];
    }
    else if( view.representedObject == CEPreferencesKeyCurrentLineColor )
    {
        [ [ CEPreferences sharedInstance ] setCurrentLineColor: color ];
    }
    else if( view.representedObject == CEPreferencesKeySelectionColor )
    {
        [ [ CEPreferences sharedInstance ] setSelectionColor: color ];
    }
    else if( view.representedObject == CEPreferencesKeyInvisibleColor )
    {
        [ [ CEPreferences sharedInstance ] setInvisibleColor: color ];
    }
    else if( view.representedObject == CEPreferencesKeyKeywordColor )
    {
        [ [ CEPreferences sharedInstance ] setKeywordColor: color ];
    }
    else if( view.representedObject == CEPreferencesKeyPreprocessorColor )
    {
        [ [ CEPreferences sharedInstance ] setPreprocessorColor: color ];
    }
    else if( view.representedObject == CEPreferencesKeyPredefinedColor )
    {
        [ [ CEPreferences sharedInstance ] setPredefinedColor: color ];
    }
    else if( view.representedObject == CEPreferencesKeyProjectColor )
    {
        [ [ CEPreferences sharedInstance ] setProjectColor: color ];
    }
    else if( view.representedObject == CEPreferencesKeyNumberColor )
    {
        [ [ CEPreferences sharedInstance ] setNumberColor: color ];
    }
    else if( view.representedObject == CEPreferencesKeyStringColor )
    {
        [ [ CEPreferences sharedInstance ] setStringColor: color ];
    }
    else if( view.representedObject == CEPreferencesKeyCommentColor )
    {
        [ [ CEPreferences sharedInstance ] setCommentColor: color ];
    }
}

@end

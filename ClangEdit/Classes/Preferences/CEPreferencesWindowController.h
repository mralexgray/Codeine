/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEWindowController.h"

@class CEPreferencesGeneralOptionsViewController;
@class CEPreferencesEditorOptionsViewController;
@class CEPreferencesCompilerOptionsViewController;
@class CEPreferencesLinkerOptionsViewController;
@class CEPreferencesFontsAndColorsOptionsViewController;
@class CEPreferencesFileTypesOptionsViewController;

@interface CEPreferencesWindowController: CEWindowController
{
@protected
    
    CEPreferencesGeneralOptionsViewController           * _generalOptionsViewController;
    CEPreferencesEditorOptionsViewController            * _editorOptionsViewController;
    CEPreferencesCompilerOptionsViewController          * _compilerOptionsViewController;
    CEPreferencesLinkerOptionsViewController            * _linkerOptionsViewController;
    CEPreferencesFontsAndColorsOptionsViewController    * _fontsAndColorsOptionsViewController;
    CEPreferencesFileTypesOptionsViewController         * _fileTypesOptionsViewController;
    NSToolbar                                           * _toolbar;
    
@private
    
    RESERVERD_IVARS( CEPreferencesWindowController , 5 );
}

@property( nonatomic, readwrite, retain ) IBOutlet NSToolbar * toolbar;

- ( IBAction )showGeneralOptions: ( id )sender;
- ( IBAction )showEditorOptions: ( id )sender;
- ( IBAction )showCompilerOptions: ( id )sender;
- ( IBAction )showLinkerOptions: ( id )sender;
- ( IBAction )showFontsAndColorsOptions: ( id )sender;
- ( IBAction )showFileTypesOptions: ( id )sender;

@end

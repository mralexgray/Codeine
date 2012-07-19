/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@class CEPreferencesWindowController;
@class CEAboutWindowController;
@class CEAlternateAboutWindowController;

@interface CEApplicationDelegate: NSObject < NSApplicationDelegate >
{
@protected
    
    NSMutableArray                   * _mainWindowControllers;
    CEPreferencesWindowController    * _preferencesWindowController;
    CEAboutWindowController          * _aboutWindowController;
    CEAlternateAboutWindowController * _alternateAboutWindowController;
    
@private
    
    RESERVERD_IVARS( CEApplicationDelegate , 5 );
}

+ ( CEApplicationDelegate * )sharedInstance;
- ( IBAction )showPreferencesWindow: ( id )sender;
- ( IBAction )showAboutWindow: ( id )sender;
- ( IBAction )showAlternateAboutWindow: ( id )sender;
- ( IBAction )newWindow: ( id )sender;
- ( IBAction )toggleInvisibleCharacters: ( id )sender;

@end

/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@class CEPreferencesWindowController;
@class CEAboutWindowController;
@class CEAlternateAboutWindowController;
@class CERegistrationWindowController;

@interface CEApplicationDelegate: NSObject < NSApplicationDelegate >
{
@protected
    
    NSMutableArray                   * _mainWindowControllers;
    CEPreferencesWindowController    * _preferencesWindowController;
    CEAboutWindowController          * _aboutWindowController;
    CEAlternateAboutWindowController * _alternateAboutWindowController;
    CERegistrationWindowController   * _registrationWindowController;
    
@private
    
    RESERVED_IVARS( CEApplicationDelegate , 5 );
}

+ ( CEApplicationDelegate * )sharedInstance;
- ( IBAction )showPreferencesWindow: ( id )sender;
- ( IBAction )showAboutWindow: ( id )sender;
- ( IBAction )showAlternateAboutWindow: ( id )sender;
- ( IBAction )showRegistrationWindow: ( id )sender;
- ( IBAction )newWindow: ( id )sender;
- ( IBAction )toggleLineNumbers: ( id )sender;
- ( IBAction )toggleSoftWrap: ( id )sender;
- ( IBAction )toggleInvisibleCharacters: ( id )sender;

@end

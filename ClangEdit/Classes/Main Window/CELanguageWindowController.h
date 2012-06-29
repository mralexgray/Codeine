/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEWindowController.h"
#import "CESourceFile.h"

@interface CELanguageWindowController: CEWindowController
{
@protected
    
    CESourceFileLanguage _language;
    NSPopUpButton      * _languagePopUp;
    
@private
    
    RESERVERD_IVARS( CELanguageWindowController , 5 );
}

@property( atomic, readonly )                      CESourceFileLanguage language;
@property( nonatomic, readwrite, retain ) IBOutlet NSPopUpButton      * languagePopUp;
    
- ( IBAction )selectLanguage: ( id )sender;

@end

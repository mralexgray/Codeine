/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEViewController.h"

@interface CEPreferencesGeneralOptionsViewController: CEViewController
{
@protected
    
    NSPopUpButton * _languagePopUp;
    NSPopUpButton * _encodingPopUp;
    NSMatrix      * _lineEndingsMatrix;
    
@private
    
    RESERVED_IVARS( CEPreferencesGeneralOptionsViewController , 5 );
}

@property( nonatomic, readwrite, retain ) IBOutlet NSPopUpButton * languagePopUp;
@property( nonatomic, readwrite, retain ) IBOutlet NSPopUpButton * encodingPopUp;
@property( nonatomic, readwrite, retain ) IBOutlet NSMatrix      * lineEndingsMatrix;

- ( IBAction )setLanguage: ( id )sender;
- ( IBAction )setEncoding: ( id )sender;
- ( IBAction )setLineEndings: ( id )sender;

@end

/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEWindowController.h"
#import "CESourceFile.h"

@class CETextEncoding;

@interface CELanguageWindowController: CEWindowController
{
@protected
    
    CESourceFileLanguage    _language;
    CESourceFileLineEndings _lineEndings;
    CETextEncoding        * _encoding;
    NSPopUpButton         * _languagePopUp;
    NSPopUpButton         * _encodingPopUp;
    NSMatrix              * _lineEndingsMatrix;
    
@private
    
    RESERVERD_IVARS( CELanguageWindowController , 5 );
}

@property( atomic, readonly )                      CESourceFileLanguage     language;
@property( atomic, readonly )                      CESourceFileLineEndings  lineEndings;
@property( atomic, readonly )                      CETextEncoding         * encoding;
@property( nonatomic, readwrite, retain ) IBOutlet NSPopUpButton          * languagePopUp;
@property( nonatomic, readwrite, retain ) IBOutlet NSPopUpButton          * encodingPopUp;
@property( nonatomic, readwrite, retain ) IBOutlet NSMatrix               * lineEndingsMatrix;
    
- ( IBAction )done: ( id )sender;

@end

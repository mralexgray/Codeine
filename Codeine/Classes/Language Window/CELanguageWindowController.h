/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEWindowController.h"
#import "CESourceFile.h"

@class CETextEncoding;
@class CEBackgroundView;

FOUNDATION_EXPORT NSString * const CELanguageWindowControllerTableColumnIdentifierIcon;
FOUNDATION_EXPORT NSString * const CELanguageWindowControllerTableColumnIdentifierTitle;

@interface CELanguageWindowController: CEWindowController
{
@protected
    
    CESourceFileLanguage    _language;
    CESourceFileLineEndings _lineEndings;
    CETextEncoding        * _encoding;
    NSPopUpButton         * _encodingPopUp;
    NSMatrix              * _lineEndingsMatrix;
    CEBackgroundView      * _contentView;
    NSImageView           * _iconView;
    NSTableView           * _languagesTableView;
    NSTableView           * _recentFilesTableView;
    
@private
    
    RESERVED_IVARS( CELanguageWindowController , 5 );
}

@property( atomic, readonly )                      CESourceFileLanguage     language;
@property( atomic, readonly )                      CESourceFileLineEndings  lineEndings;
@property( atomic, readonly )                      CETextEncoding         * encoding;
@property( nonatomic, readwrite, retain ) IBOutlet NSPopUpButton          * encodingPopUp;
@property( nonatomic, readwrite, retain ) IBOutlet NSMatrix               * lineEndingsMatrix;
@property( nonatomic, readwrite, retain ) IBOutlet CEBackgroundView       * contentView;
@property( nonatomic, readwrite, retain ) IBOutlet NSImageView            * iconView;
@property( nonatomic, readwrite, retain ) IBOutlet NSTableView            * languagesTableView;
@property( nonatomic, readwrite, retain ) IBOutlet NSTableView            * recentFilesTableView;
    
- ( IBAction )done: ( id )sender;
- ( IBAction )cancel: ( id )sender;

@end

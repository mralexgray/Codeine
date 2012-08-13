/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEMainWindowController+Private.h"
#import "CELanguageWindowController.h"
#import "CESourceFile.h"
#import "CEDocument.h"
#import "CEFilesViewController.h"
#import "CELicensePopUpButton.h"
#import "CEPreferences.h"

@implementation CEMainWindowController( Private )

- ( void )showLanguageWindow
{
    if( _languageWindowController == nil )
    {
        _languageWindowController = [ CELanguageWindowController new ];
    }
    
    [ APPLICATION beginSheet: _languageWindowController.window modalForWindow: self.window modalDelegate: self didEndSelector: @selector( didChooseLanguage: ) contextInfo: NULL ];
}

- ( void )didChooseLanguage: ( id )sender
{
    NSString         * license;
    NSString         * templates;
    NSString         * template;
    NSDateComponents * dateComponents;
    CEDocument       * document;
    NSString         * text;
    NSString         * userName;
    
    if
    (
           _languageWindowController.language    == CESourceFileLanguageNone
        || _languageWindowController.lineEndings == CESourceFileLineEndingsUnknown
        || _languageWindowController.encoding    == nil
    )
    {
        return;
    }
    
    templates = [ [ FILE_MANAGER applicationSupportDirectory ] stringByAppendingPathComponent: @"Templates" ];
    
    ( void )sender;
    
    switch( _languageWindowController.language )
    {
        case CESourceFileLanguageCPP:
            
            template = [ templates stringByAppendingPathComponent: @"C++.txt" ];
            break;
            
        case CESourceFileLanguageObjC:
            
            template = [ templates stringByAppendingPathComponent: @"Objective-C.txt" ];
            break;
            
        case CESourceFileLanguageObjCPP:
            
            template = [ templates stringByAppendingPathComponent: @"Objective-C++.txt" ];
            break;
            
        case CESourceFileLanguageC:
        case CESourceFileLanguageHeader:
        case CESourceFileLanguageNone:
        default:
            
            template = [ templates stringByAppendingPathComponent: @"C.txt" ];
            break;
    }
    
    document = [ CEDocument documentWithLanguage: _languageWindowController.language ];
    text     = [ NSString stringWithContentsOfFile: template encoding: NSUTF8StringEncoding error: NULL ];
    
    if( text == nil )
    {
        text = @"";
    }
    else
    {
        license         = [ _languageWindowController.licensePopUp.licenseText stringByTrimmingCharactersInSet: [ NSCharacterSet whitespaceAndNewlineCharacterSet ] ];
        dateComponents  = [ [ NSCalendar currentCalendar ] components: NSYearCalendarUnit fromDate: [ NSDate date ] ];
        text            = [ text stringByReplacingOccurrencesOfString: @"${LICENSE}" withString: license ];
        userName        = [ [ CEPreferences sharedInstance ] userName ];
        
        if( [ [ [ CEPreferences sharedInstance ] userEmail ] length ] > 0 )
        {
            userName = [ NSString stringWithFormat: @"%@ <%@>", userName, [ [ CEPreferences sharedInstance ] userEmail ] ];
        }
        
        text = [ text stringByReplacingOccurrencesOfString: @"${USER_NAME}" withString: userName ];
        text = [ text stringByReplacingOccurrencesOfString: @"${YEAR}" withString: [ NSString stringWithFormat: @"%li", dateComponents.year ] ];
    }
    
    document.sourceFile.text = text;
    self.activeDocument      = document;
    
    RELEASE_IVAR( _languageWindowController );
}

@end

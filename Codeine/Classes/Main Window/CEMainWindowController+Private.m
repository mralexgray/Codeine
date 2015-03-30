
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
    
    [ self.window beginSheet: _languageWindowController.window completionHandler: ^( NSModalResponse response )
        {
            if( response == NSModalResponseOK )
            {
                [ self didChooseLanguage: nil ];
            }
        }
    ];
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
            
        case CESourceFileLanguageHeader:
            
            template = [ templates stringByAppendingPathComponent: @"Header.txt" ];
            break;
            
        case CESourceFileLanguageC:
        case CESourceFileLanguageNone:
            
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
        dateComponents  = [ [ NSCalendar currentCalendar ] components: NSCalendarUnitYear fromDate: [ NSDate date ] ];
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

- ( void )preferencesDidChange: ( NSNotification * )notification
{

    
    if( [ [ CEPreferences sharedInstance ] fullScreenStyle ] == CEPreferencesFullScreenStyleNative )
    {
        self.window.collectionBehavior |= NSWindowCollectionBehaviorFullScreenPrimary;
    }
    else
    {
        self.window.collectionBehavior &= ~NSWindowCollectionBehaviorFullScreenPrimary;
    }
}

@end

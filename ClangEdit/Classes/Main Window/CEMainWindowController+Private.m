/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEMainWindowController+Private.h"
#import "CELanguageWindowController.h"
#import "CESourceFile.h"

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
    NSString * templates;
    NSString * template;
    
    templates = [ [ FILE_MANAGER applicationSupportDirectory ] stringByAppendingPathComponent: @"Templates" ];
    
    ( void )sender;
    
    RELEASE_IVAR( _sourceFile );
    
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
        case CESourceFileLanguageNone:
        default:
            
            template = [ templates stringByAppendingPathComponent: @"C.txt" ];
            break;
    }
    
    self.sourceFile = [ CESourceFile sourceFileWithLanguage: _languageWindowController.language fromFile: template ];
    
    RELEASE_IVAR( _languageWindowController );
}

@end

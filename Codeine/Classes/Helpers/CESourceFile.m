/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CESourceFile.h"
#import "CEPreferences.h"

@implementation CESourceFile

@synthesize language        = _language;
@synthesize translationUnit = _translationUnit;

+ ( id )sourceFileWithLanguage: ( CESourceFileLanguage )language
{
    return [ [ [ self alloc ] initWithLanguage: language ] autorelease ];
}

+ ( id )sourceFileWithLanguage: ( CESourceFileLanguage )language fromFile: ( NSString * )path
{
    return [ [ [ self alloc ] initWithLanguage: language fromFile: path ] autorelease ];
}

- ( id )initWithLanguage: ( CESourceFileLanguage )language
{
    if( ( self = [ self initWithLanguage: language fromFile: nil ] ) )
    {}
    
    return self;
}

- ( id )initWithLanguage: ( CESourceFileLanguage )language fromFile: ( NSString * )path
{
    BOOL     isDir;
    NSData * data;
    
    if( ( self = [ self init ] ) )
    {
        isDir     = NO;
        _language = language;
        
        if( [ FILE_MANAGER fileExistsAtPath: path isDirectory: &isDir ] == YES && isDir == NO )
        {
            data = [ FILE_MANAGER contentsAtPath: path ];
            
            if( data != nil )
            {
                self.text = [ [ [ NSString alloc ] initWithData: data encoding: [ [ CEPreferences sharedInstance ] textEncoding ] ] autorelease ];
            }
        }
    }
    
    return self;
}

- ( void )dealloc
{
    RELEASE_IVAR( _text );
    RELEASE_IVAR( _translationUnit );
    
    [ super dealloc ];
}

- ( NSString * )text
{
    @synchronized( self )
    {
        return _text;
    }
}

- ( void )setText: ( NSString * )text
{
    CKLanguage language;
    
    @synchronized( self )
    {
        if( text != _text )
        {
            RELEASE_IVAR( _text );
            
            _text = [ text retain ];
        }
        
        if( _translationUnit == nil )
        {
            if( _language == CESourceFileLanguageC )
            {
                language = CKLanguageC;
            }
            else if( _language == CESourceFileLanguageCPP )
            {
                language = CKLanguageCPP;
            }
            else if( _language == CESourceFileLanguageObjC )
            {
                language = CKLanguageObjC;
            }
            else if( _language == CESourceFileLanguageObjCPP )
            {
                language = CKLanguageObjCPP;
            }
            else if( _language == CESourceFileLanguageHeader )
            {
                language = CKLanguageObjCPP;
            }
            else
            {
                language = CKLanguageNone;
            }
            
            _translationUnit = [ [ CKTranslationUnit alloc ] initWithText: _text language: language ];
        }
        else
        {
            _translationUnit.text = _text;
        }
    }
}

@end

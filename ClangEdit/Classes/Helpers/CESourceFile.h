/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

typedef enum
{
    CESourceFileLanguageNone    = 0x00,
    CESourceFileLanguageC       = 0x01,
    CESourceFileLanguageCPP     = 0x02,
    CESourceFileLanguageObjC    = 0x03,
    CESourceFileLanguageObjCPP  = 0x04,
    CESourceFileLanguageHeader  = 0x05
}
CESourceFileLanguage;

typedef enum
{
    CESourceFileLineEndingUnknown    = 0x00,
    CESourceFileLineEndingUnix       = 0x01,
    CESourceFileLineEndingWindows    = 0x02
}
CESourceFileLineEnding;

@interface CESourceFile: NSObject
{
@protected
    
    CESourceFileLanguage _language;
    NSString           * _text;
    
@private
    
    RESERVERD_IVARS( CESourceFile , 5 );
}

@property( atomic, readonly )        CESourceFileLanguage language;
@property( atomic, readwrite, copy ) NSString           * text;

+ ( id )sourceFileWithLanguage: ( CESourceFileLanguage )language;
+ ( id )sourceFileWithLanguage: ( CESourceFileLanguage )language fromFile: ( NSString * )path;
- ( id )initWithLanguage: ( CESourceFileLanguage )language;
- ( id )initWithLanguage: ( CESourceFileLanguage )language fromFile: ( NSString * )path;

@end

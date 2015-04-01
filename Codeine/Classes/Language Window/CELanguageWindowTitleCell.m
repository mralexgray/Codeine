
/* $Id$ */

#import "CELanguageWindowTitleCell.h"
#import "CESourceFile.h"

@implementation CELanguageWindowTitleCell

- ( void )drawWithFrame: ( NSRect )frame inView: ( NSView * )view
{
    CESourceFileLanguage  language;
    NSString            * languageName;
    NSMutableDictionary * attributes;
    CGFloat               fontSize;
    CGRect                textRect;
    

    
    if( [ self.objectValue isKindOfClass: [ NSNumber class ] ] == NO )
    {
        return;
    }
    
    language = ( CESourceFileLanguage )[ ( NSNumber * )( self.objectValue ) integerValue ];
    
    switch( language )
    {
        case CESourceFileLanguageC:
            
            languageName = L10N( "LanguageC" );
            
            break;
            
        case CESourceFileLanguageCPP:
            
            languageName = L10N( "LanguageCPP" );
            
            break;
            
        case CESourceFileLanguageObjC:
            
            languageName = L10N( "LanguageObjC" );
            
            break;
            
        case CESourceFileLanguageObjCPP:
            
            languageName = L10N( "LanguageObjCPP" );
            
            break;
            
        case CESourceFileLanguageHeader:
            
            languageName = L10N( "LanguageHeader" );
            
            break;
            
        case CESourceFileLanguageNone:
            
            languageName = nil;
            
            break;
    }
    
    fontSize              = [ NSFont systemFontSize ];
    textRect              = frame;
    textRect.origin.y    += ( frame.size.height - fontSize ) / ( CGFloat )2;
    textRect.size.height -= ( frame.size.height - fontSize ) / ( CGFloat )2;
    
    attributes  = [ NSMutableDictionary dictionaryWithCapacity: 10 ];
    
    attributes[NSFontAttributeName] = [ NSFont systemFontOfSize: fontSize ];
    attributes[NSBackgroundColorAttributeName] = [ NSColor clearColor ];
    
    if( self.backgroundStyle == NSBackgroundStyleDark )
    {
        attributes[NSForegroundColorAttributeName] = [ NSColor whiteColor ];
    }
    else
    {
        attributes[NSForegroundColorAttributeName] = [ NSColor textColor ];
    }
    
    [ languageName drawInRect: textRect withAttributes: attributes ];
}

@end

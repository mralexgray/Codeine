/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
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
    
    ( void )view;
    
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
        default:
            
            languageName = nil;
            
            break;
    }
    
    fontSize              = [ NSFont systemFontSize ];
    textRect              = frame;
    textRect.origin.y    += ( frame.size.height - fontSize ) / ( CGFloat )2;
    textRect.size.height -= ( frame.size.height - fontSize ) / ( CGFloat )2;
    
    attributes  = [ NSMutableDictionary dictionaryWithCapacity: 10 ];
    
    [ attributes setObject: [ NSFont systemFontOfSize: fontSize ]   forKey: NSFontAttributeName ];
    [ attributes setObject: [ NSColor clearColor ]                  forKey: NSBackgroundColorAttributeName ];
    
    if( self.backgroundStyle == NSBackgroundStyleDark )
    {
        [ attributes setObject: [ NSColor whiteColor ] forKey: NSForegroundColorAttributeName ];
    }
    else
    {
        [ attributes setObject: [ NSColor textColor ] forKey: NSForegroundColorAttributeName ];
    }
    
    [ languageName drawInRect: textRect withAttributes: attributes ];
}

@end

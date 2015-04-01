
/* $Id$ */

#import "CELicensePopUpButton.h"
#import "CELicensePopUpButton+Private.h"

@implementation CELicensePopUpButton

- ( instancetype )initWithFrame: ( NSRect )frame
{
    if( ( self = [ super initWithFrame: frame ] ) )
    {
        [ self fillItems ];
    }
    
    return self;
}

- ( instancetype )initWithCoder: ( NSCoder * )coder
{
    if( ( self = [ super initWithCoder: coder ] ) )
    {
        [ self fillItems ];
    }
    
    return self;
}


- ( NSString * )licenseName
{
    NSMenuItem * item;
    
    item = [ self selectedItem ];
    
    return item.title;
}

- ( NSString * )licenseText
{
    NSMenuItem * item;
    NSString   * path;
    NSError    * error;
    NSString   * text;
    
    item  = [ self selectedItem ];
    path  = item.representedObject;
    error = nil;
    text  = nil;
    
    if( [ FILE_MANAGER isReadableFileAtPath: path ] )
    {
        text = [ NSString stringWithContentsOfFile: path encoding: NSUTF8StringEncoding error: &error ];
    }
    
    if( error == nil && text.length > 0 )
    {
        return text;
    }
    
    return @"";
}

@end

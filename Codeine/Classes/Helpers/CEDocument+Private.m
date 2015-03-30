
/* $Id$ */

#import "CEDocument+Private.h"

static NSUInteger       __newDocumentIndex = 0;
static NSString * const __newDocumentName  = @"Untitled";

@implementation CEDocument( Private )

- ( NSString * )nameForNewDocument
{
    NSString * name;
    
    if( __newDocumentIndex == 0 )
    {
        name = __newDocumentName;
    }
    else
    {
        name = [ NSString stringWithFormat: @"%@-%lu", __newDocumentName, __newDocumentIndex ];
    }
    
    __newDocumentIndex++;
    
    return name;
}

@end

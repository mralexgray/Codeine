
/* $Id$ */

#import "CETextEncoding.h"

#define __NUMBER_OF_TEXT_ENCODINGS  23

#ifdef __clang__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpadded"
#endif
struct __textEncoding
{
    unsigned int value;
    const char * name;
};
#ifdef __clang__
#pragma clang diagnostic pop
#endif

static struct __textEncoding __encodings[ __NUMBER_OF_TEXT_ENCODINGS ] =
{
    { NSUTF8StringEncoding,                 "NSUTF8StringEncoding" },
    { NSUTF16StringEncoding,                "NSUTF16StringEncoding" },
    { NSUTF16BigEndianStringEncoding,       "NSUTF16BigEndianStringEncoding" },
    { NSUTF16LittleEndianStringEncoding,    "NSUTF16LittleEndianStringEncoding" },
    { NSUTF32StringEncoding,                "NSUTF32StringEncoding" },
    { NSUTF32BigEndianStringEncoding,       "NSUTF32BigEndianStringEncoding" },
    { NSUTF32LittleEndianStringEncoding,    "NSUTF32LittleEndianStringEncoding" },
    { NSISOLatin1StringEncoding,            "NSISOLatin1StringEncoding" },
    { NSISOLatin2StringEncoding,            "NSISOLatin2StringEncoding" },
    { NSASCIIStringEncoding,                "NSASCIIStringEncoding" },
    { NSNonLossyASCIIStringEncoding,        "NSNonLossyASCIIStringEncoding" },
    { NSMacOSRomanStringEncoding,           "NSMacOSRomanStringEncoding" },
    { NSWindowsCP1251StringEncoding,        "NSWindowsCP1251StringEncoding" },
    { NSWindowsCP1252StringEncoding,        "NSWindowsCP1252StringEncoding" },
    { NSWindowsCP1253StringEncoding,        "NSWindowsCP1253StringEncoding" },
    { NSWindowsCP1254StringEncoding,        "NSWindowsCP1254StringEncoding" },
    { NSWindowsCP1250StringEncoding,        "NSWindowsCP1250StringEncoding" },
    { NSUnicodeStringEncoding,              "NSUnicodeStringEncoding" },
    { NSNEXTSTEPStringEncoding,             "NSNEXTSTEPStringEncoding" },
    { NSJapaneseEUCStringEncoding,          "NSJapaneseEUCStringEncoding" },
    { NSISO2022JPStringEncoding,            "NSISO2022JPStringEncoding" },
    { NSShiftJISStringEncoding,             "NSShiftJISStringEncoding" },
    { NSSymbolStringEncoding,               "NSSymbolStringEncoding" }
};

@implementation CETextEncoding

@synthesize encodingValue = _encodingValue;
@synthesize name          = _name;

+ ( NSArray * )availableEncodings
{
    NSUInteger               i;
    const NSStringEncoding * encodings;
    NSMutableArray         * array;
    CETextEncoding         * encoding;
    
    array     = [ NSMutableArray arrayWithCapacity: 100 ];
    encodings = [ NSString availableStringEncodings ];
    
    if( encodings == NULL )
    {
        return [ NSArray array ];
    }
    
    while( *( encodings ) != 0 )
    {
        for( i = 0; i < __NUMBER_OF_TEXT_ENCODINGS; i++ )
        {
            if( __encodings[ i ].value == *( encodings ) )
            {
                encoding         =[CETextEncoding.alloc 
         init ];
                encoding->_value = __encodings[ i ].value;
                encoding->_name  = @(__encodings[ i ].name);
                
                [ array addObject: encoding ];
                
                break;
            }
        }
        
        encodings++;
    }
    
    [ array sortUsingComparator: ( NSComparator ) ^ ( id obj1, id obj2 )
        {
            CETextEncoding * enc1;
            CETextEncoding * enc2;
            
            enc1 = ( CETextEncoding * )obj1;
            enc2 = ( CETextEncoding * )obj2;
            
            return [ enc1.localizedName localizedCaseInsensitiveCompare: enc2.localizedName ];
        }
    ];
    
    return [ NSArray arrayWithArray: array ];
}


- ( NSString * )localizedName
{
    NSString * name;
    
    @synchronized( self )
    {
        name = NSLocalizedString( _name, nil );
        
        if( name == nil || name.length == 0 )
        {
            return _name;
        }
        
        return name;
    }
}

@end

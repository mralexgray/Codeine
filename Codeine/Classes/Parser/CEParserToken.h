/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

typedef enum
{
    CEParserTokenTypeUnknown    = 0x00,
    CEParserTokenTypeWhitespace = 0x01,
    CEParserTokenTypeKeyword    = 0x02,
    CEParserTokenTypeComment    = 0x03,
    CEParserTokenTypeString     = 0x04,
    CEParserTokenTypePredefined = 0x05
}
CEParserTokenType;

@interface CEParserToken: NSObject
{
@protected
    
    CEParserTokenType _type;
    
@private
    
    RESERVERD_IVARS( CEParserToken, 5 );
}

@property( atomic, readonly ) CEParserTokenType type;

@end

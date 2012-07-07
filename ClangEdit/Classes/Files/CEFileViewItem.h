/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

typedef enum
{
    CEFileViewItemTypeSection   = 0x00,
    CEFileViewItemTypeDocument  = 0x01,
    CEFileViewItemTypeFSItem    = 0x02
}
CEFileViewItemType;

@interface CEFileViewItem: NSObject
{
@protected
    
    CEFileViewItemType _type;
    NSString         * _name;
    id                 _representedObject;
    
@private
    
    RESERVERD_IVARS( CEFileViewItem, 5 );
}

@property( atomic, readonly          ) CEFileViewItemType type;
@property( atomic, readonly          ) NSString *         name;
@property( atomic, readwrite, retain ) id                 representedObject;

+ ( id )fileViewItemWithType: ( CEFileViewItemType )type name: ( NSString * )name;
- ( id )initWithType: ( CEFileViewItemType )type name: ( NSString * )name;

@end

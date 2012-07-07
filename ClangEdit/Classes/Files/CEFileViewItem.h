/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

typedef enum
{
    CEFileViewItemTypeSection   = 0x00,
    CEFileViewItemTypeDocument  = 0x01,
    CEFileViewItemTypeFS        = 0x02
}
CEFileViewItemType;

@interface CEFileViewItem: NSObject
{
@protected
    
    CEFileViewItemType _type;
    NSString         * _name;
    id                 _representedObject;
    NSMutableArray   * _childrens;
    
@private
    
    RESERVERD_IVARS( CEFileViewItem, 5 );
}

@property( atomic, readonly          ) CEFileViewItemType type;
@property( atomic, readonly          ) NSString *         name;
@property( atomic, readonly          ) NSArray  *         childrens;
@property( atomic, readwrite, retain ) id                 representedObject;

+ ( id )fileViewItemWithType: ( CEFileViewItemType )type name: ( NSString * )name;
- ( id )initWithType: ( CEFileViewItemType )type name: ( NSString * )name;

@end

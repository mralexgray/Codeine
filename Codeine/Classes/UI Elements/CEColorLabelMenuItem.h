/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

@class CEColorLabelView;

@interface CEColorLabelMenuItem: NSMenuItem
{
@protected
    
    CEColorLabelView * _view;
    NSColor          * _selectedColor;
    
@private
    
    RESERVERD_IVARS( CEColorLabelView, 5 );
}

@property( nonatomic, readwrite, retain ) NSColor * selectedColor;

@end

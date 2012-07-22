/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEEditorRulerView+Private.h"

@implementation CEEditorRulerView( Private )

- ( void )textStorageDidProcessEditing: ( NSNotification * )notification
{
    ( void )notification;
    
    [ self setNeedsDisplay: YES ];
}

@end

/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEEditorViewController.h"

@interface CEEditorViewController( Private )

- ( void )updateView;
- ( void )textDidChange: ( NSNotification * )notification;
- ( void )highlightSyntax;

@end

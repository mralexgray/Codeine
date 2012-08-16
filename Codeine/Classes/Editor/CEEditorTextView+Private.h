/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CEEditorTextView.h"

@interface CEEditorTextView( Private )

- ( void )drawPageGuideInRect: ( NSRect )rect;
- ( void )drawTabStopsInRect: ( NSRect )rect;
- ( NSRect )drawRectForRange: ( NSRange )range;
- ( void )drawCurrentLineHighlight: ( NSRect )rect;
- ( void )selectionDidChange: ( NSNotification * )notification;

@end

/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import "CESyntaxHighlighter.h"

@interface CESyntaxHighlighter( Private )

- ( void )updateText;
- ( void )textDidChange: ( NSNotification * )notification;

@end

/*******************************************************************************
 * Copyright (c) 2012, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

#import <Quartz/Quartz.h>

@interface NSApplication( CE ) < QLPreviewPanelDataSource >

- ( void )showQuickLookPanelForItemAtPath: ( NSString * )path sender: ( id )sender;

@end

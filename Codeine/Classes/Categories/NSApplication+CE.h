
/* $Id$ */

#import <Quartz/Quartz.h>

@interface NSApplication (CE) <QLPreviewPanelDataSource>

- (void)showQuickLookPanelForItemAtPath:(NSString*)path sender:(id)sender;

@end

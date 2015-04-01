
/* $Id$ */

#import "CEEditorRulerView.h"

@interface CEEditorRulerView (Private)

- (void)textStorageDidProcessEditing:(NSNotification*)notification;
- (void)textViewSelectionDidChange:(NSNotification*)notification;
- (void)applicationStateDidChange:(NSNotification*)notification;
- (void)setRect:(NSRect)rect forLine:(NSUInteger)line;
- (NSRect)rectForLine:(NSUInteger)line;
- (NSUInteger)lineForPoint:(NSPoint)point;
- (void)addMarkerForLine:(NSUInteger)line;
- (void)removeMarkerForLine:(NSUInteger)line;
- (CEEditorMarker*)markerForLine:(NSUInteger)line;
@property (readonly, copy) NSMutableDictionary *textAttributes;

@end

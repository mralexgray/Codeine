
/* $Id$ */

#import "CEPreferences.h"

@interface CEPreferences (Private)

- (NSColor*)colorForKey:(NSString*)key;
- (NSColor*)colorForKey:(NSString*)key inDictionary:(NSDictionary*)dictionary;
- (void)setColor:(NSColor*)color forKey:(NSString*)key;

@end

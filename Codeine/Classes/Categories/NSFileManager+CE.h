
/* $Id$ */

@interface NSFileManager (CE)

- (NSString*)pathOfDirectory:(NSSearchPathDirectory)directory
                    inDomain:(NSSearchPathDomainMask)domain
             byAppendingPath:(NSString*)appendPath
           createIfNecessary:(BOOL)create;
@property (readonly, copy) NSString *applicationSupportDirectory;

@end

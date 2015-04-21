
/* $Id$ */


@import AppKit;

typedef NS_OPTIONS(unsigned int, CEStringDataSizeType) {
  CEStringDataSizeTypeAuto = 0x000,
  CEStringDataSizeTypeBytes = 0x001,

  CEStringDataSizeTypeKiloBytes = 0x101,
  CEStringDataSizeTypeMegaBytes = 0x102,
  CEStringDataSizeTypeGigaBytes = 0x103,
  CEStringDataSizeTypeTeraBytes = 0x104,
  CEStringDataSizeTypePetaBytes = 0x105,
  CEStringDataSizeTypeExaBytes = 0x106,
  CEStringDataSizeTypeZettaBytes = 0x107,
  CEStringDataSizeTypeYottaBytes = 0x108,

  CEStringDataSizeTypeKibiBytes = 0x201,
  CEStringDataSizeTypeMebiBytes = 0x202,
  CEStringDataSizeTypeGibiBytes = 0x203,
  CEStringDataSizeTypeTebiBytes = 0x204,
  CEStringDataSizeTypePebiBytes = 0x205,
  CEStringDataSizeTypeExbiBytes = 0x206,
  CEStringDataSizeTypeZebiBytes = 0x207,
  CEStringDataSizeTypeYobiBytes = 0x208
};

@interface NSString (CE)

+ (NSString*)stringForDataSizeWithBytes:(uint64_t)bytes;
+ (NSString*)stringForDataSizeWithBytes:(uint64_t)bytes numberOfDecimals:(NSUInteger)decimals;
+ (NSString*)stringForDataSizeWithBytes:(uint64_t)bytes unit:(CEStringDataSizeType)unit;
+ (NSString*)stringForDataSizeWithBytes:(uint64_t)bytes unit:(CEStringDataSizeType)unit numberOfDecimals:(NSUInteger)decimals;

@end


@interface NSFileManager (CE)

- (NSString*)pathOfDirectory:(NSSearchPathDirectory)directory
                    inDomain:(NSSearchPathDomainMask)domain
             byAppendingPath:(NSString*)appendPath
           createIfNecessary:(BOOL)create;
@property (readonly, copy) NSString *applicationSupportDirectory;

@end

@interface NSView (CE)

- (void)centerInSuperview;

@end

FOUNDATION_EXPORT NSString* const NSBundleInfoKeyCFBundleDevelopmentRegion,
                          * const NSBundleInfoKeyCFBundleExecutable,
                          * const NSBundleInfoKeyCFBundleIconFile,
                          * const NSBundleInfoKeyCFBundleIdentifier,
                          * const NSBundleInfoKeyCFBundleInfoDictionaryVersion,
                          * const NSBundleInfoKeyCFBundleName,
                          * const NSBundleInfoKeyCFBundlePackageType,
                          * const NSBundleInfoKeyCFBundleShortVersionString,
                          * const NSBundleInfoKeyCFBundleSignature,
                          * const NSBundleInfoKeyCFBundleVersion,
                          * const NSBundleInfoKeyLSApplicationCategoryType,
                          * const NSBundleInfoKeyLSMinimumSystemVersion,
                          * const NSBundleInfoKeyNSHumanReadableCopyright,
                          * const NSBundleInfoKeyNSMainNibFile,
                          * const NSBundleInfoKeyNSPrincipalClass;

@interface NSBundle (CE)
@end

@interface NSTextView (CE)

@property (readonly) NSUInteger numberOfHardLines, numberOfSoftLines;
@property (readonly)  NSInteger currentLine, currentColumn;

- (void)enableSoftWrap;
- (void)disableSoftWrap;

@end

@interface NSImage (CE)

- (NSImage*)imageWithSize:(CGFloat)size;
@property (readonly, copy) NSImage *grayscaleImage;

@end

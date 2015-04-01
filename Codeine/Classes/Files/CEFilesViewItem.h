
/* $Id$ */

typedef NS_OPTIONS(unsigned int, CEFilesViewItemType) {
  CEFilesViewItemTypeSection = 0x00,
  CEFilesViewItemTypeDocument = 0x01,
  CEFilesViewItemTypeFS = 0x02,
  CEFilesViewItemTypeBookmark = 0x03
};

FOUNDATION_EXPORT NSString* const CEFilesViewOpenDocumentsItemName;
FOUNDATION_EXPORT NSString* const CEFilesViewPlacesItemName;
FOUNDATION_EXPORT NSString* const CEFilesViewBookmarksItemName;

@class CEFile;

@interface CEFilesViewItem : NSObject<NSCopying> {
@protected

  CEFilesViewItemType _type;
  NSString* _name;
  CEFile* _file;

@private

  NSMutableArray* _children;
  CEFilesViewItem* __weak _parent;
  id _representedObject;
  NSImage* _icon;
  NSString* _displayName;

  RESERVED_IVARS(CEFileViewItem, 5);
}

@property (readonly) CEFilesViewItemType type;
@property (readonly) NSString* name;
@property (readonly) NSString* displayName;
@property (readonly) NSImage* icon;
@property (weak,readonly) NSArray* children;
@property (readonly) CEFile* file;
@property (readonly) BOOL expandable;
@property (readwrite, strong) id representedObject;
@property (readonly) BOOL isLeaf;
@property (weak,readonly) CEFilesViewItem* parent;

+ (id)placesItem;
+ (id)bookmarksItems;
+ (id)fileViewItemWithType:(CEFilesViewItemType)type name:(NSString*)name;
- (instancetype)initWithType:(CEFilesViewItemType)type name:(NSString*)name NS_DESIGNATED_INITIALIZER;
- (void)addChild:(CEFilesViewItem*)child;
- (void)removeChild:(CEFilesViewItem*)child;
- (void)removeAllChildren;
- (void)reload;

@end

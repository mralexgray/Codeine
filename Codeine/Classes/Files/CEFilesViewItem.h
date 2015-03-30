
/* $Id$ */

typedef enum {
  CEFilesViewItemTypeSection = 0x00,
  CEFilesViewItemTypeDocument = 0x01,
  CEFilesViewItemTypeFS = 0x02,
  CEFilesViewItemTypeBookmark = 0x03
} CEFilesViewItemType;

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

@property (atomic, readonly) CEFilesViewItemType type;
@property (atomic, readonly) NSString* name;
@property (atomic, readonly) NSString* displayName;
@property (atomic, readonly) NSImage* icon;
@property (weak, atomic, readonly) NSArray* children;
@property (atomic, readonly) CEFile* file;
@property (atomic, readonly) BOOL expandable;
@property (atomic, readwrite, strong) id representedObject;
@property (atomic, readonly) BOOL isLeaf;
@property (weak, atomic, readonly) CEFilesViewItem* parent;

+ (id)placesItem;
+ (id)bookmarksItems;
+ (id)fileViewItemWithType:(CEFilesViewItemType)type name:(NSString*)name;
- (id)initWithType:(CEFilesViewItemType)type name:(NSString*)name;
- (void)addChild:(CEFilesViewItem*)child;
- (void)removeChild:(CEFilesViewItem*)child;
- (void)removeAllChildren;
- (void)reload;

@end

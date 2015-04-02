
/* $Id$ */

#import "CEFilesViewItemFS.h"
#import "CEPreferences.h"
#import "CEFile.h"

@implementation CEFilesViewItemFS

- (instancetype)initWithType:(CEFilesViewItemType)type name:(NSString*)name {
  NSRange range;

  if ((self = [super initWithType:type name:name])) {
    range = [_name rangeOfString:@":"];

    if (range.location == NSNotFound) {
      _path = _name.copy;
      _prefix = nil;
    } else {
      _path = [_name substringFromIndex:range.location + 1].copy;
      _prefix = [_name substringToIndex:range.location].copy;
    }

    if (![FILE_MANAGER fileExistsAtPath:_path isDirectory:&_isDirectory]) return nil;

    _file =[CEFile.alloc initWithPath:_path];
  }

  return self;
}

- (void)dealloc {
  RELEASE_IVAR(_path);
  RELEASE_IVAR(_prefix);
  RELEASE_IVAR(_file);
}

- (id)copyWithZone:(NSZone*)zone {

  CEFilesViewItemFS*item = [super copyWithZone:zone];

  if (!item) return item;
  item->_path = _path.copy;
  item->_prefix = _prefix.copy;
  item->_isDirectory = _isDirectory;
  return item;
}

- (NSString*)displayName {
  return [FILE_MANAGER displayNameAtPath:_path];
}

- (NSImage*)icon {
  return [WORKSPACE iconForFile:_path];
}

- (BOOL)expandable {
  return _isDirectory; // && self.children.count > 0;
}

- (NSArray*)children {
  NSDirectoryEnumerator* enumerator;
  NSString* file;
  NSString* path;
  NSString* name;
  CEFilesViewItem* item;
  CFURLRef url;
  LSItemInfoRecord info;
  BOOL invisible;
  BOOL showHidden;

  if (super.children.count > 0) return [super children];

  showHidden = CEPreferences.sharedInstance.showHiddenFiles;
  enumerator = [FILE_MANAGER enumeratorAtPath:_path];
//  [enumerator skipDescendants];

  for (file in enumerator) {
//  while ((file = [enumerator nextObject])) {
    [enumerator skipDescendants];

    path = [_path stringByAppendingPathComponent:file];

    if (showHidden == NO) {
      if ([path isEqualToString:@"/dev"]) {
        continue;
      }
      if ([path isEqualToString:@"/home"]) {
        continue;
      }
      if ([path isEqualToString:@"/net"]) {
        continue;
      }
    }

    if (_prefix == nil) {
      name = [_path stringByAppendingFormat:@":%@", path];
    } else {
      name = [_prefix stringByAppendingFormat:@":%@", path];
    }

    item = [CEFilesViewItem fileViewItemWithType:_type name:name];
    url = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (CFStringRef)path, kCFURLPOSIXPathStyle, YES);

    LSCopyItemInfoForURL(url, kLSRequestAllFlags, &info);

    invisible = info.flags & kLSItemInfoIsInvisible;

    if (item != nil && (invisible == NO || showHidden == YES)) {
      [self addChild:item];
    }

    CFRelease(url);
  }

  return super.children;
}

- (id)valueForKeyPath:(NSString*)keyPath {
  CEFilesViewItem* item;

  [self children];

  for (item in self.children) {
    if ([item.name isEqualToString:keyPath]) {
      return item;
    } else if ([keyPath hasPrefix:item.name]) {
      return [item valueForKeyPath:keyPath];
    }
  }

  return nil;
}

- (BOOL)isLeaf {
  return (_isDirectory == YES) ? NO : YES;
}

- (void)reload {
  RELEASE_IVAR(_file);

  _file =[CEFile.alloc 
         initWithPath:_path];
}

@end

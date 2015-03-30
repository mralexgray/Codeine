
/* $Id$ */

@class CEDocument;

@interface CEBuilder : NSObject {
@protected

  CEDocument* _document;

@private

  RESERVED_IVARS(CEBuilder, 5);
}

@property (atomic, readonly) CEDocument* document;

+ (id)builderWithDocument:(CEDocument*)document;
- (id)initWithDocument:(CEDocument*)document;
- (BOOL)build:(NSError**)error;
- (BOOL)run:(NSError**)error;
- (BOOL)stop:(NSError**)error;

@end


/* $Id$ */

@class CEDocument;

@interface CEBuilder : NSObject {
@protected

  CEDocument* _document;

@private

  RESERVED_IVARS(CEBuilder, 5);
}

@property (readonly) CEDocument* document;

+ (instancetype)builderWithDocument:(CEDocument*)document;
- (instancetype)initWithDocument:(CEDocument*)document;
- (BOOL)build:(NSError**)error;
- (BOOL)run:(NSError**)error;
- (BOOL)stop:(NSError**)error;

@end

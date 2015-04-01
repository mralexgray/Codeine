
/* $Id$ */

@interface CEDiagnosticWrapper : NSObject<NSCopying> {
@protected

  CKDiagnostic* _diagnostic;

@private

  RESERVED_IVARS(CEDiagnostic, 5);
}

@property (readonly) CKDiagnostic* diagnostic;

+ (instancetype)diagnosticWrapperWithDiagnostic:(CKDiagnostic*)diagnostic;
- (instancetype)initWithDiagnostic:(CKDiagnostic*)diagnostic;

@end

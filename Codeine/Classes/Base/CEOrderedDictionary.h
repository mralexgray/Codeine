
/* $Id$ */

@interface CEOrderedDictionary : NSDictionary {
@protected

  NSArray* _keys;
  NSArray* _objects;

@private

  RESERVED_IVARS(CEOrderedDictionary, 5);
}

- (id)keyAtIndex:(NSUInteger)index;
- (id)objectAtIndex:(NSUInteger)index;

@end

#ifdef __OBJC__
#import <Cocoa/Cocoa.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CDBDelegateCollection.h"
#import "CDBDelegateReference.h"

FOUNDATION_EXPORT double CDBDelegateCollectionVersionNumber;
FOUNDATION_EXPORT const unsigned char CDBDelegateCollectionVersionString[];

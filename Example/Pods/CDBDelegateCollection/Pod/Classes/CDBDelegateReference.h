

#if __has_feature(objc_modules)
    @import Foundation;
    @import UIKit;
#else
    #import <Foundation/Foundation.h>
    #import <UIKit/UIKit.h>
#endif


@interface CDBDelegateReference : NSObject

@property (weak, nonatomic) id<NSObject> delegate;

+ (instancetype)withDelegate:(id<NSObject>)delegate;

@end

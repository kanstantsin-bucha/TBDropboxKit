//
//  TBLogger.h
//  Pods
//
//  Created by Bucha Kanstantsin on 2/11/17.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TBLogLevel) {
    TBLogLevelVerbose = 0,
    TBLogLevelInfo = 1,
    TBLogLevelLog = 2,
    TBLogLevelWarning = 3,
    TBLogLevelError = 4,
};

//                            [levelDescription] loggerName logMessage
#define dTBLogInitialFormat @"[%@] %@: %@\r\n"


@interface TBLogger : NSObject

/**
 @brief accepts 3 objects - [levelDescription] loggerName logMessage
 @see dTBLogInitialFormat
 **/

@property (copy, nonatomic) NSString * loggerName;

/**
 @brief accepts 3 objects - [levelDescription] loggerName logMessage
 @see dTBLogInitialFormat
 **/

@property (copy, nonatomic) NSString * logFormatString;
@property (assign, nonatomic) TBLogLevel acceptingLogLevel;

- (void)verbose:(NSString * _Nullable)format, ... NS_FORMAT_FUNCTION(1,2);
- (void)info:(NSString * _Nullable)format, ... NS_FORMAT_FUNCTION(1,2);
- (void)log:(NSString * _Nullable)format, ... NS_FORMAT_FUNCTION(1,2);
- (void)warning:(NSString * _Nullable)format, ... NS_FORMAT_FUNCTION(1,2);
- (void)error:(NSString * _Nullable)format, ... NS_FORMAT_FUNCTION(1,2);

- (NSString *)localizedLevelDescriptionUsingLogLevel:(TBLogLevel)level;

@end

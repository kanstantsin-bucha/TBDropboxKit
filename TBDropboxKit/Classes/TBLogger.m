//
//  TBLogger.m
//  Pods
//
//  Created by Bucha Kanstantsin on 2/11/17.
//
//

#import "TBLogger.h"
#import <CDBKit/CDBKit.h>





@implementation TBLogger

/// MARK: property

- (NSString *)loggerName {
    if (_loggerName.length > 0) {
        return _loggerName;
    }
    
    return @"";
}

/// MARK: life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        _acceptingLogLevel = TBLogLevelLog;
        _logFormatString = dTBLogInitialFormat;
    }
    
    return self;
}

/// MARK: public

- (void)verbose:(NSString * _Nullable)format, ... NS_FORMAT_FUNCTION(1,2) {
    [self logUsingLevel: TBLogLevelVerbose
            withFormat: format];
}

- (void)info:(NSString * _Nullable)format, ... NS_FORMAT_FUNCTION(1,2) {
    [self logUsingLevel: TBLogLevelInfo
             withFormat: format];
}

- (void)log:(NSString * _Nullable)format, ... NS_FORMAT_FUNCTION(1,2) {
    [self logUsingLevel: TBLogLevelLog
             withFormat: format];
}

- (void)warning:(NSString * _Nullable)format, ... NS_FORMAT_FUNCTION(1,2) {
    [self logUsingLevel: TBLogLevelWarning
             withFormat: format];
}

- (void)error:(NSString * _Nullable)format, ... NS_FORMAT_FUNCTION(1,2) {
    [self logUsingLevel: TBLogLevelError
             withFormat: format];
}

/// MARK: private

- (void)logUsingLevel:(TBLogLevel)level
           withFormat:(NSString * _Nullable)format, ... NS_FORMAT_FUNCTION(2,3) {
    if (format == nil) {
        return;
    }
    
    if (level < self.acceptingLogLevel) {
        return;
    }
    
    va_list args;
    va_start(args, format);
    NSString * message = [[NSString alloc] initWithFormat: format
                                                arguments: args];
    va_end(args);
    
    [self logMessage: message
          usingLevel: level];
}

- (void)logMessage:(NSString *)message
        usingLevel:(TBLogLevel)level {
    
    if (self.logFormatString == nil) {
        self.logFormatString = dTBLogInitialFormat;
    }
    
    NSString * description = [self localizedLevelDescriptionUsingLogLevel: level];
    NSString * log =
        [NSString stringWithFormat:self.logFormatString,
                                   description, self.loggerName, message];
    NSLog(log);
}

+ (NSString *)localizedLevelDescriptionUsingLogLevel:(TBLogLevel)level {
    NSString * result = @"";
    switch (level) {
            
            case TBLogLevelVerbose: {
                result = LSCDB(@"VERBOSE");
            }    break;
            
            case TBLogLevelInfo: {
                result = LSCDB(@"INFO");
            }    break;
            
            case TBLogLevelWarning: {
                result = LSCDB(@"WARNING");
            }    break;
            
            case TBLogLevelError: {
                result = LSCDB(@"ERROR");
            }    break;
            
        default: {
        }    break;
    }
    return result;
}

@end

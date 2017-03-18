//
//  TBLogger.m
//  Pods
//
//  Created by Bucha Kanstantsin on 2/11/17.
//
//

#import "TBLogger.h"
#import <CDBKit/CDBKit.h>

@interface TBLogger ()

@property (copy, nonatomic, readwrite, nullable) NSString * loggerName;

@end

@implementation TBLogger

/// MARK: property

- (NSString *)loggerName {
    if (_loggerName.length > 0) {
        return _loggerName;
    }
    
    return @"";
}

- (NSString *)logFormatString {
    if (_logFormatString.length > 6) {
        return _logFormatString;
    }

    _logFormatString = dTBLogDefaultFormat;
    return _logFormatString;
}

/// MARK: life cycle

- (instancetype)initInstance {
    self = [super init];
    if (self) {
        _logLevel = TBLogLevelVerbose;
        _logFormatString = dTBLogDefaultFormat;
    }
    
    return self;
}

+ (instancetype)loggerWithName:(NSString *)name {
    TBLogger * result = [[[self class] alloc] initInstance];
    result.loggerName = name;
    return result;
}
/// MARK: public

- (void)verbose:(NSString * _Nullable)format, ... NS_FORMAT_FUNCTION(1,2) {
    va_list args;
    va_start(args, format);
    
    [self logUsingLevel: TBLogLevelVerbose
                 format: format
              arguments: args];
    
    va_end(args);
}

- (void)info:(NSString * _Nullable)format, ... NS_FORMAT_FUNCTION(1,2) {
    va_list args;
    va_start(args, format);
    
    [self logUsingLevel: TBLogLevelInfo
                 format: format
              arguments: args];
    
    va_end(args);
}

- (void)log:(NSString * _Nullable)format, ... NS_FORMAT_FUNCTION(1,2) {
    va_list args;
    va_start(args, format);
    
    [self logUsingLevel: TBLogLevelLog
                 format: format
              arguments: args];
    
    va_end(args);
}

- (void)warning:(NSString * _Nullable)format, ... NS_FORMAT_FUNCTION(1,2) {
    va_list args;
    va_start(args, format);

    [self logUsingLevel: TBLogLevelWarning
                 format: format
              arguments: args];
    
    va_end(args);
}

- (void)error:(NSString * _Nullable)format, ... NS_FORMAT_FUNCTION(1,2) {
    va_list args;
    va_start(args, format);
    
    [self logUsingLevel: TBLogLevelError
                 format: format
              arguments: args];
    
    va_end(args);
}

/// MARK: private

- (void)logUsingLevel:(TBLogLevel)level
               format:(NSString * _Nullable)format
               arguments:(va_list)argList NS_FORMAT_FUNCTION(2,0) {// ... NS_FORMAT_FUNCTION(2,3) {
    if (format == nil) {
        return;
    }
    
    if (level < self.logLevel) {
        return;
    }
    
    NSString * message = nil;
    @try {
        message = [[NSString alloc] initWithFormat: format
                                         arguments: argList];
    } @catch (NSException * exception) {
        message = exception.description;
    } @finally {
    
    }
    
    if (message == nil) {
        return;
    }
    
    [self logMessage: message
          usingLevel: level];
}

- (void)logMessage:(NSString *)message
        usingLevel:(TBLogLevel)level {
    
    NSString * description = [self localizedDescriptionUsingLogLevel: level];
    NSString * log =
        [NSString stringWithFormat:self.logFormatString,
                                   description, self.loggerName, message];
    NSLog(log);
}

- (NSString *)localizedDescriptionUsingLogLevel:(TBLogLevel)level {
    NSString * result = @"";
    switch (level) {
            
            case TBLogLevelVerbose: {
                result = LSCDB(VERBOSE);
            }    break;
            
            case TBLogLevelInfo: {
                result = LSCDB(INFO);
            }    break;
            
            case TBLogLevelLog: {
                result = LSCDB(LOG);
            }    break;
            
            case TBLogLevelWarning: {
                result = LSCDB(WARNING);
            }    break;
            
            case TBLogLevelError: {
                result = LSCDB(ERROR);
            }    break;
            
        default: {
        }    break;
    }
    return result;
}

@end

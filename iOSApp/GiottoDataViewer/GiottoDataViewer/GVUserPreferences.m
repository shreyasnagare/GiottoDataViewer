//
//  UAUserPreferences.m
//  UniAuthClient
//
//  Created by Eiji Hayashi on 2/14/14.
//  Copyright (c) 2014 Eiji Hayashi. All rights reserved.
//

#import "GVUserPreferences.h"

@implementation GVUserPreferences

#pragma mark - Singleton

static GVUserPreferences *sharedInstance = nil;

+ (GVUserPreferences *)sharedInstance
{
	@synchronized(self)
	{
		if (sharedInstance == nil)
		{
			sharedInstance = [[self alloc] init];
		}
	}
    
	return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
	@synchronized(self)
	{
		if (sharedInstance == nil)
		{
			sharedInstance = [super allocWithZone:zone];
			return sharedInstance;
		}
	}
    
	return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
	return self;
}

#pragma mark - Init / Dealloc

- (id) init
{
    self = [super init];
    if( self ){
    }
    
    return self;
}

- (void) dealloc
{
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - accessors
- (NSString*)oauthAppId
{
    return [self loadPreference:@"oauthAppId" default:@"4G3ot83dNbu1r1Y5KW6qeSwSyDyXaRLTMw9XEpiZ"];
}

- (void) setOauthAppId:(NSString *)oauthAppId
{
    [self savePreference:oauthAppId forKey:@"oauthAppId"];
}

- (NSString*)oauthAppKey
{
    return [self loadPreference:@"oauthAppKey" default:@"t9U3ME5HfAcZRX8IrO3XoNTwqWkLQN8fLmGFAQT86vSx5dJBDT"];
}

- (void) setOauthAppKey:(NSString *)oauthAppKey
{
    [self savePreference:oauthAppKey forKey:@"oauthAppKey"];
}

- (NSString*)giottoServer
{
    return [self loadPreference:@"giottoServer" default:@""];
}

- (void) setGiottoServer:(NSString *)giottoServer
{
    [self savePreference:giottoServer forKey:@"giottoServer"];
}

- (NSString*) giottoPort
{
    return [self loadPreference:@"giottoPort" default:@"82"];
}

- (void) setGiottoPort:(NSString *)giottoPort
{
    [self savePreference:giottoPort forKey:@"giottoPort"];
}

- (NSString*) locationEmulation
{
    return [self loadPreference:@"locationEmulation" default:@""];
}

- (void) setOauthPort: (NSString *)oauthPort
{
    [self savePreference:oauthPort forKey:@"oauthPort"];
}

- (NSString *) oauthPort
{
    return [self loadPreference:@"oauthPort" default:@"81"];
}

- (void) setLocationEmulation:(NSString *)locationEmulation
{
    [self savePreference:locationEmulation forKey:@"locationEmulation"];
}

- (NSString*) apiPrefix
{
    return [self loadPreference:@"apiPrefix" default:@"/api"];
}

- (void) setApiPrefix:(NSString *)apiPrefix
{
    [self savePreference:apiPrefix forKey:@"apiPrefix"];
}

- (void)save
{
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - private method

- (id) loadPreference: (NSString*)key default:(id) defaultValue
{
    id object = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if( !object )
        object = defaultValue;
    
    return object;
}

- (void) savePreference: (id) object forKey:(NSString*) key
{
    if( object )
        [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
}


@end

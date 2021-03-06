//
//  BuildingDepotManager.h
//  GiottoDataViewer
//
//  Created by Eiji Hayashi on 3/20/16.
//  Copyright © 2016 Eiji Hayashi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GVBuildingDepotManager : NSObject
{
    __strong NSString * _accessToken;
}

+ (GVBuildingDepotManager *)sharedInstance;

- (NSArray*) fetchSensorsAt:(NSString*)location;
- (NSArray *) fetchSensorsWithLocationTag:(NSString *)location;
- (NSArray*) fetchSensorReading:(NSString*)sensorUuid :(NSTimeInterval)startTime :(NSTimeInterval)endTime :(NSString*)resolution;
- (void) fetchOAuthToken:(NSString*)appId forKey:(NSString*)appKey;

@end

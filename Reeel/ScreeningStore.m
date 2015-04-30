//
//  ScreeningStore.m
//  Reeel
//
//  Created by Paul Dariye on 4/28/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import "ScreeningStore.h"

@interface ScreeningStore()

@property (nonatomic) NSMutableArray *screenings;

@property (nonatomic) NSMutableArray *rsvpedScreenings;

@property (nonatomic) NSDate *randomDate;

@property (nonatomic) long randomNumber;

@end

@implementation ScreeningStore

@synthesize screenings;
@synthesize rsvpedScreenings;
@synthesize randomDate;
@synthesize randomNumber;


+ (instancetype)sharedStore
{
    static ScreeningStore *sharedStore = nil;
    
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[ScreeningStore sharedStore]"  userInfo:nil];
    
    
    return nil;
}


- (instancetype)initPrivate
{
    self = [super init];
    
    if (self) {
        
        screenings = [[NSMutableArray alloc] init];
        rsvpedScreenings = [[NSMutableArray alloc] init];
        
        
        // Date formatter
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        
        [dateFormat setDateFormat:@"MMM d '@' HH:mm a"];
        // TODO: date formatter for next year events
        
        NSDate *today = [[NSDate alloc] init];
        
        NSMutableDictionary *movieMeta;
        
        
        for (int i = 0; i < 10; i++) {
            
            short randBinary = arc4random() % 2;

            randomNumber = arc4random_uniform(60 * 60 * 24 * 60);
//            randomDate = [NSDate dateWithTimeIntervalSinceNow:randomNumber];
            
            movieMeta[@"title"] = @"Some Title";
            movieMeta[@"release"] = @"Apr 2015";
            movieMeta[@"contentRating"] = @"PG";
            movieMeta[@"duration"] = @"114 min";
            movieMeta[@"genre"] = @"Horror";
            movieMeta[@"director"] = @"Some Dudes and Gals";
            movieMeta[@"stars"] = @"Some Gals and Dudes";
            
//            NSLog(<#NSString *format, ...#>)
            
            
            randomDate = [today dateByAddingTimeInterval:randomNumber];
            
            Screening *screening = [[Screening alloc] initWithScreeningTitle:[NSString stringWithFormat:@"Screening - %d", i] screeningDate:[dateFormat stringFromDate:randomDate] screeningLocation:@"Mercer, NY" screeningTheatre:@"Angelika" screeningDescription:@"Some Random text that tells something about the movie or screening...blah blah" screeningMetaData:[[NSMutableDictionary alloc] initWithDictionary:movieMeta] screeningFee:i discount:0];
            
            NSLog(@"Meta Dict --> %@", screening.screeningMetaData[@"title"]);
            
            NSLog(@"Adding item %@", screening);
            
            screening.rsvp = (randBinary == 1)? YES : NO;
            
            NSLog(@"RSVP -->  %i", screening.rsvp);
            
            [screenings addObject:screening];
            
            
            // REMOVE --- JUST FOR MOCK!
            if ([screening isRsvped]) {
                [self rsvpForScreening:screening];
            }
            
            
            
            
        }
        NSLog(@"Count -- > %i", [screenings count]);
    }
    
    return self;
}

- (NSArray *)allScreenings
{
    return screenings;
}

- (NSArray *)allRSVPedScreenings
{
//    for (id screening in screenings) {
//        NSLog(@"in allRSVPedScreenings");
//        [self rsvpForScreening:screening];
//    }
    
    return rsvpedScreenings;
}

- (void)rsvpForScreening:(Screening *)screening
{
    NSLog(@"in rsvpForScreening");
    if ([screening isRsvped]) {
        [rsvpedScreenings addObject:screening];
    }else {
        screening.rsvp = YES;
        [rsvpedScreenings addObject:screening];
    }
}



- (void)removeScreening:(Screening *)screening
{
    NSString *key = screening.screeningKey;
    
    [self.screenings removeObjectIdenticalTo:screening];
}

//- (Screening *)createScreening
//{
//    
//}

@end
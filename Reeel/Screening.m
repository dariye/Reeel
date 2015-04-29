//
//  Screening.m
//  Reeel
//
//  Created by Paul Dariye on 4/22/15.
//  Copyright (c) 2015 colp. All rights reserved.
//

#import "Screening.h"

@implementation Screening

@synthesize screeningKey;
@synthesize screeningTitle;
@synthesize screeningDate;
@synthesize screeningLocation;
@synthesize screeningTheatre;
@synthesize dateCreated;
@synthesize screeningFee;
@synthesize screeningDescription;
@synthesize discount;
@synthesize free;
@synthesize discounted;

/*************************************************
 *           Class Method Implementations        *
 *************************************************/

/*************************************************
 *         Implementation of Initializers        *
 *************************************************/

- (instancetype)initWithScreeningTitle:(NSString *)title screeningDate:(NSString *)date screeningLocation:(NSString *)location screeningTheatre:(NSString *)theatre screeningDescription:(NSString *)description screeningFee:(float)fee discount:(float)discountValue
{
    self = [super init];
    
    if (self) {
        screeningDate = date;
        screeningLocation = location;
        screeningTheatre = theatre;
        screeningFee = fee;
        discount = discountValue;
        screeningDescription = description;
        if (screeningFee && discount) {
            discounted = YES;
            free = NO;
        } else if (fee) {
            free = NO;
            discounted = NO;
        } else {
            free = YES;
            discounted = NO;
        }
        
        // Date formatter
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
        
        dateCreated = [dateFormat stringFromDate:[[NSDate alloc] init]];
        
        // Assign unique Key
        NSUUID *uuid = [[NSUUID alloc] init];
        NSString *key = [uuid UUIDString];
        screeningKey = key;
    }
    return self;
}

- (instancetype)initWithScreeningTitle:(NSString *)title
{
    // Date formatter
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    
    return [self initWithScreeningTitle:title screeningDate:@"" screeningLocation:@"" screeningTheatre:@"" screeningDescription:@""screeningFee:0 discount:0];
}

- (instancetype)init
{
    return [self initWithScreeningTitle: @"ScreeningTitle"];
}


/*************************************************
 *         Implementation of Acessors            *
 *************************************************/

//
// - (void)setScreeningTitle:(NSString *)str
//{
//    _screeningTitle = str;
//}
//
//- (NSString *)screeningTitle
//{
//    return _screeningTitle;
//}
//
//- (void)setScreeningDate:(NSString *)str
//{
//    self.screeningDate = str;
//}


@end

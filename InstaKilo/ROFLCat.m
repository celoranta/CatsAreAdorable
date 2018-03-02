//
//  ROFLCat.m
//  InstaKilo
//
//  Created by Chris Eloranta on 2018-03-01.
//  Copyright © 2018 Christopher Eloranta. All rights reserved.
//

#import "ROFLCat.h"


@implementation ROFLCat

- (instancetype)initWithDict:(NSDictionary *)photo
{
    self = [super init];
    if (self)
    {
        NSNumber *farmID = photo[@"farm"];
        NSNumber *secret = photo[@"secret"];
        NSNumber *photoId = photo[@"id"];
        NSString *server = photo[@"server"];

        
        NSString *urlString = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg",farmID, server, photoId, secret];
        
        _url = [NSURL URLWithString:urlString];
    
        _title = photo[@"title"];
    }
    
    
    return self;
}



@end

//
//  ROFLCat.h
//  InstaKilo
//
//  Created by Chris Eloranta on 2018-03-01.
//  Copyright © 2018 Christopher Eloranta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>


@interface ROFLCat : NSObject



@property NSString *title;
@property UIImage *photo;
@property NSURL *url;

- (instancetype)initWithDict:(NSDictionary *)photo;





@end

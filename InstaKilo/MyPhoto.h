//
//  MyPhoto.h
//  InstaKilo
//
//  Created by Chris Eloranta on 2018-02-28.
//  Copyright © 2018 Christopher Eloranta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface MyPhoto : NSObject

@property (nonatomic) NSString* photoName;
@property (nonatomic) UIImage *myPhoto;
//could use latitude/long.  But not now.
@property (nonatomic) NSString *imageLocation;
//This is good, but wait for later.
//@property (nonatomic) NSSet *photoSubjects;
@property (nonatomic) NSString *imageMainSubject;

-(instancetype)initWithImageNameString:(NSString*)imageName;

-(instancetype)initWithImageNameString:(NSString*)imageName
                         imageLocation:(NSString*)imageLocation
                      imageMainSubject:(NSString*)imageMainSubject;



@end

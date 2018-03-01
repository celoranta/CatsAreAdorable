//
//  MyPhoto.m
//  InstaKilo
//
//  Created by Chris Eloranta on 2018-02-28.
//  Copyright © 2018 Christopher Eloranta. All rights reserved.
//

#import "MyPhoto.h"

@interface MyPhoto()





@end

@implementation MyPhoto

-(instancetype)initWithImageNameString:(NSString*)imageName
                         imageLocation:(NSString*)imageLocation
                      imageMainSubject:(NSString*)imageMainSubject

{
    self = [super init];
    if(self)
    {
        UIImage *image = [UIImage imageNamed:imageName];
        _myPhoto = image;
        _photoName = imageName;
        _imageLocation = imageLocation;
        _imageMainSubject = imageMainSubject;
    }
    return self;
}


-(instancetype)initWithImageNameString:(NSString*)imageName
{
    self = [self initWithImageNameString:imageName
                           imageLocation:@"<default>"
                        imageMainSubject:@"<default>"];

    return self;
}


@end

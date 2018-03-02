//
//  PhotoCollectionViewCell.m
//  InstaKilo
//
//  Created by Chris Eloranta on 2018-02-28.
//  Copyright © 2018 Christopher Eloranta. All rights reserved.
//

#import "PhotoCollectionViewCell.h"









@implementation PhotoCollectionViewCell

-(void)prepareForReuse{
    [super prepareForReuse];
    [self.downloadTask cancel];
    self.imageView.image = nil;
    
    
}

@end

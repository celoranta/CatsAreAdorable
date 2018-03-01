//
//  ViewController.h
//  InstaKilo
//
//  Created by Chris Eloranta on 2018-02-28.
//  Copyright © 2018 Christopher Eloranta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoCollectionViewCell.h"
#import "MyPhoto.h"



@interface ViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>



#pragma - mark required collectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;


@end


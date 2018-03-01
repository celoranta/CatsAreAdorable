//
//  ViewController.m
//  InstaKilo
//
//  Created by Chris Eloranta on 2018-02-28.
//  Copyright © 2018 Christopher Eloranta. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *basicPhotoCollectionView;
@property (nonatomic) UICollectionViewLayout *basicPhotoLayout;
@property (nonatomic) NSMutableArray *imageArray;
@property (nonatomic) NSMutableSet *imageLocations;
@property (nonatomic) NSMutableSet *imageMainSubjects;
@property (nonatomic) NSSet *sortingSet;
@property (nonatomic) NSString *sortingSelectorString;


@property (nonatomic) NSMutableArray *collectionViewObjectArray;
// @property (strong, nonatomic) CLE Placeholder for photoObject

@end

@implementation ViewController


#pragma mark - boilerplate ViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
#pragma mark - main code body 1
    
    
    //create photo objects (just one for now
    
    MyPhoto *myPhoto01 = [[MyPhoto alloc]initWithImageNameString:@"GwynBirthdayWhiteSpot" imageLocation:@"Port Coquitlam" imageMainSubject:@"Gwyn"];
    MyPhoto *myPhoto02 = [[MyPhoto alloc]initWithImageNameString:@"GwynInBirchwoodPontoon" imageLocation:@"Birchwood" imageMainSubject:@"Gwyn"];
    MyPhoto *myPhoto03 = [[MyPhoto alloc]initWithImageNameString:@"GwynNatAndCats"imageLocation:@"Port Coquitlam" imageMainSubject:@"Natalie"];
    MyPhoto *myPhoto04 = [[MyPhoto alloc]initWithImageNameString:@"GwynNatInNakusp" imageLocation:@"Nakusp" imageMainSubject:@"Natalie"];
    MyPhoto *myPhoto05 = [[MyPhoto alloc]initWithImageNameString:@"KatieAtHome" imageLocation:@"Port Coquitlam" imageMainSubject:@"Katie"];
    MyPhoto *myPhoto06 = [[MyPhoto alloc]initWithImageNameString:@"KatiePhotobombingSwans" imageLocation:@"Pitt Meadows" imageMainSubject:@"Katie"];
    MyPhoto *myPhoto07 = [[MyPhoto alloc]initWithImageNameString:@"NatalieGraceLookingUp" imageLocation:@"Port Coquitlam" imageMainSubject:@"Natalie"];
    MyPhoto *myPhoto08 = [[MyPhoto alloc]initWithImageNameString:@"NatInBirchwoodPontoon"imageLocation:@"Birchwood" imageMainSubject:@"Gwyn"];
    MyPhoto *myPhoto09 = [[MyPhoto alloc]initWithImageNameString:@"NatInOwenFrogging" imageLocation:@"Owen" imageMainSubject:@"Natalie"];
    MyPhoto *myPhoto10 = [[MyPhoto alloc]initWithImageNameString:@"GwynNatAndGrandparents" imageLocation:@"Port Coquitlam" imageMainSubject:@"Gwyn"];
    
    
    
    //create array of collection objects and add to a property
    self.collectionViewObjectArray = [[NSMutableArray alloc]init];
    
    
    //load array with photo objects
    [self.collectionViewObjectArray addObjectsFromArray:@[myPhoto01, myPhoto02,myPhoto03,myPhoto04,myPhoto05,myPhoto06,myPhoto07,myPhoto08,myPhoto09,myPhoto10]];
    
    
    //create a set of locations and add to a property
    self.imageLocations = [[NSMutableSet alloc]init];
    for(MyPhoto *photo in self.collectionViewObjectArray)
    {
        NSString *location = [[NSString alloc]initWithString:photo.imageLocation];
        [self.imageLocations addObject:location];
    }
    
    //create a set of main subjects and add to a property
    self.imageMainSubjects = [[NSMutableSet alloc]init];
    for(MyPhoto *photo in self.collectionViewObjectArray)
    {
        NSString *mainSubject = [[NSString alloc]initWithString:photo.imageMainSubject];
        [self.imageMainSubjects addObject:mainSubject];
    }

    
    //TEMPORARY
    //Hard code grouping category
    
    self.sortingSet = self.imageLocations;
    self.sortingSelectorString = @"imageLocation";
    
    //Assign self as collection View data source
    self.basicPhotoCollectionView.dataSource = self;
    
    //Create a layout object
    [self createAndSetupLayout];
    
    
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//declare existence of object variable


#pragma mark - required UICollectionDatasource Methods



// Separate the collection into two sections

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSInteger qtySections = [self.sortingSet count];
    return qtySections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    NSArray *tempArray = [self.sortingSet NSArray];
    
    NSInteger qtyObjectsInArray = [self.collectionViewObjectArray count];
    
    return qtyObjectsInArray;
}

//// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // Ask collection view to give us a cell that we can use to populate our data
    PhotoCollectionViewCell *cell = [self.basicPhotoCollectionView dequeueReusableCellWithReuseIdentifier:@"basicPhotoCell"
                                                                                             forIndexPath:indexPath];


    //retrieve a photo object from the array
    MyPhoto *photoObject = [self.collectionViewObjectArray objectAtIndex:indexPath.row];

     // Cell will display the Image
    [cell.imageView setImage:photoObject.myPhoto];
    
    // Text will display the name
    cell.photoTitleLabel.text = photoObject.photoName;
    
    
    

    return cell;
}
// custom CLE method: Create and configure layout

- (UICollectionViewLayout*)createAndSetupLayout
{
    self.basicPhotoLayout = [[UICollectionViewFlowLayout alloc] init];
    
//    self.basicPhotoLayout.itemSize = CGSizeMake(100, 100); // Set size of cell
//    self.basicPhotoLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);  // Padding around each section
//    self.basicPhotoLayout.minimumInteritemSpacing = 15;  // Minimum horizontal spacing between cells
//    self.basicPhotoLayout.minimumLineSpacing = 10;  // Minimum vertical spacing
    
    //    // Add this line so headers will appear. If this line is not present, headers will not appear
    //    self.simpleLayout.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 50);
    
    // By default, direction is vertical
//    self.basicPhotoLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
//    // Add this line so headers will appear. If this line is not present, headers will not appear
//    self.basicPhotoLayout.headerReferenceSize = CGSizeMake(50, self.basicPhotoCollectionView.frame.size.height);
//
//    // Add this line so footers will appear. If this line is not present, footers will not appear
//    self.basicPhotoLayout.footerReferenceSize = CGSizeMake(30, self.basicPhotoCollectionView.frame.size.height);
    
    return self.basicPhotoLayout;
}

#pragma mark - Roland's code


//    NSString *cellId = @"myCell";  // Reuse identifier
//    //    switch (indexPath.section) {
//    //        case 0:
//    //            cellId = @"myCell";
//    //            break;
//    //        case 1:
//    //            cellId = @"myWhiteCell";
//    //            break;
//    //        case 2:
//    //            cellId = @"myGreenCell";
//    //            break;
//    //        case 3:
//    //            cellId = @"myCell";
//    //            break;
//    //        case 4:
//    //        default:
//    //            cellId = @"myWhiteCell";
//    //            break;
//    //    }
//




@end

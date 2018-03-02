//
//  ViewController.m
//  InstaKilo
//
//  Created by Chris Eloranta on 2018-02-28.
//  Copyright © 2018 Christopher Eloranta. All rights reserved.
//

#import "ViewController.h"
#import "ROFLCat.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *basicPhotoCollectionView;
@property (nonatomic) UICollectionViewLayout *basicPhotoLayout;
@property (nonatomic) NSArray *photoArray;
@property (nonatomic) NSMutableArray <ROFLCat*> *arrayOfCatPhotos;
@property (nonatomic) NSMutableString *photoSearchKeyword;
//@property (nonatomic) NSMutableArray <MyPhoto*> *collectionViewObjectArray;


@end

@implementation ViewController


#pragma mark - boilerplate ViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];

#pragma mark - main code body 1
    self.photoSearchKeyword = [[NSMutableString alloc]initWithString:@"cat"];
    self.arrayOfCatPhotos = [[NSMutableArray alloc]init];
    
    NSMutableString *catsJsonURLString = [[NSMutableString alloc]initWithFormat: @"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=a456f2891dc5ef3b5b8659f67eb14840&tags=%@",self.photoSearchKeyword];

    NSURL *catsJsonURL = [NSURL URLWithString:catsJsonURLString];
    
    NSURLSessionDataTask *getCatPhotosTask = [[NSURLSession sharedSession]dataTaskWithURL:catsJsonURL
                                                                        completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                              {
                                                  NSLog(@"Fetching data from Flickr");
                                                  if (error != nil)
                                                  {
                                                      return;
                                                  }
                                                  [self parseResponseData:data];
                                              }];
    //^^^^end of NSURLSession method

    [getCatPhotosTask resume];

    self.basicPhotoCollectionView.dataSource = self;

    [self createAndSetupLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - required UICollectionDatasource Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger qtyPhotos = [self.arrayOfCatPhotos count];
    
    return qtyPhotos;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = [self.basicPhotoCollectionView dequeueReusableCellWithReuseIdentifier:@"basicPhotoCell"
                                                                                             forIndexPath:indexPath];

    ROFLCat *photoObject = [self.arrayOfCatPhotos objectAtIndex:indexPath.row];

    cell.downloadTask = [[NSURLSession sharedSession]downloadTaskWithURL:(photoObject.url) completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = image;
        });
    }];
    
    [cell.downloadTask resume];
    
    // Text will display the name
    cell.photoTitleLabel.text = photoObject.title;
    
    return cell;
}

#pragma mark - Custom methods

// custom CLE method: Create and configure layout

- (UICollectionViewLayout*)createAndSetupLayout
{
    self.basicPhotoLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //    self.basicPhotoLayout.itemSize = CGSizeMake(100, 100); // Set size of cell
//        self.basicPhotoLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);  // Padding around each section
//        self.basicPhotoLayout.minimumInteritemSpacing = 15;  // Minimum horizontal spacing between cells
//        self.basicPhotoLayout.minimumLineSpacing = 10;  // Minimum vertical spacing
//    
//        // Add this line so headers will appear. If this line is not present, headers will not appear
//        self.simpleLayout.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 50);
//    
//     By default, direction is vertical
//        self.basicPhotoLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    
//        // Add this line so headers will appear. If this line is not present, headers will not appear
//        self.basicPhotoLayout.headerReferenceSize = CGSizeMake(50, self.basicPhotoCollectionView.frame.size.height);
//
//        // Add this line so footers will appear. If this line is not present, footers will not appear
//        self.basicPhotoLayout.footerReferenceSize = CGSizeMake(30, self.basicPhotoCollectionView.frame.size.height);

    return self.basicPhotoLayout;
}

-(void)parseResponseData:(NSData*)data
{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if(error != nil)
    {
        return;
    }
    
    if([jsonObject isKindOfClass:[NSDictionary class]])
    {
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           NSDictionary *downloadedDictionary = (NSDictionary *)jsonObject;
                           NSDictionary *photoDictionary = downloadedDictionary[@"photos"];
                           NSArray *photoArray = photoDictionary[@"photo"];

                           for (NSDictionary *photo in photoArray)
                           {
                               ROFLCat *newPhotoObject = [[ROFLCat alloc]initWithDict:photo];
                               [self.arrayOfCatPhotos addObject:newPhotoObject];
                           }
                           
                           [self.basicPhotoCollectionView reloadData];
                       });
        return;
    }
}

@end

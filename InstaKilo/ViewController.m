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
//@property (nonatomic) NSMutableArray <MyPhoto*> *collectionViewObjectArray;


@end

@implementation ViewController


#pragma mark - boilerplate ViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
#pragma mark - main code body 1
    
    
    //create array of collection objects and add to a property
    self.arrayOfCatPhotos = [[NSMutableArray alloc]init];
    
    // enter the raw URL in string form for a place where lots of cute cats are
    NSString *catsJsonURLString = @"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=a456f2891dc5ef3b5b8659f67eb14840&tags=cat";
    
    // create a URL where lots of cute cats are
    NSURL *catsJsonURL = [NSURL URLWithString:catsJsonURLString];
    
    // create a data task to fetch the JSON file (of cute cats) and wrap it in a block of code to be run outside of the main thread
    NSURLSessionDataTask *getCatPhotosTask = [[NSURLSession sharedSession]dataTaskWithURL:catsJsonURL
                                                                        completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                              {
                                                  NSLog(@"Fetching data from Flickr");
                                                  if (error != nil)
                                                  {
                                                      //error processing... save for now and focus on getting cute cat photos faster
                                                      return;
                                                  }
                                                  
                                                  // Can interact with the UI to update on progress with dispatch_async(dispatch_get_main_queue() ^{ do stuff (which may or may not include cute cats) here });
                                                  
                                                  // parse the data which hopefully includes cat cuteness
                                                  
                                                  [self parseResponseData:data];
                                              }
                                              ];
    //^^^^end of NSURLSession method
    
    
    
    //Perform the NSURLSession task in another thread (as defined by the task itself)
    [getCatPhotosTask resume];
    
    //Assign self as collection View data source
    self.basicPhotoCollectionView.dataSource = self;
    
    //Will need to eventually assign self as delegate
    
    //Create a layout object
    [self createAndSetupLayout];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    // Ask collection view to give us a cell that we can use to populate our data
    PhotoCollectionViewCell *cell = [self.basicPhotoCollectionView dequeueReusableCellWithReuseIdentifier:@"basicPhotoCell"
                                                                                             forIndexPath:indexPath];
    
    
    //retrieve a photo object from the array
    ROFLCat *photoObject = [self.arrayOfCatPhotos objectAtIndex:indexPath.row];
    
    // create a data task to grab the photo from the photo object's URL and wrap it in a block of code to be run outside of the main thread
    cell.downloadTask = [[NSURLSession sharedSession]downloadTaskWithURL:(photoObject.url) completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = image;
        });
    
                                            
    }];
    
    //^^^^end of NSURLSession method
    
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

// code for parsing a json

-(void)parseResponseData:(NSData*)data
{
    
    // set up a C error type to pass into the serialization method below
    NSError *error = nil;
    
    //convert the returned NSData object (which is an untyped hunk of binary) to a JSON
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    //Check for errors in the serialized JSON file
    if(error != nil)
    {
        // Error-checking code
        //make sure any communication to the main thread is pushed there properly
        return;
    }
    
    //Let's make sure this thing is a dictionary (....as we do indeed suspect it to be.)
    
    if([jsonObject isKindOfClass:[NSDictionary class]])
    {
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           NSLog(@"Yessir, what you've got there's one o' them dandy new NSDictionaries!");
                           
                           //    NSLog(@"Here's what we got!: %@ %@",self.yayCatsRofl,jsonObject );
                           
                           
                           
                           
                           //Force cast the binary file into an NSDictionary
                           NSDictionary *downloadedDictionary = (NSDictionary *)jsonObject;
                           
                           //Create a new dictionary with the contents of the @"photos" index
                           NSDictionary *photoDictionary = downloadedDictionary[@"photos"];
                           
                           //Create a new array with the contents of the @"photo" index
                           NSArray *photoArray = photoDictionary[@"photo"];
                           
                           //For every photo listing in the Flickr data
                           for (NSDictionary *photo in photoArray)
                           {
                               
                               // Send the dictionary representing the Flickr photo obect to a new instance of ROFLCat
                               // Via an instance method which will populate its properties from the dictionary entries;
                               ROFLCat *newPhotoObject = [[ROFLCat alloc]initWithDict:photo];
                               [self.arrayOfCatPhotos addObject:newPhotoObject];
                               
                               newPhotoObject.url;
                               
                               
                           }
                           
                           [self.basicPhotoCollectionView reloadData];
                       });
        return;
    }
    
}


@end

//
//  SecondViewController.m
//  Dining@UNL
//
//  Created by Jerrad Thramer on 11/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"
#import "KeyViewController.h"


@implementation MenuViewController
@synthesize hallMenu;
@synthesize currentService;
@synthesize serviceChooser;
@synthesize helpButton;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
	[super viewDidLoad];
    NSLog(@"Menu Side Working");
    [menuView setDelegate:self];
    [menuView setDataSource:self];
    
    //Lets start figuring out what time it is.
    NSTimeInterval breakfastStart = [[[hallMenu breakfast] serviceStartTime] timeIntervalSinceNow];
    NSTimeInterval breakfastEnd = [[[hallMenu breakfast] serviceEndTime] timeIntervalSinceNow];
    NSTimeInterval lunchEnd = [[[hallMenu lunch] serviceEndTime] timeIntervalSinceNow];
    NSTimeInterval dinnerEnd = [[[hallMenu dinner] serviceEndTime] timeIntervalSinceNow];
    
    
    
    if (breakfastEnd >=0){
        currentService =@"Breakfast";
        [serviceChooser setSelectedSegmentIndex:0];
    } else if (lunchEnd >=0){
        currentService =@"Lunch";
        [serviceChooser setSelectedSegmentIndex:1];
    } else if (dinnerEnd >= 0) {
        currentService =@"Dinner";
        [serviceChooser setSelectedSegmentIndex:2]; 
    } else if (dinnerEnd <= 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hall Closed" message:@"This dining Hall has closed for the day. You may want to try another hall or check Tomorrow's Menu." delegate:self cancelButtonTitle:@"Okay." otherButtonTitles:nil];
        [alert show];  
        [alert release];
    }
    

    [self setTitle:currentService];
    serviceSelector = NSSelectorFromString([currentService lowercaseString]);
    
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return [[[hallMenu performSelector:serviceSelector] sectionArray] count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    FoodSection *currentSection = [[[hallMenu performSelector:serviceSelector] sectionArray] objectAtIndex:section];
    return [currentSection foodSectionName];
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    FoodSection *currentSection = [[[hallMenu performSelector:serviceSelector] sectionArray] objectAtIndex:section];
    return [[currentSection foodItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)theTableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    // Check for a reusable cell first, use that if it exists
    UITableViewCell *cell =
    [theTableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    
    // If there is no reusable cell of this type, create a new one
    if (!cell) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:@"MenuCell"];
    }
    
    // Set the text on the cell with the description of the possession
    // that is at the nth index of possessions, where n = row this cell
    // will appear in on the tableview
    FoodSection *s = [[[hallMenu performSelector:serviceSelector] sectionArray] objectAtIndex:[indexPath section]] ;
    FoodItem *f = [[s foodItems] objectAtIndex:[indexPath row]];
   
    int volfCount = 0;
    if ([f isVegan]) volfCount += 1;
    if ([f isOvo]) volfCount += 2;
    if ([f isLacto]) volfCount += 4;
    if ([f isFavorite]) volfCount += 8;
    
    NSString *volfString = [NSString stringWithFormat:@"%d.png", volfCount];
    
    
    UIImage *volfImage = [UIImage imageNamed:volfString];
    cell.accessoryView = [[UIImageView alloc] initWithImage:volfImage];
    
    
    
    [[cell textLabel] setText:[[f itemName] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"] ];
    
    
    
    return cell;
}

- (IBAction) serviceSelectorDidChange {
    switch (self.serviceChooser.selectedSegmentIndex) {
        case 0:
            currentService = @"Breakfast";
            break;
        case 1:
            currentService = @"Lunch";
            break;
        case 2:
            currentService = @"Dinner";
            break;
    }
    serviceSelector = NSSelectorFromString([currentService lowercaseString]);
    [self setTitle: currentService];
    NSLog(@"Current Service is Now: %@", currentService);
    
    [menuView reloadData];
    [TestFlight passCheckpoint:@"SelectedDifferentService"];
}

- (void)viewDidUnload
{
    [TestFlight passCheckpoint:@"UnloadedMenu"];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"toKey"]) {
//        KeyViewController *keyViewController = [segue destinationViewController];
//        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
//        
//       // NSLog(@"Orientation: %h", orientation);
//        if (UIInterfaceOrientationIsPortrait(orientation))
//        {
//            keyViewController.imageToLoad = [UIImage imageNamed:@"Key320.png"];   
//        }
//        else if (UIInterfaceOrientationIsLandscape(orientation))
//        {
//            keyViewController.imageToLoad = [UIImage imageNamed:@"KeyLandscape.png"]; 
//            
//        } else {
//            [NSException raise:NSInvalidArgumentException format:@"A orientation was detected that was not part of the four possible choices. This should never happen."];
//        }
//    [[keyViewController imageView] setNeedsDisplay];
        
        
        
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    // Return YES for supported orientations
   return (interfaceOrientation != (UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight));
}

@end

//
//  FirstViewController.h
//  Dining@UNL
//
//  Created by Jerrad Thramer on 11/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiningHallAPIController.h"
#import "TKCalendarMonthView.h"

@interface MasterViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, TKCalendarMonthViewDelegate, TKCalendarMonthViewDataSource>
{
    IBOutlet UITableView *tableView;
    NSMutableArray *hallList;
    DiningHallAPIController *apiController;
    ServiceDay *menuForDay;
    TKCalendarMonthView *calendar;
    NSDate *menuDate;
}
@property (nonatomic, retain) ServiceDay *menuForDay;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *hallList;
@property (nonatomic, retain) DiningHallAPIController *apiController;
@property (nonatomic, retain) TKCalendarMonthView *calendar;
@property (nonatomic, retain) NSDate *menuDate;

- (IBAction)toggleCalendar;

@end

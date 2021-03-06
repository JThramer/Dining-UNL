//
//  FoodItem.h
//  Dining@UNL
//
//  Created by Jerrad Thramer on 12/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodItem : NSObject
{
    int itemID;
    NSString *itemName;
    BOOL isVegan;
    BOOL isOvo;
    BOOL isLacto;
    BOOL isFavorite;
}
-(NSString *)description;
@property (nonatomic, retain) NSString* itemName;
@property (nonatomic, readwrite) int itemID;
@property (nonatomic, readwrite) BOOL isVegan;
@property (nonatomic, readwrite) BOOL isOvo;
@property (nonatomic, readwrite) BOOL isLacto;
@property (nonatomic, readwrite) BOOL isFavorite;
@end

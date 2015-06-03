//
//  ADMMoney.h
//  Wallet
//
//  Created by Alberto Di Martino on 6/1/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ADMMoney : NSObject

@property (copy,readonly) NSString *currency;
@property (nonatomic,strong,readonly) NSNumber* amount;

+(instancetype) dollarWithAmmount:(NSUInteger) amount;
+(instancetype) euroWithAmmount:(NSUInteger) amount;

-(id) initWithAmount:(NSUInteger)ammount currency:(NSString *) currency;
-(ADMMoney *) times:(NSUInteger) multiplier;
-(ADMMoney *) plus:(ADMMoney *) sum;

-(NSString *) currency;

@end

//
//  ADMMoney.h
//  Wallet
//
//  Created by Alberto Di Martino on 6/1/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ADMBroker;
@class ADMMoney;
@protocol ADMMoney <NSObject>

-(id) initWithAmount:(NSUInteger)ammount currency:(NSString *) currency;
-(id<ADMMoney>) times:(NSUInteger) multiplier; //returns an object that implements the ADMMoney protocol (ADMMoney or ADMWallet)
-(id<ADMMoney>) plus:(ADMMoney *) sum;
-(ADMMoney *) reduceTOCurrency:(NSString *) currency withBroker:(ADMBroker * ) broker;


@end

@interface ADMMoney : NSObject <ADMMoney>

@property (copy,readonly) NSString *currency;
@property (nonatomic,strong,readonly) NSNumber* amount;

+(instancetype) dollarWithAmmount:(NSUInteger) amount;
+(instancetype) euroWithAmmount:(NSUInteger) amount;

-(NSString *) currency;

@end


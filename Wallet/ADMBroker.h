//
//  ADMBroker.h
//  Wallet
//
//  Created by Alberto Di Martino on 6/2/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADMMoney.h"


@interface ADMBroker : NSObject

@property (strong,nonatomic) NSMutableDictionary *rates;

-(ADMMoney *) reduce:(id<ADMMoney>) money toCurrency:(NSString *) currency;
-(void) addRate:(NSUInteger) rate
   fromCurrency:(NSString *) fromCurrency
     toCurrency:(NSString *) toCurrency;
-(NSString *) keyFromCurrency:(NSString *)fromCurrency
                   toCurrency:(NSString *)toCurrency;
@end

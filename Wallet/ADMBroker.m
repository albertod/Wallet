//
//  ADMBroker.m
//  Wallet
//
//  Created by Alberto Di Martino on 6/2/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

#import "ADMBroker.h"

@interface ADMBroker ()

@end


@implementation ADMBroker


-(id) init{
    if(self = [super init]){
        _rates = [@{}mutableCopy];
    }
    return  self;
}

-(ADMMoney *) reduce:(id<ADMMoney>) money toCurrency:(NSString *) currency{
    
    //double dispatch
    return [money reduceTOCurrency:currency
                        withBroker:self];
}

-(void) addRate:(NSUInteger) rate
   fromCurrency:(NSString *) fromCurrency
     toCurrency:(NSString *) toCurrency{
    
    [self.rates setObject:@(rate)
                   forKey:[self keyFromCurrency:fromCurrency toCurrency:toCurrency]];
    //Inverse rate
    NSNumber *invRate = @(1.0/rate);
    [self.rates setObject:invRate
                   forKey:[self keyFromCurrency:toCurrency
                                                      toCurrency:fromCurrency]];
    
}

#pragma mark - Utils

-(NSString *) keyFromCurrency:(NSString *)fromCurrency
                   toCurrency:(NSString *)toCurrency{
    
    return [NSString stringWithFormat:@"%@-%@",fromCurrency,toCurrency];
}

@end

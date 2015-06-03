//
//  ADMBroker.m
//  Wallet
//
//  Created by Alberto Di Martino on 6/2/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

#import "ADMBroker.h"

@interface ADMBroker ()
@property (strong,nonatomic) NSMutableDictionary *rates;
@end


@implementation ADMBroker


-(id) init{
    if(self = [super init]){
        _rates = [@{}mutableCopy];
    }
    return  self;
}

-(ADMMoney *) reduce:(ADMMoney *) money toCurrency:(NSString *) currency{
    
    //check if the dest and source currency are the same
    ADMMoney *result;
    double rate = [[self.rates objectForKey:[self keyFromCurrency:money.currency
                                                         toCurrency:currency]] doubleValue] ;
    if([money.currency isEqualToString:currency]){
        return result = money;
    }else if(rate == 0 ){
        //there isn't a convertion rate
        [NSException raise:@"NoConvertionRateException"
                    format:@"Must have a conversion from %@ to %@",money.currency, currency];
    }else{
      
        NSInteger newAmount = [[money amount] unsignedIntegerValue] * rate;
        result = [[ADMMoney alloc]
                              initWithAmount:newAmount
                              currency:currency];
    }
    
    return result;
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

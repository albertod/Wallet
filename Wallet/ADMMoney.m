//
//  ADMMoney.m
//  Wallet
//
//  Created by Alberto Di Martino on 6/1/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

#import "ADMMoney.h"
#import "ADMBroker.h"

@interface ADMMoney ()

@end
@implementation ADMMoney

+(instancetype) dollarWithAmmount:(NSUInteger) amount{
    
    return [[ADMMoney alloc] initWithAmount:amount currency:@"USD"];
    
}

+(instancetype) euroWithAmmount:(NSUInteger)amount{
    
    return [[ADMMoney alloc] initWithAmount:amount  currency:@"EUR"];
}

-(id) initWithAmount:(NSUInteger)ammount
             currency:(NSString *) currency{
    
        if(self = [super init]){
            
            _amount = @(ammount);
            _currency = currency;
        }
        return self;
}

-(id<ADMMoney>) times:(NSUInteger)multiplier{
    
    return [[ADMMoney alloc] initWithAmount:multiplier * [self.amount unsignedIntegerValue] currency:self.currency];
            
}

-(id<ADMMoney>) plus:(ADMMoney *) sum{
    
    return [[ADMMoney alloc] initWithAmount:[self.amount doubleValue] + [sum.amount doubleValue] currency:self.currency];
}


-(BOOL) isEqual:(id)object{
    
    if([self.currency isEqual:[object currency]]){
        return [self amount] == [object amount];
    }else{
        return FALSE;
    }
}

-(ADMMoney *) reduceTOCurrency:(NSString *)currency
                    withBroker:(ADMBroker *)broker{
 
    //check if the dest and source currency are the same
    ADMMoney *result;
    double rate = [[broker.rates objectForKey:[broker
                                               keyFromCurrency:self.currency
                                                       toCurrency:currency]] doubleValue] ;
    if([self.currency isEqualToString:currency]){
        return result = self;
    }else if(rate == 0 ){
        //there isn't a convertion rate
        [NSException raise:@"NoConvertionRateException"
                    format:@"Must have a conversion from %@ to %@",self.currency, currency];
    }else{
        
        NSInteger newAmount = [[self amount] unsignedIntegerValue] * rate;
        result = [[ADMMoney alloc]
                  initWithAmount:newAmount
                  currency:currency];
    }
    
    return result;

}


#pragma mark - Overwriten

-(NSString * )description{
    
    return [NSString stringWithFormat:@"<%@ %@>",[self class],self.amount];
}

-(NSUInteger) hash{
    
    return [self.amount unsignedIntegerValue];
}


@end

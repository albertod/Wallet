//
//  ADMMoney.m
//  Wallet
//
//  Created by Alberto Di Martino on 6/1/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

#import "ADMMoney.h"

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

-(ADMMoney *) times:(NSUInteger)multiplier{
    
    return [[ADMMoney alloc] initWithAmount:multiplier * [self.amount unsignedIntegerValue] currency:self.currency];
            
}

-(ADMMoney *) plus:(ADMMoney *) sum{
    
    return [[ADMMoney alloc] initWithAmount:[self.amount unsignedIntegerValue] + [[sum amount] unsignedIntegerValue] currency:self.currency];
}


-(BOOL) isEqual:(id)object{
    
    if([self.currency isEqual:[object currency]]){
        return [self amount] == [object amount];
    }else{
        return FALSE;
    }
}


#pragma mark - Overwriten

-(NSString * )description{
    
    return [NSString stringWithFormat:@"<%@ %@>",[self class],self.amount];
}

-(NSUInteger) hash{
    
    return [self.amount unsignedIntegerValue];
}


@end

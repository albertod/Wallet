//
//  ADMWallet.m
//  Wallet
//
//  Created by Alberto Di Martino on 6/2/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

#import "ADMWallet.h"
#import "ADMBroker.h"

@interface ADMWallet ()

@property (nonatomic,strong) NSMutableArray *dollarsMoneys;
@property (nonatomic,strong) NSMutableArray *eurossMoneys;
@property (nonatomic,strong) NSMutableArray *moneys;
@property (nonatomic,strong) ADMBroker *totalBroker;


@end

@implementation ADMWallet

-(NSInteger) count{
    
    return [self.dollarsMoneys count] + [self.eurossMoneys count] + 1;
}


-(id) initWithAmount:(NSUInteger)ammount
            currency:(NSString *)currency{
    
    if(self = [super init]){
        ADMMoney *money = [[ADMMoney alloc]
                           initWithAmount:ammount currency:currency];
        _dollarsMoneys = [NSMutableArray array];
        _eurossMoneys  = [NSMutableArray array];
        _moneys = [NSMutableArray array];
        
        if([currency isEqualToString:@"USD"]){
            [_dollarsMoneys addObject:money];
        }else{
            [_eurossMoneys addObject:money];
        }
        [_moneys addObject:money];
    }
    
    return self;
}


-(id<ADMMoney>)plus:(ADMMoney *) sum{
    
    [self.moneys addObject:sum];
    if([sum.currency isEqualToString:@"USD"]){
        [self.dollarsMoneys addObject:sum];
    }else{
        [self.eurossMoneys addObject:sum];
    }
    return self;
}

-(id<ADMMoney>) times:(NSUInteger) multiplier{
    
    NSMutableArray *newMoneys = [NSMutableArray arrayWithCapacity:self.moneys.count];
    for( ADMMoney *each in self.moneys){
        ADMMoney *newMoney = [each times:multiplier];
        [newMoneys addObject:newMoney];
    }
    self.moneys = newMoneys;
    return self;
}

-(ADMMoney *) reduceTOCurrency:(NSString *)
currency withBroker:(ADMBroker * ) broker{
    
    ADMMoney *result = [[ADMMoney alloc] initWithAmount:0 currency:currency];
    
    for(ADMMoney *each in self.moneys){
        result = [result plus:[each reduceTOCurrency:currency withBroker:broker]];
        
    }
    
    return result;
}

#pragma mark - Utils

-(NSInteger) numberOfCurrencies{
    
    return 2;
}

//The slot can be 0 for dollars or 1 for Euros
-(NSInteger) numberOfMoneyPerCurrency:(NSInteger) slot{
    
    NSInteger count = 0;
    if(slot == 0){
        for(ADMMoney *each in self.moneys){
            if([each.currency isEqualToString:@"USD"])
                count++;
        }
    }else if(slot == 1){
        for(ADMMoney *each in self.moneys){
            if([each.currency isEqualToString:@"EUR"])
                count++;
        }
    }
    //We are in the total section
    else{
        return 1;
    }
    return count;
}

-(NSString *) tagByPosition:(NSInteger)section{
    
    if(section == 0){
        return @"USD";
    }else if(section == 1){
        return @"EUR";
    }else if(section == 2){
        return @"Total €";
    }
    return nil;
}

-(NSArray *)getMoneyForSection:(NSInteger)section{

    if(section == 0 ){
        return self.dollarsMoneys;
    }
    else if(section == 1){
        return self.eurossMoneys;
    }
    else if(section == 2){
        self.totalBroker = [[ADMBroker alloc] init];
        [self.totalBroker addRate:2 fromCurrency:@"EUR" toCurrency:@"USD"];
        [self.moneys insertObject:[self reduceTOCurrency:@"EUR" withBroker:self.totalBroker] atIndex:0];
        return self.moneys;
    }
    
    return nil;
}
@end

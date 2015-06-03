//
//  ADMWallet.h
//  Wallet
//
//  Created by Alberto Di Martino on 6/2/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADMMoney.h"

@interface ADMWallet : NSObject<ADMMoney>

@property (copy,readonly) NSString *currency;
@property (nonatomic,strong,readonly) NSNumber* amount;
@property (nonatomic) NSInteger count;

-(NSInteger) numberOfCurrencies;
//The slot can be 0 for dollars or 1 for Euros
-(NSInteger) numberOfMoneyPerCurrency:(NSInteger) slot;
-(NSString *) tagByPosition:(NSInteger)section;
-(NSArray *) getMoneyForSection:(NSInteger)section;

@end

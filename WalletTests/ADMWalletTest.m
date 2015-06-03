//
//  ADMWalletTest.m
//  Wallet
//
//  Created by Alberto Di Martino on 6/2/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

@import Foundation;
#import <XCTest/XCTest.h>
#import "ADMMoney.h"
#import "ADMBroker.h"
#import "ADMWallet.h"


@interface ADMWalletTest : XCTestCase

@end

@implementation ADMWalletTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


//$20 + 40 euros = $100 2:1 (dollars : euros = 2)
-(void) testAddition{
    
    ADMBroker *broker = [ADMBroker new];
    [broker addRate:2 fromCurrency:@"EUR" toCurrency:@"USD"];
    
    ADMWallet *wallet = [[ADMWallet alloc] initWithAmount:40 currency:@"EUR"];
    [wallet plus:[ADMMoney dollarWithAmmount:20]];
    
    ADMMoney *reduced = [broker reduce:wallet toCurrency:@"USD"];
    XCTAssertEqualObjects(reduced, [ADMMoney dollarWithAmmount:100],@"40 euros + 20 dollars == $100 dollars");
    
}

@end

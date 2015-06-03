//
//  ADMBrokerTest.m
//  Wallet
//
//  Created by Alberto Di Martino on 6/2/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//
@import Foundation;
#import <XCTest/XCTest.h>
#import "ADMMoney.h"
#import "ADMBroker.h"

@interface ADMBrokerTest : XCTestCase
@property (nonatomic,strong) ADMBroker *emptyBroker;
@property (nonatomic,strong) ADMMoney *oneDollar;
@end

@implementation ADMBrokerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.emptyBroker = [ADMBroker new];
    self.oneDollar = [ADMMoney dollarWithAmmount:1];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.emptyBroker = nil;
    self.oneDollar = nil;
}

-(void) testSimpleReduction{
    
    ADMBroker *broker = [[ADMBroker alloc] init];
    ADMMoney *sum = [[ADMMoney dollarWithAmmount:5]
                     plus:[ADMMoney dollarWithAmmount:5]];
    ADMMoney *reduce = [broker reduce:sum toCurrency:@"USD"];
    XCTAssertEqualObjects(sum, reduce,@"Convertion of the same currency should be NOP");
}


-(void) testThatNoRateRaisesException{
    
    XCTAssertThrows([self.emptyBroker reduce:self.oneDollar toCurrency:@"EUR"],@"Not having the rate should cause exception");
    
}

-(void) testThatNilConversitonDoesNotChangeMoney{
    
    XCTAssertEqualObjects(self.oneDollar.amount,[self.emptyBroker reduce:self.oneDollar toCurrency:@"USD"].amount,@"A nil convertion should ot have anhy effect");
}

//$10 == 5 Euros 2:1
-(void) testReduction{
    
    ADMMoney *dollars = [ADMMoney dollarWithAmmount:10];
    ADMMoney *euros = [ADMMoney euroWithAmmount:5];
    
    [self.emptyBroker addRate:2 fromCurrency:@"EUR" toCurrency:@"USD"];
    
    ADMMoney *converted = [self.emptyBroker reduce:dollars toCurrency:@"EUR"];
    
    XCTAssertEqualObjects(converted, euros,@"$10 == 5 Euros 2:1");
}
@end

//
//  ADMMoneyTest.m
//  Wallet
//
//  Created by Alberto Di Martino on 6/1/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

@import Foundation;
#import <XCTest/XCTest.h>
#import "ADMMoney.h"

@interface ADMMoneyTest : XCTestCase

@end

@implementation ADMMoneyTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


-(void) testThatTimeDoesNotRaisesException{
    
    XCTAssertNoThrow([[ADMMoney alloc] initWithAmount:10 currency:@"USD"]);
}

-(void) testCurrency{
    
    XCTAssertEqualObjects(@"USD", [[ADMMoney dollarWithAmmount:5] currency]);
    
    XCTAssertEqualObjects(@"EUR", [[ADMMoney euroWithAmmount:5] currency]);
}

-(void)testMultiplication{
    
    ADMMoney *five = [[ADMMoney alloc] initWithAmount:5 currency:@"USD"];
    ADMMoney *product = [five times:2];
    
    XCTAssertEqualObjects(product, [[ADMMoney alloc] initWithAmount:10 currency:@"USD"]);
}

- (void)testMultiplicationII{
    
    ADMMoney *five = [[ADMMoney alloc] initWithAmount:5 currency:@"EUR"];
    ADMMoney *product = [five times:2];
    XCTAssertEqualObjects(product, [[ADMMoney alloc] initWithAmount:10 currency:@"EUR"]);
}

-(void)testEquality{
    
    ADMMoney *a1 = [[ADMMoney alloc]initWithAmount:5 currency:@"EUR"];
    ADMMoney *a2 = [[ADMMoney alloc]initWithAmount:5 currency:@"EUR"];
    XCTAssertEqualObjects(a1, a2);
    //not equal objects
    ADMMoney *a3 = [[ADMMoney alloc] initWithAmount:7 currency:@"EUR"];
    XCTAssertNotEqualObjects(a1, a3);
}

-(void) testDifference{
    
    ADMMoney *a1 = [ADMMoney dollarWithAmmount:5];
    ADMMoney *a2 = [ADMMoney euroWithAmmount:5];
    
    XCTAssertNotEqualObjects(a1, a2,@"different currencies with the same ammount should be different");
}


-(void)testHash{
    
    ADMMoney *a = [ADMMoney dollarWithAmmount:5];
    ADMMoney *b = [ADMMoney dollarWithAmmount:5];
    
    XCTAssertEqual([a hash], [b hash] , @"Equal objects mush have the same Hash");
}



@end

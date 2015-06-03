//
//  ADMViewControllerTest.m
//  Wallet
//
//  Created by Alberto Di Martino on 6/3/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//
@import UIKit;
#import <XCTest/XCTest.h>
#import "ADMWalletTableViewController.h"
#import "ADMSimpleViewController.h"
#import "ADMWallet.h"

@interface ADMViewControllerTest : XCTestCase

@property (strong,nonatomic) ADMSimpleViewController *aVC;
@property (weak,nonatomic) UIButton *aButton;
@property (strong,nonatomic) UILabel *aLabel;
@property (strong,nonatomic) ADMWalletTableViewController *walletVC;
@property (strong,nonatomic) ADMWallet *wallet;
@end

@implementation ADMViewControllerTest

- (void)setUp {
    [super setUp];
    
    self.aVC = [[ADMSimpleViewController alloc] initWithNibName:nil
                                                    bundle:nil];
    self.aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.aButton.titleLabel.text = @"Touch me";
    self.aLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.aVC.aLabel = self.aLabel;
    self.aLabel.text = @"Waiting";
    
    self.wallet = [[ADMWallet alloc] initWithAmount:5 currency:@"USD"];
    self.walletVC = [[ADMWalletTableViewController alloc] initWithModel:self.wallet];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.aVC = nil;
    self.aButton = nil;
    self.aLabel = nil;
    self.wallet = nil;
    self.walletVC = nil;

}

//Test IB Action
-(void) testIBAction{
    //Create enviroment
    [self.aVC pressButton:self.aButton];
    XCTAssertEqualObjects(@"Hello", self.aLabel.text,@"should have the same text for teating purposes");
}

//test number of sections
-(void) testNumberOfSectionsCorrespondToCurrencyNumber{
    
    NSInteger numberOfCurrency = [self.wallet count];
    NSInteger numberInTable = [self.walletVC numberOfSectionsInTableView:nil];
    XCTAssertEqual(numberOfCurrency +1, numberInTable);
    XCTAssertEqual(3, [self.walletVC numberOfSectionsInTableView:nil]);
}

//Test that number of rows per sections are correct
-(void) testNumberOfCellEqualNumberOfMoneysForCurrencyPlusOne{
    
    [self.wallet plus:[ADMMoney dollarWithAmmount:5]];
    [self.wallet plus:[ADMMoney euroWithAmmount:10]];
    [self.wallet plus:[ADMMoney euroWithAmmount:8]];
    
    XCTAssertEqual(2, [self.walletVC tableView:nil numberOfRowsInSection:1]);
    XCTAssertEqual(2, [self.walletVC tableView:nil numberOfRowsInSection:0]);
    XCTAssertEqual(1, [self.walletVC tableView:nil numberOfRowsInSection:2]);
}

-(void) testGetDollarPerSection{

    [self.wallet plus:[ADMMoney dollarWithAmmount:5]];
    [self.wallet plus:[ADMMoney euroWithAmmount:3]];
    XCTAssertEqualObjects([ADMMoney euroWithAmmount:3],[[self.wallet getMoneyForSection:1] objectAtIndex:0]);
}

@end

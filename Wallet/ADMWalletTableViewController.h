//
//  ADMWalletTableViewController.h
//  Wallet
//
//  Created by Alberto Di Martino on 6/3/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADMWallet.h"

@interface ADMWalletTableViewController : UITableViewController

-(id) initWithModel:(ADMWallet *) model;

@end

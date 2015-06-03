//
//  AppDelegate.m
//  Wallet
//
//  Created by Alberto Di Martino on 6/1/15.
//  Copyright (c) 2015 DiMartino. All rights reserved.
//

#import "AppDelegate.h"
#import "ADMMoney.h"
#import "ADMWalletTableViewController.h"
#import "ADMMoney.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    ADMWallet *model = [[ADMWallet alloc] initWithAmount:10 currency:@"USD"];
    [model plus:[ADMMoney euroWithAmmount:15]];
    
    ADMWalletTableViewController *walletVC = [[ADMWalletTableViewController alloc] initWithModel:model];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:walletVC];
    //Add some currencies to the model
    [self addCurrency:model];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.rootViewController = navVC;
    [self.window makeKeyAndVisible];
    return YES;
    
    return nil;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void) addCurrency:(ADMWallet *)model{
    [model plus:[ADMMoney dollarWithAmmount:5]];
    [model plus:[ADMMoney dollarWithAmmount:8]];
    [model plus:[ADMMoney euroWithAmmount:8]];
    
    [model plus:[ADMMoney dollarWithAmmount:15]];
    [model plus:[ADMMoney euroWithAmmount:42]];
    [model plus:[ADMMoney euroWithAmmount:850]];
}

@end

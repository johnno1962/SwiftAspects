//
//  AppDelegate.swift
//  SwiftAspects
//
//  Created by John Holdsworth on 21/06/2014.
//  Copyright (c) 2014 John Holdsworth. All rights reserved.
//

import UIKit
import CoreData

class S000 {
    var i: Int?
    var k = 1
    var l = 8.0
    func j() {
    }
}

class S111 : S000 {

    func a0(i:Int?, j:Int) {
        println( "S111.a0: \(i!) \(j)" );
    }
    func a1(i:Int?, j:Int) -> Int {
        println( "S111.a1: \(i!) \(j)" );
        return 99
    }
    func a2(i:Int?, j:Int) -> CGRect {
        println( "S111.a2: \(i!) \(j)" );
        return CGRectMake(1, 2, 3, 4)
    }
    func a3(i:Int?, j:Int) -> CGPoint {
        println( "S111.a3: \(i!) \(j)" )
        return CGPointMake(10, 20)
    }
    func a(i:Int, jsel j:Int, ksel:Int, lsel:Int, msel:Int, v:UIView?) -> Int {
        println( "S111.a: \(msel)" )
        return 66;
    }
    func b(i:Int?, jsel j:Int?, ksel:Int, lsel:Int, msel:Int, s:S111!) -> Int? {
        println( "S111.c: \(msel)" )
        return i;
    }
    func c(f:Float?, jsel j:Int?, ksel:Int, lsel:Int, msel:Int, s:S111!) -> Float? {
        println( "S111.b \(msel)" )
        return f;
    }
    func d(f:Float?, lsel:CGRect, jsel j:Int?, ksel:Int, msel:Int, s:S111) -> S111? {
        println( "S111.d \(lsel) \(msel)" )
        return s;
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?
    var s: S111 = S111()

    func takesAConstPointer(x: UnsafePointer<Float>) { /*...*/ }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.endIndex-1] as! UINavigationController
        splitViewController.delegate = navigationController.topViewController as! DetailViewController

        let masterNavigationController = splitViewController.viewControllers[0] as! UINavigationController
        let controller = masterNavigationController.topViewController as! MasterViewController
        controller.managedObjectContext = self.managedObjectContext

        //controller.xtrace()
        //controller.john2(88, i2:99)

        //self.xtrace()
        //john(88, i2:99);

        Xtrace.traceInstance(s)

        Xtrace.forSwiftClass(object_getClass(s), before:"a0:j:", callbackBlock:blockConvert({
            (obj:AnyObject?, sel:Selector, i1:CInt, _i1:CInt, i2:CInt) in
            println( "Before.a0 \(i1) \(i2)" )
            }))

        Xtrace.forSwiftClass(object_getClass(s), after:"a1:j:", callbackBlock:blockConvertOpt({
            (obj:AnyObject?, sel:Selector, out:CInt, i1:CInt, _i1:CInt, i2:CInt) in
            println( "After.a1 \(i1) \(i2)" )
            return i1+i2
            }))

        Xtrace.forSwiftClass(object_getClass(s), before:"a2:j:", callbackBlock:blockConvert({
            (obj:AnyObject?, sel:Selector, i1:CInt, _i1:CInt, i2:CInt) in
            println( "Before.a2 \(i1) \(i2)" )
        }))

        Xtrace.forSwiftClass(object_getClass(s), after:"a2:j:", callbackBlock:blockConvertRect({
            (obj:AnyObject?, sel:Selector, out1:CGRect, i1:CInt, _i1:CInt, i22:CInt) in
            println( "After.a2 \(i1) \(i22)" )
            var a = out1
            a.origin.x = 101
            return a
        }))

        s.a0(88, j:99)
        println( "AppDelegate.a1: \(s.a1(1,j:2))" )

        let r = s.a2(1, j: 22)
        println( "AppDelegate.origin.x: \(r.origin.x)" )
        println( "AppDelegate.origin.y: \(r.origin.y)" )

        Xtrace.forSwiftClass(object_getClass(s), after:"a3:j:", callbackBlock:blockConvertPoint({
            (obj:AnyObject?, sel:Selector, out1:CGPoint, i1:CInt, _i1:CInt, i22:CInt) in
            println( "After.a3 \(i1) \(i22)" )
            var a = out1
            a.x = 101
            return a
        }))

        let p = s.a3(1, j: 2)
        println( "AppDelegate.x: \(p.x)" )

        var j: Int? = 888
        var f: Float? = 1234

        println( "AppDelegate.a: \(s.a(99, jsel: 99, ksel: 99, lsel: 99, msel: 999, v: masterNavigationController.viewControllers[0].view))" );
        println( "AppDelegate.b: \(s.b(99, jsel: j, ksel: 99, lsel: 99, msel: 999, s: s)!)");
        println( "AppDelegate.c: \(s.c(f, jsel: j, ksel: 99, lsel: 99, msel: 999, s: s)!)");

        s.d(f, lsel: r, jsel: j, ksel: 99, msel: 999, s: s)?.d(f, lsel: r, jsel: j, ksel: 99, msel: 999, s: s)

        return true
    }

    func john(i1:Int, i2:Int) {
        NSLog( "john: %d %d", i1, i2);
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    func saveContext () {
        var error: NSError? = nil
        let managedObjectContext = self.managedObjectContext
        if managedObjectContext != nil {
            if managedObjectContext.hasChanges && !managedObjectContext.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                //println("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
        }
    }

    // #pragma mark - Core Data stack

    // Returns the managed object context for the application.
    // If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
    var managedObjectContext: NSManagedObjectContext! {
        if _managedObjectContext == nil {
            let coordinator = self.persistentStoreCoordinator
            if coordinator != nil {
                _managedObjectContext = NSManagedObjectContext()
                _managedObjectContext!.persistentStoreCoordinator = coordinator
            }
        }
        return _managedObjectContext
    }
    var _managedObjectContext: NSManagedObjectContext? = nil

    // Returns the managed object model for the application.
    // If the model doesn't already exist, it is created from the application's model.
    var managedObjectModel: NSManagedObjectModel {
        if _managedObjectModel == nil {
            let modelURL = NSBundle.mainBundle().URLForResource("SwiftAspects", withExtension: "momd")
            _managedObjectModel = NSManagedObjectModel(contentsOfURL: modelURL!)
        }
        return _managedObjectModel!
    }
    var _managedObjectModel: NSManagedObjectModel? = nil

    // Returns the persistent store coordinator for the application.
    // If the coordinator doesn't already exist, it is created and the application's store added to it.
    var persistentStoreCoordinator: NSPersistentStoreCoordinator! {
        if _persistentStoreCoordinator == nil {
            let storeURL = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SwiftAspects.sqlite")
            var error: NSError? = nil
            _persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
            if _persistentStoreCoordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil, error: &error) == nil {
                /*
                Replace this implementation with code to handle the error appropriately.

                abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                Typical reasons for an error here include:
                * The persistent store is not accessible;
                * The schema for the persistent store is incompatible with current managed object model.
                Check the error message to determine what the actual problem was.


                If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.

                If you encounter schema incompatibility errors during development, you can reduce their frequency by:
                * Simply deleting the existing store:
                NSFileManager.defaultManager().removeItemAtURL(storeURL, error: nil)

                * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
                [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true}

                Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.

                */
                //println("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
        }
        return _persistentStoreCoordinator
    }
    var _persistentStoreCoordinator: NSPersistentStoreCoordinator? = nil

    // #pragma mark - Application's Documents directory
                                    
    // Returns the URL to the application's Documents directory.
    var applicationDocumentsDirectory: NSURL {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.endIndex-1] as! NSURL
    }

}


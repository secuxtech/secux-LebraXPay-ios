//
//  AppDelegate.swift
//  LibraXPay
//
//  Created by maochun on 2020/8/12.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit
import Network

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let internetMonitor = NWPathMonitor()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //DispatchQueue.global().async {
        //    self.checkStoreVersion()
        //}
        
        Thread.sleep(forTimeInterval: 1.0)
        
        //UIApplication.shared.setMinimumBackgroundFetchInterval(3600 * 5) //UIApplication.backgroundFetchIntervalMinimum)
        self.startMonitorNetwork()
        
        let rootVC = LoginAndRegisterViewController()
        self.window?.rootViewController = rootVC
        

        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    func application(_ application: UIApplication,
                     performFetchWithCompletionHandler completionHandler:
                     @escaping (UIBackgroundFetchResult) -> Void) {
       // Check for new data.
       
        /*
        
        fetchUpdates(){ (newData,error) in
            
            if let err = error {
                print("Background fetch error: \(err.localizedDescription)")
                completionHandler(.failed)
            } else {
                completionHandler(newData ? .newData:.noData)
            }
        }
        */
    }

    /*
    func fetchUpdates(completion: ((Bool,Error?) -> Void)? = nil) {

        guard let url = URL(string: "...") else {
            completion?(false, nil)
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, err) in

            guard nil == err else {
                completion?(false, err)
                return
            }

            guard let data = data else {
                completion?(false, nil)
                return
            }

            do {
                let downloadedCurrencies = try JSONDecoder().decode([Currency].self, from: data)

                // Adding downloaded data into Local Array
                Currencies = downloadedCurrencies
                completion?(true,nil)
    
            } catch let jsonErr {
                print("Error serializing json", jsonErr)
                completion?(false,jsonErr)
            }

        }.resume()
    }
    */
    
    func startMonitorNetwork(){
        logw("startMonitorNetwork")
        
        internetMonitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                
                logw("Internet connection is on.")
                Setting.shared.hasInternet.value = true
               
                
            } else {
                
              
                logw("No internet connection")
                Setting.shared.hasInternet.value = false
                    
            }
        }
        
        internetMonitor.start(queue: DispatchQueue.global())
    }
    
    

}


//
//  FirstLaunch.swift
//  SmartChef
//
//  Created by Tim Mathis on 25.12.17.
//  Copyright © 2017 hskl. All rights reserved.
//

import Foundation

final class FirstLaunch {
    let wasLaunchedBefore : Bool
    var isFirstLaunch: Bool {
        return !wasLaunchedBefore
    }
    
    init(getWasLaunchedBefore: () -> Bool,
         setWasLaunchedBefore: (Bool) -> ()) {
        let wasLaunchedBefore = getWasLaunchedBefore()
        self.wasLaunchedBefore = wasLaunchedBefore
        if !wasLaunchedBefore {
            setWasLaunchedBefore(true)
        }
    }
    
    convenience init(userDefaults : UserDefaults, key : String) {
        self.init(getWasLaunchedBefore : {
            userDefaults.bool(forKey: key) },
            setWasLaunchedBefore: { userDefaults.set($0, forKey: key)
        })
    }
}

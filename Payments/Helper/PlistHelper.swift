//
//  PlistHelper.swift
//  Payments
//
//  Created by Alejandro Villalobos on 01-04-23.
//

import Foundation

class PlistHelper {
    class func value(forKey key: String, fromPlist plistName: String) -> String? {
        guard let plistPath = Bundle.main.path(forResource: plistName, ofType: "plist"),
              let plistDict = NSDictionary(contentsOfFile: plistPath) else { return nil }
        
        return plistDict[key] as? String
    }
}

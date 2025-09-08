//
//  BundleEx.swift
//  LMD
//
//  Created by Naif on 16/03/1447 AH.
//

import Foundation
import ObjectiveC.runtime

private class BundleEx: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        if let lang = UserDefaults.standard.string(forKey: "appLanguage"),
           let path = Bundle.main.path(forResource: lang, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: key, value: value, table: tableName)
        }
        return super.localizedString(forKey: key, value: value, table: tableName)
    }
}

extension Bundle {
    static func overrideLocalization() {
        object_setClass(Bundle.main, BundleEx.self)
    }
}

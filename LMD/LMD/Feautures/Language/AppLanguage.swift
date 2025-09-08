//
//  AppLanguage.swift
//  LMD
//
//  Created by Naif on 16/03/1447 AH.
//

import Foundation

enum AppLanguage: String, CaseIterable {
    case english = "en"
    case arabic  = "ar"

    var displayName: String {
        switch self {
        case .english: return "English"
        case .arabic:  return "العربية"
        }
    }
}

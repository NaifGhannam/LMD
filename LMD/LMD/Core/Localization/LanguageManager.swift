//
//  LanguageManager.swift
//  LMD
//
//  Created by Naif on 16/03/1447 AH.
//


import Foundation
import SwiftUI
import UIKit

final class LanguageManager: ObservableObject {
    @Published var currentLanguage: AppLanguage {
        didSet {
            UserDefaults.standard.set(currentLanguage.rawValue, forKey: "appLanguage")
            Bundle.overrideLocalization()
            UIView.appearance().semanticContentAttribute = currentLanguage == .arabic ? .forceRightToLeft : .forceLeftToRight
        }
    }

    init() {
        let saved = UserDefaults.standard.string(forKey: "appLanguage")
        let langCode = saved ?? Locale.current.languageCode ?? "en"
        self.currentLanguage = AppLanguage(rawValue: langCode) ?? .english

        Bundle.overrideLocalization()
        UIView.appearance().semanticContentAttribute = currentLanguage == .arabic ? .forceRightToLeft : .forceLeftToRight
    }

    func setLanguage(_ language: AppLanguage) {
        withAnimation {
            self.currentLanguage = language
        }
    }
}

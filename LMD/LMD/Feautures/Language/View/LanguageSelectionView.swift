//
//  LanguageSelectionView.swift
//  LMD
//
//  Created by Naif on 16/03/1447 AH.
import SwiftUI

struct LanguageSelectionView: View {
    @EnvironmentObject var languageManager: LanguageManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        List {
            ForEach(AppLanguage.allCases, id: \.self) { lang in
                Button(action: {
                    languageManager.setLanguage(lang)
                }) {
                    HStack {
                        Text(NSLocalizedString("language_\(lang.rawValue)", comment: ""))
                        Spacer()
                        if languageManager.currentLanguage == lang {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle(NSLocalizedString("change_language", comment: ""))
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.red, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        LanguageSelectionView()
            .environmentObject(LanguageManager())
    }
}

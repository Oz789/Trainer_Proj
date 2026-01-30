//
//  SettingsRow.swift
//  Trainer
//
//  Created by Osvaldo Mosso on 1/29/26.
//


import SwiftUI

struct SettingsRow: View {
    let title: String
    var value: String? = nil

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            if let value {
                Text(value)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

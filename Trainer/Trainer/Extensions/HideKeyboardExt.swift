//
//  HideKeyboardExt.swift
//  Trainer
//
//  Created by Osvaldo Mosso on 1/27/26.
//

import SwiftUI

extension View {
    func hideKeyboardOnTap() -> some View {
        onTapGesture {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil, from: nil, for: nil
            )
        }
    }
}

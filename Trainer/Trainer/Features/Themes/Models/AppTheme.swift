//
//  AppTheme.swift
//  Trainer
//
//  Created by Osvaldo Mosso on 1/26/26.
//


import SwiftUI

protocol AppTheme {
    var id: String { get }
    var displayName: String { get }

    // Background
    var backgroundGradient: [Color] { get }

    // Text
    var titleColor: Color { get }
    var textPrimary: Color { get }
    var textSecondary: Color { get }

    // Segmented
    var segmentedTint: Color { get }
    var segmentedBackground: Color { get }

    // Fields
    var fieldFill: Color { get }
    var fieldStroke: Color { get }

    // CTA
    var ctaGradient: [Color] { get }
}

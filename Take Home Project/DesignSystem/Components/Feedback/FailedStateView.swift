//
//  FailedStateView.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI

struct FailedStateView: View {
    let error: Error
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .frame(width: 36, height: 36)
                .foregroundStyle(Color.colorError)

            Text(errorTitle)
                .font(.appTitle)
                .foregroundStyle(Color.labelPrimary)
                .multilineTextAlignment(.center)

            Text(errorMessage)
                .font(.bodyPrimary)
                .foregroundStyle(Color.labelSecondary)
                .multilineTextAlignment(.center)

            Button(action: onRetry) {
                Text(String(localized: "error_retry"))
                    .font(.buttonLabel)
                    .foregroundStyle(Color.labelOnSolid)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.ctaSolidBackground, in: Capsule())
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 24)
    }

    private var errorTitle: String {
        localizedError?.errorDescription ?? String(localized: "app_error_unknown")
    }

    private var errorMessage: String {
        localizedError?.recoverySuggestion ?? String(localized: "app_error_recovery_suggestion")
    }

    private var localizedError: LocalizedError? {
        error as? LocalizedError
    }
}

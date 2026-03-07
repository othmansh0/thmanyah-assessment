//
//  View+ErrorAlert.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI

private struct LocalizedAlertError: LocalizedError {
    let underlyingError: Error

    var errorDescription: String? {
        localizedError?.errorDescription ?? underlyingError.localizedDescription
    }

    var recoverySuggestion: String? {
        localizedError?.recoverySuggestion
    }

    private var localizedError: LocalizedError? {
        underlyingError as? LocalizedError
    }

    init?(error: Error?) {
        guard let error else { return nil }
        self.underlyingError = error
    }
}

extension View {
    func errorAlert(error: Binding<Error?>, buttonTitle: String? = nil) -> some View {
        let localizedError = LocalizedAlertError(error: error.wrappedValue)
        let isPresented = Binding(
            get: { localizedError != nil },
            set: { isPresented in
                if !isPresented {
                    error.wrappedValue = nil
                }
            }
        )

        return alert(
            isPresented: isPresented,
            error: localizedError
        ) { _ in
            Button(buttonTitle ?? String(localized: "error_alert_ok")) {
                error.wrappedValue = nil
            }
        } message: { localizedError in
            Text(localizedError.recoverySuggestion ?? String(localized: "app_error_recovery_suggestion"))
        }
    }
}

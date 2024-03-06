//
//  SignInWithAppleView.swift
//  CleanSteps
//
//  Created by Hugh on 3/6/24.
//

import SwiftUI
import AuthenticationServices

struct SignInWithAppleView: View {
    var body: some View {
        VStack {
            Text("Welcome to CleanSteps!")
                .font(.title)
                .padding()
            
            SignInWithAppleButton(
                onRequest: { request in
                    request.requestedScopes = [.fullName, .email]
                },
                onCompletion: { result in
                    switch result {
                    case .success(let authResults):
                        // Handle successful authentication
                        print("Successfully authenticated with Apple ID: \(authResults)")
                    case .failure(let error):
                        // Handle authentication failure
                        print("Failed to authenticate with Apple ID: \(error)")
                    }
                }
            )
            .signInWithAppleButtonStyle(.black)
            .frame(width: 200, height: 50)
            .padding()
        }
    }
}

#Preview {
    SignInWithAppleView()
}

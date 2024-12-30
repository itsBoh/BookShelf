//
//  LogInView.swift
//  BookShelf
//
//  Created by Alvin Lionel on 30/12/24.
//

import SwiftUI

struct LogInView: View {
    
    @Binding var user: String
    @Binding var accountUserName: String
    @Binding var sessionKey: String
    
    @Environment(\.dismiss) var dismiss
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    @StateObject private var viewModel = LoginViewModel()
    @State private var loginError: String?
    
    var body: some View {
        NavigationStack {
            Form {
                HStack {
                    Text("Username")
                    Spacer()
                    TextField("Enter username", text: $username)
                        .multilineTextAlignment(.trailing)
                        .textInputAutocapitalization(.never)
                }
                
                HStack {
                    Text("Password")
                    Spacer()
                    SecureField("Enter your password", text: $password)
                        .multilineTextAlignment(.trailing)
                        .textInputAutocapitalization(.never)
                }
                
                if let loginError = loginError {
                    Text(loginError)
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("LogIn")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        viewModel.loginCheck(username: username, password: password) { result in
                            switch result {
                            case .success:
                                dismiss()
                            case .failure(let error):
                                loginError = error.localizedDescription
                            }
                        }
                    }
                    .disabled(username.isEmpty || password.isEmpty)
                }
            }
            .onDisappear {
                accountUserName = viewModel.accountUserName
                sessionKey = viewModel.accountSessionKey
                user = viewModel.databaseUserName
            }
        }
    }
}

//
//  CreateUserAccountView.swift
//  BookShelf
//
//  Created by Alvin Lionel on 30/12/24.
//

import SwiftUI

struct CreateUserAccountView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var phoneNumber: String = ""
    @State private var password: String = ""
    
    @StateObject private var viewModel = CreateUserAccountViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section (header: Text("Personal Information")) {
                    HStack {
                        Text("Name")
                        Spacer()
                        TextField("Enter your name", text: $name)
                            .textInputAutocapitalization(.never)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Username")
                        Spacer()
                        TextField("Enter username", text: $username)
                            .textInputAutocapitalization(.never)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Phone number")
                        Spacer()
                        TextField("Enter phone number", text: $phoneNumber)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Password")
                        Spacer()
                        SecureField("Enter your password", text: $password)
                            .textInputAutocapitalization(.never)
                            .multilineTextAlignment(.trailing)
                    }
                
                }
                
                
            }
            .navigationTitle("Sign Up")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        viewModel.createUserAccount(name: name, username: username, phoneNumber: phoneNumber, password: password)
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                }
            }
            .alert(item: $viewModel.errorMessage) { error in
                Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
            }
            .onChange(of: viewModel.isUserCreated) { oldValue, isUserCreated in
                if isUserCreated {
                    dismiss()
                }
            }
        }
    }
}

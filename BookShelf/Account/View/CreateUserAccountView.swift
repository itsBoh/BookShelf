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
    
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section (header: Text("Personal Information")) {
                    HStack {
                        Text("Name")
                        Spacer()
                        TextField("Enter your name", text: $name)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Username")
                        Spacer()
                        TextField("Enter username", text: $username)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Phone number")
                        Spacer()
                        TextField("Enter phone number", text: $username)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Password")
                        Spacer()
                        SecureField("Enter your password", text: $password)
                            .multilineTextAlignment(.trailing)
                    }
                
                }
                
                
            }
            .navigationTitle("Sign Up")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        print("add button pressed")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    CreateUserAccountView()
}

//
//  LoginViewModel.swift
//  BookShelf
//
//  Created by Alvin Lionel on 30/12/24.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    func login() {
        
        let isValidUser = (userName == "testUser" && password == "testPassword")
        
        if isValidUser {
            self.isLoggedIn = true
            self.errorMessage = nil
        } else {
            self.errorMessage = "Invalid username or password"
        }
    }
}

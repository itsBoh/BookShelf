//
//  CreateUserAccountViewModel.swift
//  BookShelf
//
//  Created by Alvin Lionel on 30/12/24.
//

import Foundation
import Combine
import MySQLNIO
import NIO

class CreateUserAccountViewModel: ObservableObject {
    @Published var errorMessage: IdentifiableError?
    @Published var isUserCreated: Bool = false

    func createUserAccount(name: String, username: String, phoneNumber: String, password: String) {
        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        
        do {
            var tlsConfiguration = TLSConfiguration.makeClientConfiguration()
            tlsConfiguration.certificateVerification = .none
            
            let connection = try MySQLConnection.connect(
                to: .init(ipAddress: "127.0.0.1", port: 3306),
                username: UserDefaults.standard.string(forKey: "userName") ?? "book_reader",
                database: "bookshelf",
                password: UserDefaults.standard.string(forKey: "password") ?? "",
                tlsConfiguration: tlsConfiguration,
                on: eventLoopGroup.next()
            ).wait()
            
            defer {
                try? connection.close().wait()
                try? eventLoopGroup.syncShutdownGracefully()
            }
            
            let accountType = "User"
            let insertUserQuery = """
            INSERT INTO accounts (accountUserName, accountName, accountType, accountPassword, accountPhoneNumber)
            VALUES ('\(username)', '\(name)', '\(accountType)', '\(password)', '\(phoneNumber)')
            """
            print("Executing query: \(insertUserQuery)")
            _ = try connection.query(insertUserQuery).wait()
            
            print("User account created successfully")
            isUserCreated = true
            
        } catch {
            print("Error: \(error.localizedDescription)")
            self.errorMessage = IdentifiableError(message: error.localizedDescription)
        }
    }
}

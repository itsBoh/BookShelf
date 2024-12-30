//
//  LoginViewModel.swift
//  BookShelf
//
//  Created by Alvin Lionel on 30/12/24.
//

import Foundation
import Combine
import MySQLNIO
import NIO

class LoginViewModel: ObservableObject {
    @Published var userName: String = ""
    @Published var password: String = ""
    
    @Published var accountUserName: String = ""
    @Published var accountSessionKey: String = ""
    @Published var databaseUserName: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    func loginCheck(username: String, password: String, completion: @escaping (Result<[String: String], Error>) -> Void) {
        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        
        do {
            var tlsConfiguration = TLSConfiguration.makeClientConfiguration()
            tlsConfiguration.certificateVerification = .none
            
            let connection = try MySQLConnection.connect(
                to: .init(ipAddress: "127.0.0.1", port: 3306),
                username: "book_reader",
                database: "bookshelf",
                password: "password",
                tlsConfiguration: tlsConfiguration,
                on: eventLoopGroup.next()
            ).wait()
            
            defer {
                try? connection.close().wait()
                try? eventLoopGroup.syncShutdownGracefully()
            }
            
            let query = "CALL login_check('\(username)', '\(password)', @out_userName, @out_password, @out_sessionKey)"
            print("Executing query: \(query)")
            
            _ = try connection.query(query).wait()
            
            let resultQuery = "SELECT @out_userName AS userName, @out_password AS password, @out_sessionKey AS sessionKey"
            let rows = try connection.query(resultQuery).wait()
            print("Query result: \(rows)")
            
            if let row = rows.first {
                let userName = row.column("userName")?.string ?? ""
                let password = row.column("password")?.string ?? ""
                let sessionKey = row.column("sessionKey")?.string ?? ""
                
                let result = ["userName": userName, "password": password, "sessionKey": sessionKey]
                completion(.success(result))
                
                UserDefaults.standard.set(userName, forKey: "userName")
                UserDefaults.standard.set(password, forKey: "password")
                UserDefaults.standard.set(sessionKey, forKey: "sessionKey")
                
                self.accountUserName = username
                self.accountSessionKey = sessionKey
                self.databaseUserName = userName
                
                print("viewModel login: \(databaseUserName)")
                
                print(userName)
                print(password)
                print(sessionKey)
            } else {
                completion(.failure(NSError(domain: "No rows returned", code: 2, userInfo: nil)))
            }
        } catch {
            completion(.failure(error))
        }
    }
}

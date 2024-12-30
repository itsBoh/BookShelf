//
//  BookDetailViewModel.swift
//  BookShelf
//
//  Created by Alvin Lionel on 30/12/24.
//

//
//  BookDetailViewModel.swift
//  BookShelf
//
//  Created by Alvin Lionel on 30/12/24.
//

import Foundation
import Combine
import MySQLNIO
import NIO

class BookDetailViewModel: ObservableObject {
    @Published var errorMessage: IdentifiableError?
    @Published var isBorrowed: Bool = false

    func borrowBook(book: Book, accountUserName: String) {
        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        
        do {
            var tlsConfiguration = TLSConfiguration.makeClientConfiguration()
            tlsConfiguration.certificateVerification = .none
            
            let connection = try MySQLConnection.connect(
                to: .init(ipAddress: "127.0.0.1", port: 3306),
                username: UserDefaults.standard.string(forKey: "userName") ?? "",
                database: "bookshelf",
                password: UserDefaults.standard.string(forKey: "password") ?? "",
                tlsConfiguration: tlsConfiguration,
                on: eventLoopGroup.next()
            ).wait()
            
            defer {
                try? connection.close().wait()
                try? eventLoopGroup.syncShutdownGracefully()
            }
            
            // Fetch accountID based on accountUserName
            let fetchAccountIDQuery = "SELECT accountID FROM accounts WHERE accountUserName = '\(accountUserName)'"
            
            print("Executing query: \(fetchAccountIDQuery)")
            
            let rows = try connection.query(fetchAccountIDQuery).wait()
            
            guard let accountID = rows.first?.column("accountID")?.string else {
                print("Error: accountID not found for accountUserName: \(accountUserName)")
                self.errorMessage = IdentifiableError(message: "Account ID not found.")
                return
            }
            
            let insertLoanQuery = """
            INSERT INTO loans (accountID, bookID, loanDate, loanDueDate)
            VALUES ('\(accountID)', '\(book.id)', NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY))
            """
            print("Executing query: \(insertLoanQuery)")
            _ = try connection.query(insertLoanQuery).wait()
            
            let updateBookQuery = "UPDATE books SET bookAvailableCopies = bookAvailableCopies - 1 WHERE bookID = '\(book.id)'"
            print("Executing query: \(updateBookQuery)")
            _ = try connection.query(updateBookQuery).wait()
            
            print("Queries executed successfully")
            isBorrowed = true
            
        } catch {
            print("Error: \(error.localizedDescription)")
            self.errorMessage = IdentifiableError(message: error.localizedDescription)
        }
    }
}

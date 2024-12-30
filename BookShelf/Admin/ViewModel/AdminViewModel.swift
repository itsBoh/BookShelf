//
//  AdminViewModel.swift
//  BookShelf
//
//  Created by Alvin Lionel on 30/12/24.
//

import Foundation
import Combine
import MySQLNIO
import NIO

class AdminViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var loans: [Loan] = []
    @Published var filteredBooks: [Book] = []
    @Published var errorMessage: IdentifiableError?
    
    @Published var searchQuery: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchBooksAndLoans() {
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
            
            let rows = try connection.query("SELECT bookID, bookTitle, bookAuthor, bookDescription, bookPublisher, bookPublished, bookAvailableCopies, bookCoverImage FROM books WHERE isDeleted = 0").wait()
            self.books = rows.map { row in
                let id = row.column("bookID")?.string ?? ""
                let title = row.column("bookTitle")?.string ?? ""
                let author = row.column("bookAuthor")?.string ?? ""
                let description = row.column("bookDescription")?.string ?? ""
                let publisher = row.column("bookPublisher")?.string ?? ""
                let published = row.column("bookPublished")?.int ?? 0
                let availableCopies = row.column("bookAvailableCopies")?.int ?? 0
                let coverImage = row.column("bookCoverImage")?.string ?? ""
                return Book(id: id, title: title, author: author, description: description, publisher: publisher, published: published, coverImage: coverImage, availableCopies: availableCopies)
            }
            
            filteredBooks = books
            
            let loansQuery = """
            SELECT loans.loanID, loans.bookID, loans.accountID, accounts.accountUserName
            FROM loans
            JOIN accounts ON loans.accountID = accounts.accountID
            """
            let loansRows = try connection.query(loansQuery).wait()
            self.loans = loansRows.map { row in
                Loan(
                    id: row.column("loanID")?.string ?? "",
                    bookID: row.column("bookID")?.string ?? "",
                    accountID: row.column("accountID")?.string ?? "",
                    accountUserName: row.column("accountUserName")?.string ?? ""
                )
            }
            
        } catch {
            self.errorMessage = IdentifiableError(message: error.localizedDescription)
        }
    }
    
    func softDeleteBook(bookId: String) {
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
            
            let query = "UPDATE books SET isDeleted = 1 WHERE bookID = '\(bookId)'"
            _ = try connection.query(query).wait()
            
            // Refresh the books list
            fetchBooksAndLoans()
        } catch {
            self.errorMessage = IdentifiableError(message: error.localizedDescription)
        }
    }
    
    func updateBook(book: Book) {
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
            
            let query = """
                UPDATE books
                SET bookTitle = '\(book.title)', bookAuthor = '\(book.author)', bookDescription = '\(book.description)', bookPublisher = '\(book.publisher)', bookPublished = \(book.published), bookCoverImage = '\(book.coverImage)', bookAvailableCopies = \(book.availableCopies)
                WHERE bookID = '\(book.id)'
                """
            _ = try connection.query(query).wait()
            
            fetchBooksAndLoans()
            filteredBooks = books
        } catch {
            self.errorMessage = IdentifiableError(message: error.localizedDescription)
        }
    }
    
    func addBook(book: Book) {
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
                
                let query = """
                    INSERT INTO books (bookTitle, bookAuthor, bookDescription, bookPublisher, bookPublished, bookCoverImage, bookAvailableCopies)
                    VALUES ('\(book.title)', '\(book.author)', '\(book.description)', '\(book.publisher)', \(book.published), '\(book.coverImage)', \(book.availableCopies) )
                    """
                _ = try connection.query(query).wait()
                
                fetchBooksAndLoans()
                filteredBooks = books
            } catch {
                self.errorMessage = IdentifiableError(message: error.localizedDescription)
            }
        }
    
    func filterBooks() {
        if searchQuery.isEmpty {
            filteredBooks = books
        } else {
            filteredBooks = books.filter { $0.title.lowercased().contains(searchQuery.lowercased()) || $0.author.lowercased().contains(searchQuery.lowercased()) }
        }
    }
}

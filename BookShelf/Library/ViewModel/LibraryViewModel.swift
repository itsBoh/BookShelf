//
//  LibraryViewModel.swift
//  BookShelf
//
//  Created by Alvin Lionel on 29/12/24.
//

import Foundation
import MySQLNIO
import NIO

class LibraryViewModel: ObservableObject {
    
    @Published var books: [Book] = []
    @Published var filteredBooks: [Book] = []
    
    @Published var searchQuery: String = ""
    
    func fetchBooks() {
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
        } catch {
            print("Failed to fetch books: \(error)")
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

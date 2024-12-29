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

    func fetchBooks() {
        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        do {
            var tlsConfiguration = TLSConfiguration.makeClientConfiguration()
            tlsConfiguration.certificateVerification = .none

            let connection = try MySQLConnection.connect(
                to: .init(ipAddress: "127.0.0.1", port: 3306),
                username: "root",
                database: "bookshelf",
                password: "",
                tlsConfiguration: tlsConfiguration, 
                on: eventLoopGroup.next()
            ).wait()
            
            defer {
                try? connection.close().wait()
                try? eventLoopGroup.syncShutdownGracefully()
            }

            let rows = try connection.query("SELECT bookID, bookTitle, bookAuthor, bookDescription, bookPublisher, bookPublished, bookAvailableCopies, bookCoverImage FROM books").wait()
            self.books = rows.map { row in
                let id = row.column("bookID")?.uuid ?? UUID()
                let title = row.column("bookTitle")?.string ?? ""
                let author = row.column("bookAuthor")?.string ?? ""
                let description = row.column("bookDescription")?.string ?? ""
                let publisher = row.column("bookPublisher")?.string ?? ""
                let published = row.column("bookPublished")?.int
                let availableCopies = row.column("bookAvailableCopies")?.int
                let coverImage = row.column("bookCoverImage")?.string ?? ""
                return Book(id: id, title: title, author: author, description: description, publisher: publisher, published: published, coverImage: coverImage, availableCopies: availableCopies)
            }
        } catch {
            print("Failed to fetch books: \(error)")
        }
    }
}

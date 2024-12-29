//
//  BookModel.swift
//  BookShelf
//
//  Created by Alvin Lionel on 29/12/24.
//

import Foundation

struct Book: Identifiable {
    let id: UUID
    let title: String
    let author: String
    let description: String?
    let publisher: String
    let published: Int?
    let coverImage: String?
    let availableCopies: Int?
}

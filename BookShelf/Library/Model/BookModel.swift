//
//  BookModel.swift
//  BookShelf
//
//  Created by Alvin Lionel on 29/12/24.
//

import Foundation

struct Book: Identifiable {
    var id: String
    var title: String
    var author: String
    var description: String
    var publisher: String
    var published: Int
    var coverImage: String
    var availableCopies: Int
}

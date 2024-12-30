//
//  LoanModel.swift
//  BookShelf
//
//  Created by Alvin Lionel on 30/12/24.
//

import Foundation

struct Loan: Identifiable {
    var id: String
    var bookID: String
    var accountID: String
    var accountUserName: String
}

struct LoanModel: Identifiable{
    let id: String
    let bookId: String
    let userId: String
        let userName: String
        let bookTitle: String
        let bookAuthor: String
        let bookPublisher: String
        let bookPublished: Int
        let loanDate: Date
        let loanDueDate: Date
        let loanReturnDate: Date?
}

//
//  AccountModel.swift
//  BookShelf
//
//  Created by Alvin Lionel on 30/12/24.
//

import Foundation

struct Account: Identifiable {
    let id: UUID
    let userName: String
    let name: String
    let type: String
    let phoneNumber: String
}

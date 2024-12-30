//
//  IdentifiableError.swift
//  BookShelf
//
//  Created by Alvin Lionel on 30/12/24.
//

import Foundation

struct IdentifiableError: Identifiable {
    let id = UUID()
    let message: String
}
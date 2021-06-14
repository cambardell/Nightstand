//
//  BookViewModel.swift
//  Footnote+
//
//  Created by Cameron Bardell on 2021-06-13.
//

import Foundation
import SwiftUI

// ObservableObject for creating a new book or updating an existing one.

class BookViewModel: ObservableObject, Equatable {
    static func == (lhs: BookViewModel, rhs: BookViewModel) -> Bool {
        return (lhs.id == rhs.id) && (lhs.title == rhs.title) && (lhs.author == rhs.author) && (lhs.status == rhs.status)
    }

    @Published var title = ""
    @Published var author = ""
    @Published var status: BookState = .wishlist
    @Published var id = UUID()
    @Published var dateCreated = Date()

    init(_ book: Book?) {
        if let book = book {
            title = book.title ?? "Title"
            author = book.author ?? "Author"
            status = BookState(rawValue: book.status) ?? .wishlist
            id = book.id
            dateCreated = book.dateCreated ?? Date()
        }

    }

}

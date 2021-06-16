//
//  QuoteViewModel.swift
//  Footnote+
//
//  Created by Cameron Bardell on 2021-06-16.
//

import Foundation
import SwiftUI

// ObservableObject for creating a new quote or updating an existing one.

class QuoteViewModel: ObservableObject {

    @Published var text = ""
    @Published var dateCreated = Date()
    @Published var book: Book

    init(quote: Quote?, ownerBook: Book) {
        if let quote = quote {
            text = quote.text ?? "Text"
            dateCreated = quote.dateCreated ?? Date()

        }
        book = ownerBook
    }

}

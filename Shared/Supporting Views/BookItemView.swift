//
//  BookItemView.swift
//  Footnote+
//
//  Created by Cameron Bardell on 2020-12-30.
//

import SwiftUI
import CoreData

struct BookItemView: View {
    @ObservedObject var book: Book
    
    var body: some View {
        HStack {
            Label("\(book.title ?? "title") by \(book.author ?? "author")", systemImage: "book")
                .foregroundColor(Color(UIColor(hex: book.colorAsHex ?? "000000")))
            Spacer()
        }
    }
}

struct BookItemView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Title"
        book.dateCreated = Date()
        return BookItemView(book: book).frame(width: 300, height: 50)
    }
}

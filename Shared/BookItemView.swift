//
//  BookItemView.swift
//  Footnote+
//
//  Created by Cameron Bardell on 2020-12-30.
//

import SwiftUI

struct BookItemView: View {
    var book: Book
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(book.title ?? "Title").font(.title)
                Text("by Author").font(.headline)
            }
            Spacer()
        }.padding(5)
        
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

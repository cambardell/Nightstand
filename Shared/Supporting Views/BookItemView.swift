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
            RoundedRectangle(cornerRadius: 5.0).frame(width: 30)
                .foregroundColor(Color(UIColor.random()))
            VStack(alignment: .leading) {
                Text(book.title ?? "Title")
                Text(book.author ?? "Author").font(.callout)
            }
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

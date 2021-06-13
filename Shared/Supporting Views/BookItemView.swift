//
//  BookItemView.swift
//  Footnote+
//
//  Created by Cameron Bardell on 2020-12-30.
//

import SwiftUI
import CoreData

struct BookItemView: View {
    var book: Book
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 5.0).frame(width: 30)
                .foregroundColor(Color(UIColor.random()))
            VStack(alignment: .leading) {
                Text(book.title ?? "Title")
                Text("by Author").font(.callout)
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

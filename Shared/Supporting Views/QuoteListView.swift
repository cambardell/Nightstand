//
//  QuoteListView.swift
//  Footnote+
//
//  Created by Cameron Bardell on 2021-01-01.
//

import SwiftUI
import CoreData

struct QuoteListView: View {
    
    var bookQuotes: [Quote]
    var book: Book
    let persistenceController = PersistenceController.shared
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack(alignment: .leading) {
            List(bookQuotes, id: \.self) { quote in
                QuoteItemView(quote: quote)
            }
            
        }
    }
    

}

struct QuoteItemView: View {
    @ObservedObject var quote: Quote

    var body: some View {
        Text(quote.text ?? "text")
    }
}

struct QuoteListView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Title"
        book.dateCreated = Date()
        return QuoteListView(bookQuotes: book.quoteArray, book: book)
    }
}

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
                QuoteItemView(book: book, quote: quote, quoteViewModel: QuoteViewModel(quote: quote, ownerBook: book))

            }.listStyle(.automatic)

        }

    }

}

struct QuoteItemView: View {
    let persistenceController = PersistenceController.shared
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.scenePhase) var scenePhase

    var book: Book
    @ObservedObject var quote: Quote
    @State var quoteViewModel: QuoteViewModel
    @State var showAddQuote = false

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(quoteViewModel.text)
                Divider()
            }
            Spacer()
        }
        .onTapGesture {
            showAddQuote.toggle()
        }
        .sheet(isPresented: $showAddQuote, onDismiss: {

        }) {
            AddQuoteView(book: book, showAddQuoteView: $showAddQuote, existingQuote: quote)
        }
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

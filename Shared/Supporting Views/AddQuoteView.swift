//
//  AddQuoteView.swift
//  Footnote+
//
//  Created by Cameron Bardell on 2021-06-16.
//

import SwiftUI
import CoreData

struct AddQuoteView: View {

    let persistenceController = PersistenceController.shared
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject var quoteViewModel: QuoteViewModel
    var showAddQuote: Binding<Bool>

    var existingQuote: Quote?

    init(book: Book, showAddQuoteView: Binding<Bool>, existingQuote: Quote?) {
        if let givenQuote = existingQuote {
            quoteViewModel = QuoteViewModel(quote: givenQuote, ownerBook: book)
            self.existingQuote = existingQuote
        } else {
            quoteViewModel = QuoteViewModel(quote: nil, ownerBook: book)
        }

        showAddQuote = showAddQuoteView
    }

    var body: some View {
        NavigationView {
            Form {
                TextEditor(text: $quoteViewModel.text)

            }
            .navigationTitle("Add a new quote")

        }
        .safeAreaInset(edge: .bottom, content: {
            Button(action: saveQuote) {
                Label("Save", systemImage: "text.quote")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            .padding()
            .tint(.accentColor)
        })
    }

    func saveQuote() {
        if let quote = existingQuote {
            quote.dateCreated = quoteViewModel.dateCreated
            quote.text = quoteViewModel.text
            quote.book = quoteViewModel.book
        } else {
            let quote = Quote(context: persistenceController.container.viewContext)

            quote.dateCreated = quoteViewModel.dateCreated
            quote.text = quoteViewModel.text
            quote.book = quoteViewModel.book
            quoteViewModel.book.addToQuote(quote)
        }


        do {
            try viewContext.save()
            showAddQuote.wrappedValue.toggle()
        } catch {
            print("Not saved")
        }
    }
}

struct AddQuoteView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Title"
        book.dateCreated = Date()
        let quote = Quote(context: moc)
        quote.text = "Text"
        quote.dateCreated = Date()
        return Group {
            AddQuoteView(book: book, showAddQuoteView: .constant(true), existingQuote: nil)
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}

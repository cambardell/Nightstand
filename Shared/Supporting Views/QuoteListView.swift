//
//  QuoteListView.swift
//  Footnote+
//
//  Created by Cameron Bardell on 2021-01-01.
//

import SwiftUI

struct QuoteListView: View {
    
    var bookQuotes: [Quote]
    var book: Book
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack {
            HStack {
                Text("Quote List").font(.title)
                Spacer()
                
                Button(action: {
                    AddQuote()
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.footnoteRed)
                }
            }
            VStack {
                ForEach(bookQuotes, id: \.self) { quote in
                    Text(quote.text ?? "text")
                }
            }
            Spacer()
        }
    }
    
    private func AddQuote() {
        withAnimation {
            let newItem = Quote(context: viewContext)
            newItem.dateCreated = Date()
            newItem.book = book
            
            do {
                try viewContext.save()
                
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
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

//
//  BookDetailView.swift
//  Footnote+
//
//  Created by Cameron Bardell on 2020-12-27.
//

import SwiftUI
import CoreData

struct BookDetailView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    var book: Book
    @State var bookViewModel: BookViewModel
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $bookViewModel.title)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.title2)
                    .onChange(of: bookViewModel.title) { newValue in
                        updateBookTitle(title: newValue)
                    }


                TextField("Author", text: $bookViewModel.author)
                    .font(.title3)
                    .textFieldStyle(PlainTextFieldStyle())

                Picker("Status", selection: $bookViewModel.status) {
                    ForEach(BookState.allCases, id: \.self) {
                        Text($0.stringValue)
                    }
                }
                .pickerStyle(.automatic)
            }
                .onChange(of: bookViewModel.author, perform: updateBookAuthor)
                .onChange(of: bookViewModel.status, perform: updateBookStatus)
            
            Section(header: Text("Quotes")) {
                if let book = book {
                    QuoteListView(bookQuotes: book.quoteArray, book: book)
                }
            }

        }.safeAreaInset(edge: .bottom) {
            Button(action: AddQuote) {
                Label("Add Quote", systemImage: "text.quote")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            .padding()
            .tint(.accentColor)
        }


    }

    private func updateBookTitle(title: String) {
        book.title = title

        do {
            try viewContext.save()
            print("saved")

        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    private func updateBookAuthor(author: String) {
        book.author = author

        do {
            try viewContext.save()
            print("saved")

        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    private func updateBookStatus(status: BookState) {
        book.status = status.rawValue

        do {
            try viewContext.save()
            print("saved")

        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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



struct BookDetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Title"
        book.dateCreated = Date()
        return Group {
            BookDetailView(book: book, bookViewModel: BookViewModel(book))
        }
    }
}



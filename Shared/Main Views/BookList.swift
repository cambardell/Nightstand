//
//  ContentView.swift
//  Shared
//
//  Created by Cameron Bardell on 2020-12-27.
//

import SwiftUI
import CoreData

struct BookList: View {
    let persistenceController = PersistenceController.shared
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var selectedBook: Book?
    @State var searchText = ""
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Book.dateCreated, ascending: false)],
        animation: .default)
    private var books: FetchedResults<Book>
    
    var body: some View {

        NavigationView {
            VStack {
                List(books, selection: $selectedBook) { book in
                    NavigationLink(destination: BookDetailView(selectedBook: $selectedBook, title: selectedBook?.title ?? "Title", status: (BookState(rawValue: Int16(book.status))!)), tag: book, selection: $selectedBook) {
                        BookItemView(book: book)


                    }.swipeActions {
                        Button(role: .destructive) {
                            deleteItem(books: [book])
                        } label: {
                            Label("Delete", systemImage: "xmark.bin")
                        }
                    }

                }
                .searchable(text: $searchText)

                Button(action: addItem) {
                    Label("Add Book", systemImage: "plus")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                .controlProminence(.increased)
                .padding()
                .background(.thinMaterial)
            }.navigationTitle("Books")
                .ignoresSafeArea()

        }

    }
    
    private func deleteItem(books: [Book]) {
        withAnimation {
            books.forEach(viewContext.delete)
            
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

    private func addItem() {
        withAnimation {
            let newItem = Book(context: persistenceController.container.viewContext)
            newItem.dateCreated = Date()
            newItem.id = UUID()
            

            do {
                try persistenceController.container.viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Title"
        book.dateCreated = Date()
        return BookList(selectedBook: .constant(book)).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

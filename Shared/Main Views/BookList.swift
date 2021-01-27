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
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Book.dateCreated, ascending: false)],
        animation: .default)
    private var books: FetchedResults<Book>
    
    var body: some View {
        
        NavigationView {
            List(selection: $selectedBook) {
                ForEach(books) { book in
                    VStack {
                        NavigationLink(destination: BookDetailView(selectedBook: $selectedBook, title: selectedBook?.title ?? "Title", status: (BookState(rawValue: Int16(book.status))!)), tag: book, selection: $selectedBook) {
                            BookItemView(book: book)
                            
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(PlainListStyle())
            .toolbar {
                HStack {
                    #if os(iOS)
                    EditButton()
                    #endif

                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }

            }
        }

    }
    
    private func deleteItems(offsets: IndexSet) {
        print(offsets)
        withAnimation {
            offsets.map { books[$0] }.forEach(viewContext.delete)
            
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
        return BookList(selectedBook: .constant(book)).environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
